package org.nopalsoft.mercury.domain

class Comment {

   User user
   Date date
   String content

   static constraints = {
      content maxSize: 4000
   }

   static mapping = {
      table name: 'comment_'
      id generator: 'increment'
      version false
      date column: 'date_'
   }
}
