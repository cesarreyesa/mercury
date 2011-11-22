package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.User

import grails.plugins.springsecurity.Secured

@Secured(['user', 'role_admin'])
class HomeController {

   def issueSearchService
   def issueService
   def springSecurityService

   def index = {
      if (isMobileDevice()) {
         redirect(controller: 'mobile')
      }
      if (!session.project) {
         redirect(action: 'chooseProject')
      } else {
         def user = User.get(springSecurityService.principal.id)
         def model = new HashMap<String, ?>();
         model["issuesByStatus"] = issueSearchService.getProjectStatusByStatus(session.project)
         model["issuesByAssignee"] = issueSearchService.getProjectStatusByAssignee(session.project, "open")
         model["issuesByPriority"] = issueSearchService.getProjectStatusByPriority(session.project, "open")
         model["openIssuesByPriority"] = issueSearchService.getOpenIssuesByPriority(session.project, user)
         model["totalIssues"] = issueSearchService.getTotalIssues(session.project)
         model.activities = issueSearchService.getActivities(user, session.project)
         model
//      model.addAttribute("openIssues", issueManager.getTotalIssues(project, "open"));
      }
   }

   def chooseProject = {
      def user = User.get(springSecurityService.principal.id)
      def model = [projects: issueSearchService.getProjectsForUser(user)]
      render(view: 'chooseProject', model: model)
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
