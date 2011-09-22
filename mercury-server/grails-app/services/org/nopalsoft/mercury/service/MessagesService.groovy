package org.nopalsoft.mercury.service

import org.nopalsoft.mercury.domain.Message
import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Conversation
import org.nopalsoft.mercury.domain.Comment
import org.hibernate.criterion.DetachedCriteria
import org.hibernate.criterion.Restrictions
import org.springframework.orm.hibernate3.HibernateTemplate
import org.hibernate.criterion.Disjunction
import org.hibernate.criterion.CriteriaSpecification

class MessagesService {

   def sessionFactory
   def springSecurityService
   def mailService

   static transactional = true

   def getMessages = { Project project, int offset, int maxResults ->
      User user = User.get(springSecurityService.principal.id)

      DetachedCriteria criteria = DetachedCriteria.forClass(Message.class)
      criteria.add(Restrictions.eq("project", project))
      def count = user.authorities.count { a -> a.authority == 'role_admin' }
      if(count == 0){
         def authIds = user.authorities.collect { r -> r.id}.asList()
         criteria.createAlias("followerRoles", "fr", CriteriaSpecification.LEFT_JOIN)
         Disjunction disjunction = Restrictions.disjunction()
         disjunction.add(Restrictions.in("fr.id", authIds))
         disjunction.add(Restrictions.isEmpty("followerRoles"))
         criteria.add(disjunction)
      }

      def hibernateTemplate = new HibernateTemplate(sessionFactory)
      return (List<Message>) hibernateTemplate.findByCriteria(criteria)
   }

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
