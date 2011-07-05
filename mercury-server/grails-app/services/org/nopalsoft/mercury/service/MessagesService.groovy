package org.nopalsoft.mercury.service

import org.nopalsoft.mercury.domain.Message
import org.nopalsoft.mercury.domain.User

class MessagesService {

   def springSecurityService
   static transactional = true

   def newMessage = { Message message ->
      User user = User.get(springSecurityService.principal.id)
      message.user = user
      return message.save(flush:true)
   }
}
