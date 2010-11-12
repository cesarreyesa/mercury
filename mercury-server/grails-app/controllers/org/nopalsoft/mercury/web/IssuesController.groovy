package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Issue
import grails.converters.XML
import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.IssueType
import org.nopalsoft.mercury.domain.IssueLog

class IssueFilter{
  int id
  String status
  String priority
  String assignee
  String from
  String name
  String reporter
}

class IssuesController {

  def issueService
  def springSecurityService

  def index = {
    def user = User.get(springSecurityService.principal.id)
    def filters = [
            new IssueFilter(id:1, name: 'Mis Pendientes', status: 'open,progress', assignee: user.username),
            new IssueFilter(id:2, name: 'Mis Solicitudes Sin Resolver', status: 'open,progres', reporter: user.username),
            new IssueFilter(id:3, name: 'Pendientes', status: 'open,progress'),
            new IssueFilter(id:4, name: 'En Progreso', status: 'progress', assignee: user.username),
            new IssueFilter(id:5, name: 'Pendientes sin asignar', status: 'open,progress', assignee: 'null'),
            new IssueFilter(id:6, name: 'Resueltos / Cerrados', status: 'closed,resolved', assignee: user.username),
            new IssueFilter(id:7, name: 'Cerrados en la ultima semana', status: 'closed', assignee: '-1w'),
            new IssueFilter(id:8, name: 'Cerrados en la ultimas 2 semanas', status: 'closed', assignee: '-1w'),
            new IssueFilter(id:9, name: 'Todas')
    ]
    def limit = params.int('max') ?: 20
    def start = params.int('offset') ?: 0
    def filterId = params.filter ? params.int('filter') : 1
    def filter = filters.find { it.id == filterId }
    def issues = issueService.getIssues((Project) session.project, params.query, params.type, filter.status, filter.priority, filter.reporter, filter.assignee, "", "", "", start, limit)
    def issuesCount = issueService.getIssuesCount((Project) session.project, params.query, params.type, filter.status, filter.priority, filter.reporter, filter.assignee, "", "", "")

    [user: user, issues: issues, totalIssues: issuesCount, filters: filters, currentFilter: filter]
  }

  def view = {
    def issue = Issue.findByCode(params.id)
    [issue: issue, logs: IssueLog.findAllByIssue(issue)]
  }

  def create = {
    def project = Project.get(session.project.id)
    def issue = new Issue()
    def user = User.get(springSecurityService.principal.id)
    issue.reporter = user
    [issue: issue, project: project]
  }

  def save = {
    if(request.isPost()){
      def issue = new Issue()
      issue.properties = params
      if (issueService.newIssue(issue)) {
        flash.message = "Se creo correctamente."
        redirect(action:'view', params:[id:issue.code])
      }
      else {
        def project = Project.get(session.project.id)
        render(view:'create', model:[issue:issue, project: project])
        return ;
      }
    }else{
      render(view:'create')
    }
  }

  def assignIssue = {
    def issue = Issue.findByCode(params.id)
    issueService.reassignIssue issue, User.get(params.int('assignee.id')), params.comment
    flash.message = "Se asigno correctamente"
    redirect(action:'view', params:[id:issue.code])
  }

  def listAsXML = {
    def user = User.get(springSecurityService.principal.id)
    def limit = params.int('limit') ?: 20
    def start = params.int('start') ?: 0
    def issues = Issue.findAllByAssignee(user, [max:limit, offset: start])
    render(contentType:'text/xml'){
      items(success:true){
        totalCount(issues.size())
        for(def issue in issues){
          item{
            id(issue.id)
            code(issue.code)
            summary(issue.summary)
            date(issue.date)
            issueType{
              name(issue.issueType.name)
              icon(issue.issueType.icon)
            }
            assignee{
              name(issue.assignee.fullName)
            }
            reporter{
              name(issue.reporter.fullName)
            }
            priority{
              name(issue.priority.name)
            }
            status{
              name(issue.status.name)
            }
          }
        }
      }
    }
  }
}
