package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.WorkspaceInvitation
import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Workspace
import grails.plugins.springsecurity.Secured
import org.nopalsoft.mercury.domain.Role

class JoinController {

   def springSecurityService

   def index() {
      if (!params.token){
//         redirect(controller: 'home')
         return
      }
      def invitation = WorkspaceInvitation.findByToken(params.token)
      if (!invitation){
//         redirect(controller: 'home')
         return
      }

      [invitation: invitation, user: new User(email: invitation.email)]
   }

   def join(){
      def workspace = Workspace.get(params.workspaceId)
      def invitation = WorkspaceInvitation.get(params.invitationId)
      def user = new User()
      user.properties = params
      user.username = user.email
      user.enabled = true
      user.addToAuthorities(Role.findByAuthority("user"))
      user.password = springSecurityService.encodePassword(user.password)
      if (user.save(flush: true)) {         
         workspace.addToUsers(user)
         workspace.save(flush: true)

         invitation.processed = true
         invitation.accepted = true
         invitation.save(flush:  true)

         redirect(controller: 'home')
      }
      else{
         render(view: 'index', model: [user: user, invitation: invitation])
      }
   }
}
