package org.nopalsoft.mercury.service

import org.hibernate.criterion.Order
import org.nopalsoft.mercury.domain.GroupBy
import org.hibernate.criterion.Restrictions
import org.nopalsoft.mercury.utils.SmartDate
import org.nopalsoft.mercury.domain.IssueFilter
import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Issue
import org.hibernate.criterion.DetachedCriteria
import org.springframework.orm.hibernate3.HibernateTemplate
import org.hibernate.criterion.Projections
import org.hibernate.criterion.Disjunction
import org.hibernate.criterion.MatchMode
import org.nopalsoft.mercury.domain.Comment
import org.nopalsoft.mercury.domain.Status
import org.nopalsoft.mercury.domain.Milestone

class IssueSearchService {

   def sessionFactory
   def springSecurityService

   def getFilters = { user ->
      def filters = [
            new IssueFilter(id: 1, name: 'Mis Pendientes', status: 'open,progress', assignee: user.username, groupBy: GroupBy.Priority),
            new IssueFilter(id: 2, name: 'Abiertas recientemente', status: 'open,progress', createdFrom: '-2w', groupBy: GroupBy.Priority),
            new IssueFilter(id: 3, name: 'Mis Solicitudes Sin Resolver', status: 'open,progres', reporter: user.username, groupBy: GroupBy.Priority),
            new IssueFilter(id: 4, name: 'Pendientes', status: 'open,progress', groupBy: GroupBy.Priority),
            new IssueFilter(id: 5, name: 'En Progreso', status: 'progress', assignee: user.username, groupBy: GroupBy.Priority),
            new IssueFilter(id: 6, name: 'Pendientes sin asignar', status: 'open,progress', assignee: 'null', groupBy: GroupBy.Priority),
            new IssueFilter(id: 7, name: 'Resueltos', status: 'resolved', assignee: null, groupBy: GroupBy.Priority),
            new IssueFilter(id: 8, name: 'Resueltos / Cerrados', status: 'closed,resolved', assignee: null, groupBy: GroupBy.Priority),
            new IssueFilter(id: 9, name: 'Cerrados en la ultima semana', status: 'closed', groupBy: GroupBy.Priority),
            new IssueFilter(id: 10, name: 'Cerrados en la ultimas 2 semanas', status: 'closed', groupBy: GroupBy.Priority),
            new IssueFilter(id: 11, name: 'Todas', groupBy: GroupBy.Priority)
      ]
      filters
   }

   public List<Project> getProjectsForUser(User user){
      return Project.executeQuery("select distinct project from Project project join project.users as user where user.id = ? order by project.name", [user.id])
   }

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
      return getIssues([project], query, type, filter, statusDate, from, until, offset, maxResults)
   }

   public List<Issue> getIssues(List<Project> projects, String query, String type, IssueFilter filter, String statusDate, String from, String until, int offset, int maxResults) {
      DetachedCriteria crit = createCriteria(projects, query, type, filter, statusDate, true)

      def hibernateTemplate = new HibernateTemplate(sessionFactory)
      return (List<Issue>) hibernateTemplate.findByCriteria(crit, offset, maxResults);
   }

   public int getIssuesCount(Project project, String query, String type, IssueFilter filter, String statusDate, String from, String until) {
      return getIssuesCount([project], query, type, filter, statusDate, from, until)
   }

   public int getIssuesCount(List<Project> projects, String query, String type, IssueFilter filter, String statusDate, String from, String until) {
      DetachedCriteria crit = createCriteria(projects, query, type, filter, statusDate, false)
      crit.setProjection(Projections.rowCount())
      def hibernateTemplate = new HibernateTemplate(sessionFactory)
      def list = hibernateTemplate.findByCriteria(crit)
      return (int) list[0];
   }

   private DetachedCriteria createCriteria(List<Project> projects, String query, String type, IssueFilter filter, String statusDate, boolean addSort) {
      DetachedCriteria crit = DetachedCriteria.forClass(Issue.class);
      crit.add(Restrictions.isNull("parent"))
      if (projects != null) {
         crit.add(Restrictions.in("project", projects));
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

      if (filter.createdFrom || filter.createdUntil) {
         def until = new SmartDate().fromSmartDate(filter.createdUntil) ?: new Date()
         def from = new SmartDate().fromSmartDate(filter.createdFrom)
         crit.add(Restrictions.between("date", from, until))
      }
      if (statusDate && "resolved".equals(statusDate.toLowerCase())) {
         crit.add(Restrictions.between("dateResolved", dateFrom, dateUntil))
      }
      if (statusDate && "closed".equals(statusDate.toLowerCase())) {
         crit.add(Restrictions.between("dateClosed", dateFrom, dateUntil))
      }

      if (filter.groupBy && addSort) {
         if (filter.groupBy == GroupBy.Priority) {
            crit.addOrder(Order.asc("priority"))
         }
      }
      return crit
   }

   public List<Issue> getIssuesNotInMilestone(Project project, Status status, List orderByProperties) {
      return Issue.withCriteria {
         orderByProperties.each {order((String) it)}
         eq("project", project)
         isNull("milestone")
         eq("status", status)
         isNull("parent")
      }
   }

   public List<Issue> getIssues(Milestone milestone, Status status, List orderByProperties) {
      return Issue.withCriteria {
         orderByProperties.each {order((String) it)}
         eq("milestone", milestone)
         eq("status", status)
         isNull("parent")
      }
   }

   public List<Comment> getActivities(User user, Project project) {
      return Comment.findAllByProject(project)
   }
}
