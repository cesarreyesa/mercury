package org.nopalsoft.mecury.mobile

import grails.plugins.springsecurity.Secured
import org.nopalsoft.mercury.domain.User

@Secured(['user', 'role_admin'])
class MobileHomeController {

   def springSecurityService
   def issueService

   def index() {
      def user = User.get(springSecurityService.principal.id)
      def model = [projects: issueService.getProjectsForUser(user)]
      model
   }
}
