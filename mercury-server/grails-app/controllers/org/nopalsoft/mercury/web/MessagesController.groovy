package org.nopalsoft.mercury.web

import grails.plugins.springsecurity.Secured
import org.nopalsoft.mercury.domain.Message
import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Comment
import org.nopalsoft.mercury.domain.Conversation
import org.nopalsoft.mercury.domain.User
import com.petebevin.markdown.MarkdownProcessor
import org.nopalsoft.mercury.domain.Role

@Secured(['user', 'role_admin'])
class MessagesController {

   def messagesService
   def springSecurityService

   def index = {
      def project = Project.get(request.project.id)
      def max = params.int('max') ?: 20
      def offset = params.int('offset') ?: 0
      def messages = messagesService.getMessages(project, offset, max)
      [messages: messages, project: project]
   }

   def create = {
      def project = Project.get(request.project.id)
      def message = new Message()
      [message: message, project: project, roles: Role.listOrderByAuthority()]
   }

   def save = {
      if (request.isPost() && !params.id) {
         def message = new Message()
         message.properties = params
         if(!message.hasErrors() && messagesService.newMessage(message)){
            flash.successMessage = "Se ha creado un mensaje"
            redirect(action: "index")
         }else{
            def project = Project.get(request.project.id)
            render(view: 'create', model: [message: message, project: project])
         }
      }else{
         redirect(action: 'create')
      }
   }

   def view = {
      def message = Message.get(params.id)
      [message: message, project: message.project]
   }

   def edit = {
      def project = Project.get(request.project.id)
      def message = Message.get(params.id)
      render(view: 'create', model: [message: message, project: project])
   }

   def update = {
      if (request.isPost() && params.id) {
         def message = Message.get(params.id)
         message.properties = params
         if(!message.hasErrors() && messagesService.saveMessage(message)){
            flash.successMessage = "Se ha editado un mensaje"
            redirect(action: "view", params: [id: message.id])
         }else{
            def project = Project.get(request.project.id)
            render(view: 'edit', model: [message: message, project: project])
         }
      }else{
         redirect(action: 'index')
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

      redirect(url:params.url.replaceFirst(request.contextPath, ''))
   }

}
