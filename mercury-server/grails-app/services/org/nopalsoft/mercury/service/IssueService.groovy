package org.nopalsoft.mercury.service

import org.nopalsoft.mercury.workflow.Action
import org.nopalsoft.mercury.workflow.Workflow
import org.springframework.util.Assert
import org.nopalsoft.mercury.domain.*
import org.apache.commons.lang.time.DateUtils

class IssueService {

   boolean transactional = true

   def sessionFactory
   def springSecurityService
   def mailService
   def groovyPageRenderer

   public boolean newIssue(Issue issue) {
      issue.lastUpdated = issue.date = new Date()

      issue.status = Status.findByCode(Workflow.initialStatus)

      // obtiene el codigo generado.
      Integer lastId = issue.project.lastIssueId ?: 0
      issue.code = issue.project.code + "-" + String.valueOf((lastId + 1))

      issue.project.lastIssueId = lastId + 1

      if (!issue.validate()) {
         return false
      }

      User createdBy = User.get(springSecurityService.principal.id)

      if (!issue.save(flush: true)) {
         return false
      }

      issue.project.save(flush: true)

      def conversation = new Conversation()
      conversation.save(flush: true)

      def comment = new IssueComment(issue, "create")
      comment.user = createdBy
      comment.content = ''
      conversation.addToComments(comment)
      conversation.save(flush: true)

      issue.conversation = conversation

      if(!issue.save(flush: true)){
         return false
      }

//    logIssue(issue, null);
      User lead = issue.project.lead
      def usersToSend = []
      // agregamos al lead siempre y cuando no sea el que crea la incidencia
      if (!lead.equals(createdBy))
         usersToSend << lead
      // agregamos al assignee siempre y cuando no sea el que crea la incidencia y no sea el lead
      if (issue.assignee != null && !issue.assignee.equals(createdBy))
         usersToSend << issue.assignee

      if (issue.watchers) {
          usersToSend.addAll(issue.watchers.asList())
      }

      usersToSend.unique().each {User user ->
         try {
            mailService.sendMail {
               to user.email
               subject "[NUEVA $issue.code] $issue.summary"
               body view: "/emails/newIssue", model: [issue: issue, createdBy: createdBy]
            }
         } catch (Exception ex) {
            println ex
         }
      }
      return true
   }

   public void saveIssue(Issue issue) {
      saveIssue issue, "", ""
   }

   public void saveIssue(Issue issue, String comment, String action) {
      issue.lastUpdated = new Date()

      User editedBy = User.get(springSecurityService.principal.id)
      def usersToSend = (issue.watchers ?: []) + issue.reporter

      usersToSend.unique().findAll { it.id != editedBy.id }.each {User user ->
         try {
            mailService.sendMail {
               to user.email
               subject "Incidencia Editada. [$issue.code] $issue.summary"
               body view: "/emails/editedIssue", model: [issue: issue, editedBy: editedBy, comment: comment]
            }
         } catch (Exception ex) {
            println ex
         }
      }

      logIssue(issue, comment, action)

      issue.save(flush: true)
   }

   public void closeIssue(Issue issue, String comment) {
      issue.status = Status.findByCode('closed')
      saveIssue(issue, comment, 'close')
   }

   public void reassignIssue(Issue issue, String assignee, String comment) {
      reassignIssue(issue, User.findByUsername(assignee), comment);
   }

   public void reassignIssue(Issue issue, User assignee, String comment) {
      Assert.notNull(issue, "El issue es nulo");

      // Log changes and add comment
      issue.setLastUpdated(new Date());

      issue.assignee = assignee;

      logIssue(issue, comment, 'assign');
      issue.save();

      User assignedBy = User.get(springSecurityService.principal.id)

      def usersToSend = []
      if (!assignedBy.equals(assignee))
         usersToSend << assignee
      usersToSend.addAll(issue.watchers.asList())

      usersToSend.unique().each {User user ->
         try {
            mailService.sendMail {
               to user.email
               subject "[$issue.code] $issue.summary"
               body view: "/emails/assignIssue", model: [issue: issue, createdBy: assignedBy, comment: comment]
            }
         } catch (Exception ex) {
            ex.printStackTrace();
            // no hacemos nada
         }
      }
   }

   public void resolveIssue(Issue issue, Resolution resolution, String comment) {
      resolveIssue(issue, resolution, comment, null);
   }

   public void resolveIssue(Issue issue, Resolution resolution, String comment, List<User> usersToNotify) {
      // obtiene el nuevo estado del workflow
      issue.status = Status.findByCode(Workflow.getNextStatus(issue.status.code, Action.RESOLVE))

      issue.lastUpdated = new Date()
      issue.resolution = resolution
      issue.dateResolved = new Date()

      // si se resuelve una incidencia esntonces la asigna al reoporter
      issue.assignee = issue.reporter

      logIssue(issue, comment, 'resolve')
      issue.save(flush: true)

      // agrega a el usuario que reporto si es que no viene en la lista previa.
      boolean addReporter = true
      if (usersToNotify == null) {
         usersToNotify = new ArrayList<User>()
      }
      for (User user: usersToNotify) {
         if (user.equals(issue.reporter)) {
            addReporter = false
         }
      }

      User currentUser = User.get(springSecurityService.principal.id)

      // verificamos que el que reporta la incidencia no sea el mismo que la resuelve, en este caso no tiene sentido
      // enviar notificacion
      if (addReporter && !currentUser.equals(issue.reporter))
         usersToNotify << issue.reporter

      usersToNotify.addAll(issue.watchers.asList())

      if (usersToNotify != null) {
         for (User user: usersToNotify.unique()) {
            try {
               mailService.sendMail {
                  to user.email
                  subject "[RESUELTA $issue.code] $issue.summary"
                  body view: "/emails/issueResolved", model: [issue: issue, resolution: resolution, comment: comment]
               }
            }
            catch (Exception ex) {
               // no hacemos nada
            }
         }
      }
   }
   
