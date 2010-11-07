package org.nopalsoft.mercury.service

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Issue
import org.nopalsoft.mercury.domain.User
import org.hibernate.criterion.DetachedCriteria
import org.hibernate.criterion.Restrictions
import org.hibernate.criterion.Disjunction
import org.hibernate.criterion.MatchMode
import org.hibernate.Criteria
import org.hibernate.SessionFactory
import org.springframework.orm.hibernate3.HibernateTemplate
import org.hibernate.criterion.Projections

class IssueService {

  boolean transactional = true

  def sessionFactory

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

  public List<Issue> getIssues(Project project, String query, String type, String status, String priority, String reporter, String assignee, String statusDate, String from, String until, int offset, int maxResults) {
    DetachedCriteria crit = createCriteria(project, query, type, priority, status, reporter, assignee, statusDate)

    def hibernateTemplate = new HibernateTemplate(sessionFactory)
    return (List<Issue>) hibernateTemplate.findByCriteria(crit, offset, maxResults);
  }

  public int getIssuesCount(Project project, String query, String type, String status, String priority, String reporter, String assignee, String statusDate, String from, String until) {
    DetachedCriteria crit = createCriteria(project, query, type, priority, status, reporter, assignee, statusDate)
    crit.setProjection(Projections.rowCount())
    def hibernateTemplate = new HibernateTemplate(sessionFactory)
    def list = hibernateTemplate.findByCriteria(crit)
    return (int) list[0];
  }

  private DetachedCriteria createCriteria(Project project, String query, String type, String priority, String status, String reporter, String assignee, String statusDate) {
    DetachedCriteria crit = DetachedCriteria.forClass(Issue.class);
    if (project != null) {
      crit.add(Restrictions.eq("project", project));
    }
    if (query) {
      Disjunction disjunction = Restrictions.disjunction();
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

    if (priority) {
      if (priority.indexOf(",") > 0) {
        Disjunction disjunction = Restrictions.disjunction();
        DetachedCriteria statusCrit = crit.createCriteria("priority");
        String[] priorities = priority.split(",");
        for (String p: priorities) {
          disjunction.add(Restrictions.like("code", p.toLowerCase(), MatchMode.ANYWHERE).ignoreCase());
        }
        statusCrit.add(disjunction);
      } else {
        crit.createCriteria("priority").add(Restrictions.like("code", priority.toLowerCase(), MatchMode.ANYWHERE).ignoreCase());
      }
    }

    if (status) {
      if (status.indexOf(",") > 0) {
        Disjunction disjunction = Restrictions.disjunction();
        DetachedCriteria statusCrit = crit.createCriteria("status");
        String[] statuses = status.split(",");
        for (String statusS: statuses) {
          disjunction.add(Restrictions.like("code", statusS.toLowerCase(), MatchMode.ANYWHERE).ignoreCase());
        }
        statusCrit.add(disjunction);
      } else {
        crit.createCriteria("status").add(Restrictions.like("code", status.toLowerCase(), MatchMode.ANYWHERE).ignoreCase());
      }
    }

    if (reporter) {
      if (reporter.startsWith("!")) {
        crit.createCriteria("reporter").add(Restrictions.ne("username", reporter.substring(1)));
      } else {
        crit.createCriteria("reporter").add(Restrictions.eq("username", reporter));
      }
    }

    if (assignee) {
      if (assignee.equals("null")) {
        crit.add(Restrictions.isNull("assignee"));
      } else if (assignee.equals("!null")) {
        crit.add(Restrictions.isNotNull("assignee"));
      } else if (assignee.startsWith("!")) {
        crit.createCriteria("assignee").add(Restrictions.ne("username", assignee.substring(1)));
      } else {
        crit.createCriteria("assignee").add(Restrictions.eq("username", assignee));
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
    return crit
  }
}
