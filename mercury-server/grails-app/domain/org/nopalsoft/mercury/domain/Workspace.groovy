package org.nopalsoft.mercury.domain

class Workspace {

   String name
   User owner

   static constraints = {
      name(blank: false)
   }
}
