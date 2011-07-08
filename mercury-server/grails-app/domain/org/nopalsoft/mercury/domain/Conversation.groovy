package org.nopalsoft.mercury.domain

class Conversation {

   static hasMany = [comments: Comment]

   static constraints = {
   }
}
