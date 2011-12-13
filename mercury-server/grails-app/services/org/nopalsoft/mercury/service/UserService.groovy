package org.nopalsoft.mercury.service

import org.nopalsoft.mercury.domain.Workspace
import org.nopalsoft.mercury.domain.WorkspaceInvitation
import org.nopalsoft.mercury.domain.User

class UserService {

   def springSecurityService
   def mailService

   def inviteUser(Workspace workspace, String email) {
      User currentUser = User.get(springSecurityService.principal.id)

      def invitation = new WorkspaceInvitation()
      invitation.createdBy = currentUser
      invitation.workspace = workspace
      invitation.email = email //TODO: validar email

      mailService.sendMail {

      }

   }
}