   public void remindStartIssue(Issue issue){
      def usersToNotify = []

      usersToNotify.add(issue.reporter)

      if(issue.assignee)
         usersToNotify.add(issue.assignee)

      usersToNotify.addAll(issue.watchers.asList())

      if (usersToNotify != null) {
         for (User user: usersToNotify.unique()) {
            try {
               def contents = groovyPageRenderer.render(view:"/emails/issueStart", model:[issue: issue])
               mailService.sendMail {
                  to user.email
                  subject "La tarea #${issue.code} esta programada para empezar hoy"
                  body contents
               }
            }
            catch (Exception ex) {
               ex.printStackTrace()
            }
         }
      }
   }

   private void logIssue(Issue issue, String message, String action) {
      def conversation = issue.conversation
      def comment = new IssueComment(issue, action)

      if(action == 'assign'){
         comment.relatedUser = issue.assignee
      }

      comment.content = message ?: ''

      //TODO: verificar si no viene de la session de hibernate
      def oldIssue = Issue.get(issue.id)

      def changes = getChanges(oldIssue, issue)

      if (changes) {
         comment.content += "\n\n" + changes.collect { c -> "**$c.property** cambio de **$c.originalValue** a **$c.newValue**" }.join("\n\n")
      }

      User user = User.get(springSecurityService.principal.id)
      comment.user = user;
      comment.save(flush: true)
      if(comment.errors){
         println comment.errors
      }

      conversation.addToComments(comment)
      conversation.save(flush:true)
   }

   private List<LogChange> getChanges(Issue oldIssue, Issue newIssue) {
      def changes = new ArrayList<LogChange>()
      if (!oldIssue.summary.equals(newIssue.summary)) {
         changes << new LogChange("summary", oldIssue.summary, newIssue.summary)
      }
//    if (oldIssue.getEnvironment() != null && !oldIssue.getEnvironment().equals(newIssue.getEnvironment())) {
      //      changes.add(new LogChange("environment", oldIssue.getEnvironment(), newIssue.getEnvironment()));
      //    }
      if (oldIssue.description != null && !oldIssue.description.equals(newIssue.description)) {
         changes << new LogChange("description", oldIssue.description, newIssue.description)
      }
      if (!oldIssue.status.equals(newIssue.status)) {
         changes << new LogChange("status", oldIssue.status.name, newIssue.status.name)
      }
      if (oldIssue.dueDate != null && (!oldIssue.dueDate.equals(newIssue.dueDate))) {
         changes << new LogChange("dueDate", oldIssue.dueDate.toString(), newIssue.dueDate.toString())
      }
      if (!oldIssue.issueType.equals(newIssue.issueType)) {
         changes << new LogChange("issueType", oldIssue.issueType.name, newIssue.issueType.name)
      }
//    if (oldIssue.resolution != null && !oldIssue.resolution.equals(newIssue.resolution)) {
      //      changes.add(new LogChange("resolution", oldIssue.getResolution().getName(), newIssue.getResolution().getName()));
      //    }
      if (!oldIssue.priority.equals(newIssue.priority)) {
         changes << new LogChange("priority", oldIssue.priority.name, newIssue.priority.name)
      }
      if (oldIssue.assignee != null && !oldIssue.assignee.equals(newIssue.assignee)) {
         changes << new LogChange("assignee", oldIssue.assignee.fullName, newIssue.assignee?.fullName)
      }
      if (!oldIssue.reporter.equals(newIssue.reporter)) {
         changes << new LogChange("reporter", oldIssue.reporter.fullName, newIssue.reporter.fullName)
      }
      return changes
   }

   public PomodoroSession startPomodoroSession(Issue issue){
      def pomodoroSession = new PomodoroSession()
      pomodoroSession.issue = issue
      pomodoroSession.dateStarted = new Date()
      User user = User.get(springSecurityService.principal.id)
      pomodoroSession.user = user
      pomodoroSession.save(flush:true)
      pomodoroSession
   }

   public void endPomodoroSession(PomodoroSession pomodoroSession){
      pomodoroSession.dateEnd = new Date()
      pomodoroSession.secondsElapsed = pomodoroSession.dateStarted - pomodoroSession.dateEnd
      println pomodoroSession.secondsElapsed
      pomodoroSession.completed = true
      pomodoroSession.save(flush:true)
   }

   Object getActivities(User user) {
   }

   public List<Issue> getIssuesScheduledForToday(){
      return Issue.findAll("from Issue issue where issue.startDate <= ?", [DateUtils.truncate(new Date(), Calendar.DATE)])
   }
}
