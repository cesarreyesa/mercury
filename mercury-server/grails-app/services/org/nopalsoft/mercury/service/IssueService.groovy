package org.nopalsoft.mercury.service

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Issue
import org.nopalsoft.mercury.domain.User
import org.hibernate.criterion.DetachedCriteria
import org.hibernate.criterion.Restrictions
import org.hibernate.criterion.Disjunction
import org.hibernate.criterion.MatchMode

import org.springframework.orm.hibernate3.HibernateTemplate
import org.hibernate.criterion.Projections
import org.nopalsoft.mercury.domain.Status
import org.springframework.util.Assert
import org.nopalsoft.mercury.domain.IssueLog
import org.nopalsoft.mercury.domain.LogChange
import org.nopalsoft.mercury.workflow.Workflow
import org.nopalsoft.mercury.domain.Resolution
import org.nopalsoft.mercury.workflow.Action
import org.nopalsoft.mercury.domain.IssueFilter
import org.hibernate.criterion.Order
import org.nopalsoft.mercury.domain.GroupBy

class IssueService {

  boolean transactional = true

  def sessionFactory
  def springSecurityService
  def mailService

  public Integer getTotalIssues(Project project) {
    return Issue.executeQuery("select count(*) from Issue where project = ?", [project])[0];
  }

  public Integer getTotalIssues(Project project, String status) {
    return Issue.executeQuery("select count(*) from Issue where project = ? and status.code = ?", [project, status] as Object[])[0];
  }

  public List<Map> getProjectStatusByType(Project project) {
    return Issue.executeQuery("select new map(issueType as type, count(*) as count) from Issue issue where issue.project = ? group by issue.issueType", project)[0];
  }

  public List<Map> getProjectStatusByAssignee(Project project) {
    return Issue.executeQuery("select new map(assignee as assignee, count(*) as count) from Issue issue where issue.project = ? group by issue.assignee", project)[0]
  }

  public List<Map> getProjectStatusByPriority(Project project, String status) {
    return Issue.executeQuery("""select new map(priority as priority, count(*) as count)
                                    from Issue issue where issue.project = ? and issue.status.code = ? group by issue.priority""", [project, status])
  }

  public List<Map> getProjectStatusByStatus(Project project) {
    return Issue.executeQuery("select new map(status as status, count(*) as count) from Issue issue where issue.project = ? group by issue.status", project)
  }
//
//  public List<Map> getProjectStatusByType(Project project, String status) {
//    String hql = "select new map(issueType as type, count(*) as count) from Issue issue where issue.project = ? and issue.status.code = ? group by issue.issueType";
//    return entityManager.find(hql, [project, status]);
//  }
//

  public List<Map> getProjectStatusByAssignee(Project project, String status) {
    String hql = "select new map(assignee as assignee, count(*) as count) from Issue issue where issue.project = ? and issue.status.code = ? group by issue.assignee";
    return Issue.executeQuery(hql, [project, status]);
  }
//
//  public List<Map> getProjectStatusByPriority(Project project, String status) {
//    String hql = "select new map(priority as priority, count(*) as count) from Issue issue where issue.project = ? and issue.status.code = ? group by issue.priority";
//    Object[] objects = [project, status]
//    return entityManager.find(hql, objects);
//  }
//

  public List<Map> getOpenIssuesByPriority(Project project, User user) {
    String hql = "select new map(priority as priority, count(*) as count) from Issue issue where issue.project = ? and issue.status.code = 'open' and issue.assignee.id = ? group by issue.priority";
    return Issue.executeQuery(hql, [project, user.id]);
  }

  public List<Issue> getIssues(Project project, String query, String type, IssueFilter filter, String statusDate, String from, String until, int offset, int maxResults) {
    DetachedCriteria crit = createCriteria(project, query, type, filter, statusDate, true)

    def hibernateTemplate = new HibernateTemplate(sessionFactory)
    return (List<Issue>) hibernateTemplate.findByCriteria(crit, offset, maxResults);
  }

  public int getIssuesCount(Project project, String query, String type, IssueFilter filter, String statusDate, String from, String until) {
    DetachedCriteria crit = createCriteria(project, query, type, filter, statusDate, false)
    crit.setProjection(Projections.rowCount())
    def hibernateTemplate = new HibernateTemplate(sessionFactory)
    def list = hibernateTemplate.findByCriteria(crit)
    return (int) list[0];
  }

