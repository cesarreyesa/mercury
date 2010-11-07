package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.User

class ProfileController {

  def authenticateService

  def index = {
    [user: User.findByUsername(authenticateService.principal().username)]
  }

  def save = {
    if(request.post){
      def user = User.get(params.id)
      user.properties = params
      if (user.save(flush: true)) {
        redirect (action:"index")
      }
      render(view: "index", model: [user: user])
    }
  }
}
