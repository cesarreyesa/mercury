package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Conversation
import org.nopalsoft.mercury.domain.Comment
import org.nopalsoft.mercury.domain.User

class ConversationController {

   def springSecurityService

   def index = { }

   def addComment = {
      def conversation = Conversation.get(params.id)
      def comment = new Comment()
      comment.content = params.comment
      comment.user = User.get(springSecurityService.principal.id)
      conversation.addToComments(comment)
      conversation.save(flush:true)
      redirect(url:params.url)
   }
}