  private DetachedCriteria createCriteria(Project project, String query, String type, IssueFilter filter, String statusDate, boolean addSort) {
    DetachedCriteria crit = DetachedCriteria.forClass(Issue.class);
    if (project != null) {
      crit.add(Restrictions.eq("project", project));
    }
    if (query) {
      Disjunction disjunction = Restrictions.disjunction();
      disjunction.add(Restrictions.like("code", query.toLowerCase(), MatchMode.ANYWHERE).ignoreCase());
      disjunction.add(Restrictions.like("summary", query.toLowerCase(), MatchMode.ANYWHERE).ignoreCase());
      disjunction.add(Restrictions.like("description", query.toLowerCase(), MatchMode.ANYWHERE).ignoreCase());
      crit.add(disjunction);
    }

    if (type) {
      if (type.indexOf(",") > 0) {
        Disjunction disjunction = Restrictions.disjunction();
        DetachedCriteria statusCrit = crit.createCriteria("issueType");
        String[] types = type.split(",");
        for (String t: types) {
          disjunction.add(Restrictions.like("code", t.toLowerCase(), MatchMode.ANYWHERE).ignoreCase());
        }
        statusCrit.add(disjunction);
      } else {
        crit.createCriteria("issueType").add(Restrictions.like("code", type.toLowerCase(), MatchMode.ANYWHERE).ignoreCase());
      }
    }

    if (filter.priority) {
      if (filter.priority.indexOf(",") > 0) {
        Disjunction disjunction = Restrictions.disjunction();
        DetachedCriteria statusCrit = crit.createCriteria("priority");
        String[] priorities = filter.priority.split(",");
        for (String p: priorities) {
          disjunction.add(Restrictions.like("code", p.toLowerCase(), MatchMode.ANYWHERE).ignoreCase());
        }
        statusCrit.add(disjunction);
      } else {
        crit.createCriteria("priority").add(Restrictions.like("code", filter.priority.toLowerCase(), MatchMode.ANYWHERE).ignoreCase());
      }
    }

    if (filter.status) {
      if (filter.status.indexOf(",") > 0) {
        Disjunction disjunction = Restrictions.disjunction();
        DetachedCriteria statusCrit = crit.createCriteria("status");
        String[] statuses = filter.status.split(",");
        for (String statusS: statuses) {
          disjunction.add(Restrictions.like("code", statusS.toLowerCase(), MatchMode.ANYWHERE).ignoreCase());
        }
        statusCrit.add(disjunction);
      } else {
        crit.createCriteria("status").add(Restrictions.like("code", filter.status.toLowerCase(), MatchMode.ANYWHERE).ignoreCase());
      }
    }

    if (filter.reporter) {
      if (filter.reporter.startsWith("!")) {
        crit.createCriteria("reporter").add(Restrictions.ne("username", filter.reporter.substring(1)));
      } else {
        crit.createCriteria("reporter").add(Restrictions.eq("username", filter.reporter));
      }
    }

    if (filter.assignee) {
      if (filter.assignee.equals("null")) {
        crit.add(Restrictions.isNull("assignee"));
      } else if (filter.assignee.equals("!null")) {
        crit.add(Restrictions.isNotNull("assignee"));
      } else if (filter.assignee.startsWith("!")) {
        crit.createCriteria("assignee").add(Restrictions.ne("username", filter.assignee.substring(1)));
      } else {
        crit.createCriteria("assignee").add(Restrictions.eq("username", filter.assignee));
      }
    }

    Date now = new Date();
    Date dateFrom = now;
    Date dateUntil = now;

//      if(from){
//          dateFrom = DateUtils.fromSmartDate(from);
//      }
//      if(StringUtils.isNotBlank(until)){
//          dateUntil = DateUtils.fromSmartDate(until);
//      }

    if (statusDate && "resolved".equals(statusDate.toLowerCase())) {
      crit.add(Restrictions.between("dateResolved", dateFrom, dateUntil));
    }
    if (statusDate && "closed".equals(statusDate.toLowerCase())) {
      crit.add(Restrictions.between("dateClosed", dateFrom, dateUntil));
    }

    if(filter.groupBy && addSort){
      if(filter.groupBy == GroupBy.Priority){
        crit.addOrder(Order.asc("priority"))
      }
    }
    return crit
  }

