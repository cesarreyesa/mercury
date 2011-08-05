package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.User
import grails.plugins.springsecurity.Secured

@Secured(['user', 'role_admin'])
class ProfileController {

  def springSecurityService

  def index = {
    [user: User.get(springSecurityService.principal.id)]
  }

  def save = {
    if(request.post){
      def user = User.get(params.id)
      user.properties = params
      if (user.save(flush: true)) {
        redirect (action:"index")
        return
      }
      render(view: "index", model: [user: user])
    }
  }

  def changePassword = {
    if(request.post){
      def user = User.get(params.id)
      if(params.password && (params.password == params.confirmPassword)){
        user.password = springSecurityService.encodePassword(params.password)
        if (user.save(flush: true)) {
          redirect (action:"index")
        }
        else{
          render(view: "index", model: [user: user])
        }
      }
    }
  }
}
