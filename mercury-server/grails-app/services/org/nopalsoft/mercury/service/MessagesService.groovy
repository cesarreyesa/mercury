package org.nopalsoft.mercury.service

import org.nopalsoft.mercury.domain.Message
import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Conversation
import org.nopalsoft.mercury.domain.Comment

class MessagesService {

   def springSecurityService
   def mailService

   static transactional = true

   def newMessage = { Message message ->
      User user = User.get(springSecurityService.principal.id)
      message.user = user
      def conversation = new Conversation()
      conversation.save(flush: true)
      message.conversation = conversation
      if (message.save(flush: true)) {
         def project = Project.get(message.project.id)
         def projectUsers = project.users.collect { u -> User.get(u.id) }
         projectUsers.findAll { x -> message.followerRoles.size() == 0 || x.authorities.id.any { message.followerRoles.id.contains(it) } }.each {User u ->
            try {
               mailService.sendMail {
                  to u.email
                  subject "[Nuevo Mensaje] $message.title"
                  body view: "/emails/newMessage", model: [message: message]
               }
            } catch (Exception ex) {
               println ex
            }
         }
         return true
      }
      return false
   }

   def saveMessage = { Message message ->
      User user = User.get(springSecurityService.principal.id)
      message.user = user
      if (message.save(flush: true)) {
         def project = Project.get(message.project.id)
         project.users.each {User u ->
            try {
               mailService.sendMail {
                  to u.email
                  subject "[Mensaje editado] $message.title"
                  body view: "/emails/messageEdited", model: [message: message]
               }
            } catch (Exception ex) {
               println ex
            }
         }
         return true
      }
      return false
   }

   def notifyComment = { Message message, Comment comment ->
      def project = Project.get(message.project.id)
      project.users.each {User u ->
         try {
            mailService.sendMail {
               to u.email
               subject "[Nuevo comentario] $message.title"
               body view: "/emails/newMessageComment", model: [message: message, comment: comment]
            }
         } catch (Exception ex) {
            println ex
         }
      }
   }
}