  public boolean newIssue(Issue issue) {
    issue.lastUpdated = issue.date = new Date()

    issue.status = Status.findByCode(Workflow.initialStatus)

    // obtiene el codigo generado.
    Integer lastId = issue.project.lastIssueId ?: 0
    issue.code = issue.project.code + "-" + String.valueOf((lastId + 1))

    issue.project.lastIssueId = lastId + 1

    if(!issue.validate()){
      return false
    }

    if(!issue.save(flush: true)){
      return false
    }

    issue.project.save(flush:true)

//    logIssue(issue, null);
    User lead = issue.project.lead
    User createdBy = User.get(springSecurityService.principal.id)
    def usersToSend = []
    // agregamos al lead siempre y cuando no sea el que crea la incidencia
    if(!lead.equals(createdBy))
      usersToSend << lead
    // agregamos al assignee siempre y cuando no sea el que crea la incidencia y no sea el lead
    if(issue.assignee != null && !issue.assignee.equals(createdBy))
      usersToSend << issue.assignee

    //usersToSend.addAll(issue.watchers.asList())

    usersToSend.unique().each {User user ->
      println user.email
      try {
        mailService.sendMail {
          to user.email
          subject "[NUEVA $issue.code] $issue.summary"
          body view:"/emails/newIssue", model:[issue: issue, createdBy: createdBy]
        }
      } catch (Exception ex) {
        println ex
      }
    }
    return true
  }

  public void saveIssue(Issue issue){
    saveIssue issue, ""
  }

  public void saveIssue(Issue issue, String comment){
    issue.lastUpdated = new Date()

    logIssue(issue, comment)

    issue.save(flush:true)
  }

  public void reassignIssue(Issue issue, String assignee, String comment) {
    reassignIssue(issue, User.findByUsername(assignee), comment);
  }

  public void reassignIssue(Issue issue, User assignee, String comment) {
    Assert.notNull(issue, "El issue es nulo");

    // Log changes and add comment
    issue.setLastUpdated(new Date());

    issue.setAssignee(assignee);

    logIssue(issue, comment);
    issue.save();

    User assignedBy = User.get(springSecurityService.principal.id)

    def usersToSend = []
    if(!assignedBy.equals(assignee))
      usersToSend << assignee
//    usersToSend.addAll(issue.watchers.asList())

    usersToSend.unique().each {User user ->
      try {
        mailService.sendMail {
          to user.email
          subject "[$issue.code] $issue.summary"
          body view:"/emails/assignIssue", model:[issue: issue, createdBy: assignedBy, comment: comment]
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

  public void resolveIssue(Issue issue, Resolution resolution, String comment, List<User> usersToNotificate) {
    // obtiene el nuevo estado del workflow
    issue.status = Status.findByCode(Workflow.getNextStatus(issue.status.code, Action.RESOLVE))

    issue.lastUpdated = new Date()
    issue.resolution = resolution
    issue.dateResolved = new Date()

    // si se resuelve una incidencia esntonces la asigna al reoporter
    issue.assignee = issue.reporter

    logIssue(issue, comment)
    issue.save(flush:true)

    // agrega a el usuario que reporto si es que no viene en la lista previa.
    boolean addReporter = true
    if (usersToNotificate == null) {
      usersToNotificate = new ArrayList<User>()
    }
    for (User user: usersToNotificate) {
      if (user.equals(issue.reporter)) {
        addReporter = false
      }
    }

    User currentUser = User.get(springSecurityService.principal.id)

    // verificamos que el que reporta la incidencia no sea el mismo que la resuelve, en este caso no tiene sentido
    // enviar notificacion
    if (addReporter && !currentUser.equals(issue.reporter))
      usersToNotificate << issue.reporter

//    usersToNotificate.addAll(issue.watchers.asList())

    if (usersToNotificate != null) {
      for (User user: usersToNotificate.unique()) {
        try {
          mailService.sendMail {
            to user.email
            subject "[RESUELTA $issue.code] $issue.summary"
            body view:"/emails/issueResolved", model:[issue: issue, resolution: resolution, comment: comment]
          }
        }
        catch (Exception ex) {
          // no hacemos nada
        }
      }
    }
  }

  private void logIssue(Issue issue, String comment) {
    def log = new IssueLog()

    // obtiene la incidencia actual y trae los cambios
//    def oldIssue = (Issue) entityManager.get(Issue.class, issue.getId(), true)
    def oldIssue = Issue.get(issue.id)

    def changes = getChanges(oldIssue, issue)
    if(changes) log.changes << changes

    log.date = new Date()

    // si existe un comentario lo agrega.
    if (comment != null) log.comment = comment

    // obtiene al usuario
    User user = User.get(springSecurityService.principal.id)
    log.user = user;
    log.issue = issue;

    if(!log.save(flush:true))
      println log.errors
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

  public List<Issue> getIssuesNotInMilestone(Project project) {
    return Issue.findAll("from Issue issue where issue.milestone is null and issue.project = :projectParam", [projectParam: project]);
  }


}
