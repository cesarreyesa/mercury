package org.nopalsoft.mercury.service

import org.nopalsoft.mercury.domain.Workspace
import org.nopalsoft.mercury.domain.WorkspaceInvitation
import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Project

class UserService {

   def springSecurityService
   def mailService

   public List<Project> getProjectsForUser(User user){
      return Project.executeQuery("select distinct project from Project project join project.users as user where user.id = ? order by project.name", [user.id])
   }

   def List<Workspace> getWorkspaces(User user){
      return Workspace.executeQuery("select distinct workspace from Workspace workspace join workspace.users as user where user.id = ? order by workspace.name", [user.id])
   }

   def inviteUser(Workspace workspace, String email) {
      User currentUser = User.get(springSecurityService.principal.id)
      if(currentUser != workspace.owner){
         throw new Exception("No tiene permisos para agregar al usuario")
      }

      def invitation = new WorkspaceInvitation()
      invitation.createdBy = currentUser
      invitation.workspace = workspace
      invitation.email = email //TODO: validar email
      invitation.token = String.randomString(40)
      invitation.processed = false
      invitation.accepted = false
      invitation.save(flush: true)

      mailService.sendMail {
         to email
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
         subject "${currentUser.fullName} te ha invitado al workspace ${workspace.name}"
         body view: "/emails/addUserToWorkspace", model:  [user: user, workspace: workspace, currentUser: currentUser]
      }
   }

   List<WorkspaceInvitation> getPendingInvitations(Workspace workspace) {
      return WorkspaceInvitation.findAllByWorkspaceAndProcessed(workspace, false)
   }
}
