package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Issue
import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.IssueLog
import org.nopalsoft.mercury.domain.IssueAttachment
import org.nopalsoft.mercury.domain.IssueFilter
import org.springframework.web.servlet.ModelAndView
import org.springframework.web.servlet.view.AbstractView
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import org.nopalsoft.mercury.domain.Resolution
import org.nopalsoft.mercury.domain.GroupBy
import grails.plugins.springsecurity.Secured
import org.nopalsoft.mercury.domain.Milestone
import org.nopalsoft.mercury.domain.MilestoneStatus
import grails.converters.JSON
import org.nopalsoft.mercury.domain.Conversation
import org.nopalsoft.mercury.domain.Comment
import org.nopalsoft.mercury.domain.PomodoroSession
import org.nopalsoft.mercury.domain.IssueComment

@Secured(['user', 'role_admin'])
class IssuesController {

   def issueService
   def issueSearchService
   def springSecurityService

   def index = {
      def user = User.get(springSecurityService.principal.id)
      def filters = issueSearchService.getFilters(user)
      def limit = params.int('max') ?: 50
      def start = params.int('offset') ?: 0
      def filterId = params.filter ? params.int('filter') : 1
      def filter = filters.find { it.id == filterId }
      def issues = issueSearchService.getIssues((Project) session.project, params.search, params.type, filter, "", "", "", start, limit)
      def issueGroups = [:]
      //refactorizar
      if (params.groupBy) {
         if (params.groupBy == 'priority')
            filter.groupBy = GroupBy.Priority
         if (params.groupBy == 'category')
            filter.groupBy = GroupBy.Category
         if (params.groupBy == 'type')
            filter.groupBy = GroupBy.Type
         if (params.groupBy == 'assignee')
            filter.groupBy = GroupBy.Assignee
         if (params.groupBy == 'reporter')
            filter.groupBy = GroupBy.Reporter
      }
      if (filter.groupBy == GroupBy.Priority) {
         def groups = issues.collect { it.priority }.unique()
         for (def group: groups) {
            issueGroups[message(code: "priority.${group.code}")] = issues.findAll { it.priority == group}
         }
      }
      if (filter.groupBy == GroupBy.Type) {
         def groups = issues.collect { it.issueType }.unique()
         for (def group: groups) {
            issueGroups[message(code: "issueType.${group.code}")] = issues.findAll { it.issueType == group}
         }
      }
      if (filter.groupBy == GroupBy.Category) {
         def groups = issues.collect { it.category }.unique()
         for (def group: groups) {
            issueGroups[group ?: 'Sin categoria'] = issues.findAll { it.category == group}
         }
      }
      if (filter.groupBy == GroupBy.Assignee) {
         def groups = issues.collect { it.assignee }.unique()
         for (def group: groups) {
            issueGroups[group] = issues.findAll { it.assignee == group}
         }
      }
      if (filter.groupBy == GroupBy.Reporter) {
         def groups = issues.collect { it.reporter }.unique()
         for (def group: groups) {
            issueGroups[group] = issues.findAll { it.reporter == group}
         }
      }
      //refactorizar
      def issuesCount = issueSearchService.getIssuesCount((Project) session.project, params.search, params.type, filter, "", "", "")

      [user: user, issues: issues, issueGroups: issueGroups, totalIssues: issuesCount, filters: filters, currentFilter: filter]
   }

   def view = {
      def issue = Issue.findByCode(params.id)
      if(issue && !issue.conversation){
         issue.conversation = new Conversation()
         issue.conversation.save(flush:true)
         issue.save(flush:true)
      }
      def pomodoros = PomodoroSession.findAllByIssueAndCompleted(issue, true)
      [issue: issue, pomodoros: pomodoros.size()]
   }

   def create = {
      def project = Project.get(session.project.id)
      def issue = new Issue()
      def user = User.get(springSecurityService.principal.id)
      issue.reporter = user
      if(params.parent){
         issue.parent = Issue.findByCode(params.parent);
      }
      def categories = org.nopalsoft.mercury.domain.Category.findAllByProject(project)
      def milestones = Milestone.findAll("from Milestone m where m.project = :projectParam and (m.status is null or m.status = :statusParam) order by m.startDate", [projectParam: project, statusParam: MilestoneStatus.OPEN])
      [issue: issue, project: project, categories: categories, milestones: milestones]
   }

