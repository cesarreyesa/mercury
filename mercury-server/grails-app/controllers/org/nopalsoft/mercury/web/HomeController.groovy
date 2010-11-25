package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.User
import javax.servlet.http.Cookie

class HomeController {

  def issueService
  def springSecurityService

  def index = {
    if (!session.project) {
      render(view: 'chooseProject', model: [projects: Project.findAll()])
    }else{
      def user = User.get(springSecurityService.principal.id)
      def model = new HashMap<String, ?>();
      model["issuesByStatus"] = issueService.getProjectStatusByStatus(session.project)
      model["issuesByAssignee"] = issueService.getProjectStatusByAssignee(session.project, "open")
      model["issuesByPriority"] = issueService.getProjectStatusByPriority(session.project, "open")
      model["openIssuesByPriority"] = issueService.getOpenIssuesByPriority(session.project, user)
      model["totalIssues"] = issueService.getTotalIssues(session.project)
      model
//      model.addAttribute("openIssues", issueManager.getTotalIssues(project, "open"));
    }
  }

  def chooseProject = {
    [projects: Project.findAll()]
  }

  def changeProject = {
    session.project = Project.get(params.project)
    try{
      def user = User.get(springSecurityService.principal.id)
      user.settings.projectId = session.project.id.toString()
      user.save(flush:true)
    }catch(Exception ex){

    }
    redirect(action:'index')
  }
}
