package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.User

import grails.plugins.springsecurity.Secured
import org.nopalsoft.mercury.domain.Workspace
import javax.servlet.http.Cookie

@Secured(['user', 'role_admin'])
class HomeController {

   def issueSearchService
   def issueService
   def springSecurityService
   def userService

   def index = {
      if (isMobileDevice()) {
         redirect(controller: 'mobile')
      }
      if (!session.currentWorkspace) {
         redirect(action: 'chooseWorkspace')
      } else {
         def user = User.get(springSecurityService.principal.id)
         def model = new HashMap<String, ?>();
         if(request.project){
            model["issuesByStatus"] = issueSearchService.getProjectStatusByStatus(request.project)
            model["issuesByAssignee"] = issueSearchService.getProjectStatusByAssignee(request.project, "open")
            model["issuesByPriority"] = issueSearchService.getProjectStatusByPriority(request.project, "open")
            model["openIssuesByPriority"] = issueSearchService.getOpenIssuesByPriority(request.project, user)
            model["totalIssues"] = issueSearchService.getTotalIssues(request.project)
            model.activities = issueSearchService.getActivities(user, request.project)
         }
         model
      }

   }

   def chooseWorkspace = {
      def user = User.get(springSecurityService.principal.id)
      render(view: 'chooseWorkspace', model: [workspaces: userService.getWorkspaces(user)])
   }

   def changeWorkspace = {
      def workspace = Workspace.get(params.workspace)
      session.currentWorkspace = workspace
      setCookie(response, "workspace", workspace.id.toString(), 60 * 60 * 24 * 30)
//      params.projects = Project.findAllByWorkspace(workspace)
      //      params.projects = Project.findAllByWorkspace(workspace)
      try {
//         def user = User.get(springSecurityService.principal.id)
         //         user.settings.projectId = request.project.id.toString()
         //         user.save(flush: true)
      } catch (Exception ex) {

      }
      redirect(action: 'index')
   }

   def changeProject = {
      def project = Project.get(params.projectId)
      if (project) {
         setCookie(response, "project", project.id.toString(), 60 * 60 * 24 * 30)
         request.project = project
      }
      redirect(action: 'index')
   }

   private void setCookie(response, name, value, maxAge) {
      Cookie cookie = new Cookie(name, value)
      cookie.setMaxAge(maxAge)
//      cookie.domain = "/"
      cookie.path = "/"
      response.addCookie(cookie)
   }

   def newWorkspace = {
      def workspace = new Workspace()
      workspace.name = params.name
      workspace.owner = User.get(springSecurityService.principal.id)
      workspace.addToUsers(workspace.owner)
      workspace.save(flush: true)
      redirect(action: 'index')
   }

   def newProject = {
      if(!session.currentWorkspace){
         flash.message = "No se ha seleccionado un workspace"
         redirect(action: 'index')
      }
      def user = User.get(springSecurityService.principal.id)
      def project = new Project()
      project.name = params.projectName
      project.lead = user
      project.workspace = Workspace.get(session.currentWorkspace.id)
      project.addToUsers(user)
      project.save(flush: true)
      redirect(action: 'index')
   }

}
