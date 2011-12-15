package org.nopalsoft.mercury.service

import org.nopalsoft.mercury.domain.Workspace
import org.nopalsoft.mercury.domain.WorkspaceInvitation
import org.nopalsoft.mercury.domain.User

class UserService {

   def springSecurityService
   def mailService

   def inviteUser(Workspace workspace, String email) {
      User currentUser = User.get(springSecurityService.principal.id)
      if(currentUser != workspace.owner){
         throw new Exception("No tiene permisos para agregar al usuario")
      }

      def invitation = new WorkspaceInvitation()
      invitation.createdBy = currentUser
      invitation.workspace = workspace
      invitation.email = email //TODO: validar email
      invitation.token = String.randomSting(50)

      mailService.sendMail {
         to user.email
         subject "$workspace.name is now using Nectar - Join Today!"
         body view: "/emails/inviteUserToWorkspace", model: [invitation: invitation]
      }
   }

   def addUserToWorkspace(Workspace workspace, User user){
      User currentUser = User.get(springSecurityService.principal.id)
      if(currentUser != workspace.owner){
         throw new Exception("No tiene permisos para agregar al usuario")
      }

      workspace.addToUsers(user)
      workspace.save(flush: true)
      mailService.sendMail {
         to user.email
         subject ''
         body view: "/emails/addUserToWorkspace"
      }
   }
}
