package org.nopalsoft.mercury.domain

class Conversation {

   Conversation() {
      comments = []
   }

   static hasMany = [comments: Comment]

   static constraints = {
   }
}
