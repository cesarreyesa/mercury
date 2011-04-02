package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.User
import grails.plugins.springsecurity.Secured
import org.nopalsoft.mercury.domain.IssueFilter
import org.apache.commons.lang.time.DateUtils
import org.nopalsoft.mercury.domain.Status
import org.apache.commons.collections.CollectionUtils

@Secured(['user'])
class ReportsController {

   def issueService
   def springSecurityService

   def index = { }

   def issues = {
      def user = User.get(springSecurityService.principal.id)
      def model = [projects: Project.executeQuery("select distinct project from Project project join project.users as user where user.id = ? order by project.name", [user.id])]
      model.statuses = Status.listOrderByName()
      if(request.isPost()){
         def createdFrom = null
         try{
            createdFrom = Date.parse("MM/dd/yyyy", params.from)
         }catch(Exception){}
         def createdUntil = null
         try{
            createdUntil = Date.parse("MM/dd/yyyy", params.to)
         }catch(Exception){}
         def filter = new IssueFilter(createdFrom: createdFrom, createdUntil: createdUntil)
         filter.status = params.status instanceof String[] ? params.status.join(',') : params.status
         model.issues = issueService.getIssues(params.project?.collect { p -> Project.load(p)}, null, null, filter, null, null, null, 0, 100)
      }
      model
   }
}
