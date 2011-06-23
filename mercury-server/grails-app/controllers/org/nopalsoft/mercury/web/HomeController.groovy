package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.User
import javax.servlet.http.Cookie
import grails.plugins.springsecurity.Secured

@Secured(['user'])
class HomeController {

   def issueService
   def springSecurityService

   def index = {
      if (!session.project) {
         redirect(action: 'chooseProject')
      } else {
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
      def user = User.get(springSecurityService.principal.id)
      def model = [projects: Project.executeQuery("select distinct project from Project project join project.users as user where user.id = ? order by project.name", [user.id])]
      if(isMobileDevice()){
         model.layout = 'iphone'
         render(view: 'chooseProject', model: model)
      }else{
         render(view:'chooseProject', model: model)
      }
   }

   def changeProject = {
      session.project = Project.get(params.project)
      try {
         def user = User.get(springSecurityService.principal.id)
         user.settings.projectId = session.project.id.toString()
         user.save(flush: true)
      } catch (Exception ex) {

      }
      redirect(action: 'index')
   }
}
