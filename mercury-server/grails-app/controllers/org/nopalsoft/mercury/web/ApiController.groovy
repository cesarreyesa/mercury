package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.User
import org.codehaus.groovy.grails.web.json.JSONArray
import grails.converters.JSON

class ApiController {

   def issueService

   def workingOn = {
      def user = User.get(params.user)
      if(!user)
         render(([error:'User not found'] as JSONArray).toString())

      def workingOn = user.WorkingOn()
      render workingOn as JSON
   }

   def projects = {

   }

   def issues = {

   }

   def users = {

   }

   def milestones = {

   }

}
