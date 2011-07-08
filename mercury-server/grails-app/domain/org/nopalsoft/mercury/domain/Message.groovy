package org.nopalsoft.mercury.domain

class Message {

   User user
   Project project
   String title
   String body
   Date dateCreated
   Date lastUpdated
   Conversation conversation

   static constraints = {
      title(blank:false, maxSize: 200)
      body(blank: false, maxSize: 4000)
   }

   static mapping = {
      version(false)
   }
}
