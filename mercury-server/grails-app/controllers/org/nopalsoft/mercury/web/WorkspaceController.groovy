package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Workspace
import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.WorkspaceInvitation

class WorkspaceController {

   def springSecurityService

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

      [workspace: workspace, usersNotInWorkspace: users]
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

         def user = User.get(params.long('user.id'))
         if (invitation.save(flush: true)) {
            flash.success = "Se agrego al usuario correctamente"
            redirect action: 'users'
         }
      }
   }
}
