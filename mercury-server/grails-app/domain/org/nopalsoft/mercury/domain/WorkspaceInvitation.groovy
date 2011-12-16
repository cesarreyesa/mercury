package org.nopalsoft.mercury.domain

class WorkspaceInvitation {
   
   User createdBy
   Date dateCreated
   Workspace workspace
   String email
   User user
   String token

   static constraints = {
      user(nullable: true)
      token(unique: true)
   }
}
