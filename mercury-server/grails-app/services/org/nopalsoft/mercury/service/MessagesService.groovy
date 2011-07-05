package org.nopalsoft.mercury.service

import org.nopalsoft.mercury.domain.Message
import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Project

class MessagesService {

   def springSecurityService
   def mailService

   static transactional = true

   def newMessage = { Message message ->
      User user = User.get(springSecurityService.principal.id)
      message.user = user
      if(message.save(flush:true)){
         def project = Project.get(message.project.id)
         project.users.each {User u ->
           try {
             mailService.sendMail {
               to 'cesarreyesa@gmail.com'
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
