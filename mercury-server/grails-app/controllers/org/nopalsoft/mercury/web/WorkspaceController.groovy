package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Workspace
import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.WorkspaceInvitation

class WorkspaceController {

   def springSecurityService
   def userService

   def index() {
      [workspace: Workspace.get(session.currentWorkspace.id)]
   }

   def users = {
      User user = User.get(springSecurityService.principal.id)
      def workspace = Workspace.get(params.id)

      if(!user == workspace.owner){
         redirect(action:'index', controller: 'home')
         return
      }
      def users = User.findAllByEnabled(true)
      def pendingInvitations = userService.getPendingInvitations(workspace)

      [workspace: workspace, usersNotInWorkspace: users, pendingInvitations: pendingInvitations]
   }

   def addUser = {
      User currentUser = User.get(springSecurityService.principal.id)
      def workspace = Workspace.get(params.id)

      if(!currentUser == workspace.owner){
         redirect(action:'index', controller: 'home')
         return
      }
      if (request.post) {
         def user = User.get(params.long('user.id'))
         workspace.addToUsers(user)
         if (workspace.save(flush: true)) {
            flash.success = "Se agrego al usuario correctamente"
            redirect action: 'users'
         }
      }
   }

   def inviteUser = {
      User currentUser = User.get(springSecurityService.principal.id)
      def workspace = Workspace.get(params.id)

      if(!currentUser == workspace.owner){
         redirect(action:'index', controller: 'home')
         return
      }
      if (request.post) {

         def user = User.findByEmail(params.userEmail)
         if(user == null){
            // se crea una invitacion
            userService.inviteUser(workspace, params.userEmail)
            flash.success = "Se envio la invitacion"
            redirect action: 'users', id: workspace.id
         }
         else{
            // el usuario ya existe, se asigna al workspace
            userService.addUserToWorkspace(workspace, user)

            flash.success = "Se agrego a ${user.fullName} al workspace"
            redirect action: 'users', id: workspace.id
         }
      }
   }
}
