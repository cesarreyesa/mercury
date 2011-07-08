package org.nopalsoft.mercury.web

import grails.plugins.springsecurity.Secured
import org.nopalsoft.mercury.domain.Message
import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Comment
import org.nopalsoft.mercury.domain.Conversation
import org.nopalsoft.mercury.domain.User

@Secured(['user'])
class MessagesController {

   def messagesService
   def springSecurityService

   def index = {
      def project = Project.get(session.project.id)
      def messages = Message.findAllByProject(project, [sort:'dateCreated', order:'desc'])
      [messages: messages, project: project]
   }

   def create = {
      def project = Project.get(session.project.id)
      def message = new Message()
      [message: message, project: project]
   }

   def save = {
      if (request.isPost()) {
         def message = new Message()
         message.properties = params
         if(!message.hasErrors() && messagesService.newMessage(message)){
            flash.successMessage = "Se ha creado un mensaje"
            redirect(action: "index")
         }else{
            def project = Project.get(session.project.id)
            render(view: 'create', model: [message: message, project: project])
         }
      }else{
         redirect(action: 'create')
      }
   }

   def addComment = {
      def conversation = Conversation.get(params.id)
      def message = Message.findByConversation(conversation)
      def comment = new Comment()
      comment.content = params.comment
      comment.user = User.get(springSecurityService.principal.id)
      conversation.addToComments(comment)
      conversation.save(flush:true)

      messagesService.notifyComment(message, comment)

      redirect(url:params.url)
   }

}