   def newIssueWindow = {
      def project = Project.get(session.project.id)
      def issue = new Issue()
      def user = User.get(springSecurityService.principal.id)
      issue.reporter = user
      if(params.parent){
         issue.parent = Issue.findByCode(params.parent);
         issue.assignee = issue.parent.assignee
         issue.priority = issue.parent.priority
         issue.issueType = issue.parent.issueType
         issue.category = issue.parent.category
         issue.milestone = issue.parent.milestone
      }
      def categories = org.nopalsoft.mercury.domain.Category.findAllByProject(project)
      def milestones = Milestone.findAll("from Milestone m where m.project = :projectParam and (m.status is null or m.status = :statusParam) order by m.startDate", [projectParam: project, statusParam: MilestoneStatus.OPEN])
      [issue: issue, project: project, categories: categories, milestones: milestones]
   }

   def save = {
      if (request.isPost()) {
         def issue = new Issue()
         bindData issue, params, ['dueDate']
         issue.dueDate = params.dueDate ? Date.parse("dd/MM/yyyy", params.dueDate) : null

         if (issueService.newIssue(issue)) {

            def file = request.getFile('attachment')
            def fileName
            if (file && !file.empty && file.size < (1024 * 5000)) {
               def path = grailsApplication.config.attachmentsPath + issue.id + "/"
               new File(path).mkdirs()
               fileName = path + file.fileItem.fileName
               file.transferTo(new File(fileName))

               def attachment = new IssueAttachment(file.fileItem.fileName, params.attachmentDescription, User.get(springSecurityService.principal.id), new Date());
               issue.addToAttachments(attachment);
               issueService.saveIssue(issue, "<b>attachment</b> <i>" + file.fileItem.fileName + "</i> added<br/>" + attachment.description);

            } else {
               flash.warning = "No se agregaron los archivos adjuntos"
            }

            flash.message = "Se creo correctamente."
            redirect(action: 'view', params: [id: issue.code])
         }
         else {
            def project = Project.get(session.project.id)
            render(view: 'create', model: [issue: issue, project: project])
            return;
         }
      } else {
         render(view: 'create')
      }
   }

   def saveAjax = {
      if (request.isPost()) {
         def issue = new Issue()
         bindData issue, params, ['dueDate']
         issue.dueDate = params.dueDate ? Date.parse("dd/MM/yyyy", params.dueDate) : null
         if (issueService.newIssue(issue)) {
            flash.message = "Se creo correctamente."
            redirect(action: 'view', params: [id: issue.code])
         }
         else {
            def project = Project.get(session.project.id)
            render(view: 'create', model: [issue: issue, project: project])
            return;
         }
      } else {
         render(view: 'create')
      }
   }

   def edit = {
      def issue = Issue.findByCode(params.id)
      def categories = org.nopalsoft.mercury.domain.Category.findAllByProject(issue.project)
      def milestones = Milestone.findAll("from Milestone m where m.project = :projectParam and (m.status is null or m.status = :statusParam) order by m.startDate", [projectParam: issue.project, statusParam: MilestoneStatus.OPEN])
      [issue: issue, project: issue.project, categories: categories, milestones: milestones]
   }

   def saveEdit = {
      if (request.isPost()) {
         def issue = Issue.get(params.id)
         bindData issue, params, ['dueDate']
         if (params.dueDate)
            issue.dueDate = Date.parse("dd/MM/yyyy", params.dueDate)
         try {
            issueService.saveIssue(issue)
            flash.message = "Se creo correctamente."
            redirect(action: 'view', params: [id: issue.code])
         } catch (Exception ex) {
            def project = Project.get(session.project.id)
            render(view: 'edit', model: [issue: issue, project: project])
            return;
         }
      } else {
         render(view: '404')
      }
   }

   def assignIssue = {
      def issue = Issue.findByCode(params.id)
      issueService.reassignIssue issue, User.get(params.int('assignee.id')), params.assignComment
      flash.message = "Se asigno correctamente"
      redirect(action: 'view', params: [id: issue.code])
   }

   def closeIssue = {
      def issue = Issue.findByCode(params.id)
      issueService.closeIssue issue, params.closeComment
      flash.message = "Se cerro correctamente"
      redirect(action: 'view', params: [id: issue.code])
   }

//   def addComment = {
//      def issue = Issue.findByCode(params.id)
//      issueService.saveIssue issue, params.comment
//      flash.message = "Se asigno correctamente"
//      redirect(action: 'view', params: [id: issue.code])
//   }

