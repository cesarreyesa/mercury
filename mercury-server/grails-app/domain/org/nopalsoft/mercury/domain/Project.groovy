package org.nopalsoft.mercury.domain

class Project {

   String code
   String name
   String description
   Integer lastIssueId
   User lead
   Milestone currentMilestone
   Workspace workspace
   static hasMany = [users: User]

   static constraints = {
      code(nullable: true)
      name(blank: false)
      description(blank: true, nullable: true)
      lastIssueId(nullable: true)
      currentMilestone(nullable: true)
      workspace(nullable: true)
   }

   static mapping = {
      version false
      users joinTable: [name: 'projetc_user', key: 'project_id', column: 'user_id']
   }

   public String toString(){
      name
   }

}
