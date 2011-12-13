package org.nopalsoft.mercury.domain

class WorkspaceInvitation {
   
   User createdBy
   Date dateCreated
   Workspace workspace
   String email
   User user

   static constraints = {
      user(nullable: true)
   }
}