   def addComment = {
      def conversation = Conversation.get(params.id)
      def issue = Issue.findByConversation(conversation)
      def comment = new IssueComment()
      comment.content = params.comment
      comment.user = User.get(springSecurityService.principal.id)
      comment.action = "comment"
      comment.issue = issue
      comment.project = issue.project
      conversation.addToComments(comment)
      conversation.save(flush:true)

      //messagesService.notifyComment(message, comment)

      redirect(url:params.url.replaceFirst(request.contextPath, ''))
   }


   def addAttachment = {
      def issue = Issue.findByCode(params.id)
      def file = request.getFile('file')
      def fileName
      if (file && !file.empty && file.size < (1024 * 5000)) {
         def path = grailsApplication.config.attachmentsPath + issue.getId().toString() + "/"
         new File(path).mkdirs()
         fileName = path + file.fileItem.fileName
         file.transferTo(new File(fileName))

         def attachment = new IssueAttachment(file.fileItem.fileName, params.description, User.get(springSecurityService.principal.id), new Date());
         issue.addToAttachments(attachment);
         issueService.saveIssue(issue, "<b>attachment</b> <i>" + file.fileItem.fileName + "</i> added<br/>" + attachment.description);

         flash.message = "Se agrego el attachment correctamente"
         redirect(action: 'view', params: [id: issue.code])

      } else {
         redirect(action: 'view', params: [id: issue.code])
      }
   }

   def showAttachment = {
      def attachment = IssueAttachment.get(params.attachmentId);
      def issue = Issue.get(params.id)

      return new ModelAndView({Map model, HttpServletRequest request, HttpServletResponse response ->
         def path = grailsApplication.config.attachmentsPath + issue.id.toString() + "/" + attachment.file;
         File f = new File(path)
         FileInputStream istr = new FileInputStream(f)
         BufferedInputStream bstr = new BufferedInputStream(istr)
         int size = (int) f.length()
         byte[] data = new byte[size]
         bstr.read(data, 0, size)
         bstr.close()
         response.setHeader("Content-Disposition", " filename=" + attachment.file)
         response.getOutputStream().write(data)
         response.getOutputStream().flush()
         response.getOutputStream().close()
      } as AbstractView)
   }

   def resolveIssue = {
      def issue = Issue.findByCode(params.id)
      def notifyUsers = []
      if (params.notifyTo) {
         def ids = params.notifyTo.tokenize(",").findAll { it.toString().trim() != "" }.collect { it.toLong()}
         notifyUsers = User.findAll("from User user where user.id in (:ids)", [ids:ids])
      }
      issueService.resolveIssue issue, Resolution.get(params.resolution), params.resolveComment, notifyUsers
      flash.message = "Se resolvio correctamente"
      redirect(action: 'view', params: [id: issue.code])
   }

   def startPomodoroSession = {
      def issue = Issue.findByCode(params.id)
      def pomodoroSession = issueService.startPomodoroSession(issue)
      render(contentType:"text/json"){
         success =  true
         pomodoroSessionId =  pomodoroSession.id
      }
   }

   def endPomodoroSession = {
      def pomodoroSession = PomodoroSession.get(params.id)
      issueService.endPomodoroSession(pomodoroSession)
      render(contentType:"text/json"){
         success =  true
      }
   }

   def users = {
      def project = Project.get(session.project.id)
      def user = User.get(springSecurityService.principal.id)
      def users = project.users
            .findAll{ it.enabled && it.id != user.id && (!params.term || it.fullName.toLowerCase().contains(params.term.toLowerCase()))  }
            .sort{ it.fullName }
      withFormat {
         json{
            render users.collect{ u ->
               [
                  value : u.id,
                  label: u.fullName
               ]
            } as JSON
         }
      }
   }

   def listAsXML = {
      def user = User.get(springSecurityService.principal.id)
      def limit = params.int('limit') ?: 20
      def start = params.int('start') ?: 0
      def issues = Issue.findAllByAssignee(user, [max: limit, offset: start])
      render(contentType: 'text/xml') {
         items(success: true) {
            totalCount(issues.size())
            for (def issue in issues) {
               item {
                  id(issue.id)
                  code(issue.code)
                  summary(issue.summary)
                  date(issue.date)
                  issueType {
                     name(issue.issueType.name)
                     icon(issue.issueType.icon)
                  }
                  assignee {
                     name(issue.assignee.fullName)
                  }
                  reporter {
                     name(issue.reporter.fullName)
                  }
                  priority {
                     name(issue.priority.name)
                  }
                  status {
                     name(issue.status.name)
                  }
               }
            }
         }
      }
   }
}
