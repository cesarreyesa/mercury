package org.nopalsoft.mercury.domain

class IssueDependsOn {

   Issue issue
   static hasMany = [dependsOn: Issue]

   IssueDependsOn() {
      dependsOn = []
   }

   static constraints = {
      issue(unique: true)
   }
}
