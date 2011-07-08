package org.nopalsoft.mercury.service

import org.nopalsoft.mercury.domain.Message
import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Conversation

class MessagesService {

   def springSecurityService
   def mailService

   static transactional = true

   def newMessage = { Message message ->
      User user = User.get(springSecurityService.principal.id)
      message.user = user
      def conversation = new Conversation()
      conversation.save(flush:true)
      message.conversation = conversation
      if(message.save(flush:true)){
         def project = Project.get(message.project.id)
         project.users.each {User u ->
           try {
             mailService.sendMail {
               to u.email
               subject "[Nuevo Mensaje] $message.title"
               body view:"/emails/newMessage", model:[message: message]
             }
           } catch (Exception ex) {
             println ex
           }
         }
         return true
      }
      return false
   }
}
