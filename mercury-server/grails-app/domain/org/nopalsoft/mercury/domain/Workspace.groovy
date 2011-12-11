package org.nopalsoft.mercury.domain

class Workspace {

   String name
   User owner

   static hasMany = [users: User]

   static constraints = {
      name(blank: false)
   }
}
