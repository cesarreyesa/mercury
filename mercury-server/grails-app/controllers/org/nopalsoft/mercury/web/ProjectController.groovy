package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Milestone
import grails.plugins.springsecurity.Secured
import org.nopalsoft.mercury.domain.Workspace

@Secured(['user', 'role_admin'])
class ProjectController {

   def springSecurityService

   def index = {
      User user = User.get(springSecurityService.principal.id)
      def project = Project.get(request.project.id)

      if(!user.isProjectLead(project)){
         redirect(action:'index', controller: 'home')
         return
      }

      def milestones = Milestone.findAllByProject(project)
      [project: project, milestones: milestones]
   }

   def save = {
      User user = User.get(springSecurityService.principal.id)
      def project = Project.get(request.project.id)

      if(!user.isProjectLead(project)){
         redirect(action:'index', controller: 'home')
         return
      }
      project.properties = params
      if (!project.hasErrors() && project.save(flish: true)) {
         flash.success = "Se actualizo correctamente el proyecto."
         redirect action: 'index'
      } else {
         flash.message = "Hubo un error al salvar el proyecto"
         render(view: 'index', model: [project: project])
      }
   }

   def users = {
      User user = User.get(springSecurityService.principal.id)
      def project = Project.get(request.project.id)

      if(!user.isProjectLead(project)){
         redirect(action:'index', controller: 'home')
         return
      }
      if(!session.currentWorkspace){
         redirect(action:'index', controller: 'home')
         return
      }

      def workspace = Workspace.get(session.currentWorkspace.id)

      def users = workspace.users

      [project: project, usersNotInProject: users]
   }

   def addUser = {
      User currentUser = User.get(springSecurityService.principal.id)
      def project = Project.get(request.project.id)

      if(!currentUser.isProjectLead(project)){
         redirect(action:'index', controller: 'home')
         return
      }
      if (request.post) {
         def user = User.get(params.long('user.id'))
         project.addToUsers(user)
         if (project.save(flush: true)) {
            flash.success = "Se agrego al usuario correctamente"
            redirect action: 'users'
         }
      }
   }

   def deleteUser = {
      User currentUser = User.get(springSecurityService.principal.id)
      def project = Project.get(request.project.id)

      if(!currentUser.isProjectLead(project)){
         redirect(action:'index', controller: 'home')
         return
      }
      if (request.post) {
         def user = User.get(params.userId)
         project.removeFromUsers user
         if (project.save(flush: true)) {
            flash.success = "Se elimino al usuario correctamente"
            redirect action: 'users'
         }
      }
   }

   def categories = {
      User currentUser = User.get(springSecurityService.principal.id)
      def project = Project.get(request.project.id)

      if(!currentUser.isProjectLead(project)){
         redirect(action:'index', controller: 'home')
         return
      }
      def categories = org.nopalsoft.mercury.domain.Category.findAllByProject(project)
      [project: project, categories: categories]
   }

   def addCategory = {
      User currentUser = User.get(springSecurityService.principal.id)
      def project = Project.get(request.project.id)

      if(!currentUser.isProjectLead(project)){
         redirect(action:'index', controller: 'home')
         return
      }
      def category = new org.nopalsoft.mercury.domain.Category(name: params.name)
      category.project = project
      if (category.save(flush: true)) {
         redirect action: 'categories'
      }
   }
}
