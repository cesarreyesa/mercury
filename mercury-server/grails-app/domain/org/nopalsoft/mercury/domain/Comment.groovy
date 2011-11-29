package org.nopalsoft.mercury.domain

class Comment {

   Project project
   User user
   Date dateCreated
   String content

   static constraints = {
      content(maxSize: 4000, nullable: true)
   }

   static mapping = {
      table name: 'comment_'
      id generator: 'increment'
      version false
   }
}
