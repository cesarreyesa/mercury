package org.nopalsoft.mecury.mobile

import grails.plugins.springsecurity.Secured
import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Project

@Secured(['user', 'role_admin'])
class MobileController {

   def springSecurityService
   def issueService

   def index() {
      def user = User.get(springSecurityService.principal.id)
      def model = [projects: issueService.getProjectsForUser(user)]
      model
   }

   def filters = {
      def user = User.get(springSecurityService.principal.id)
      def project = Project.get(params.project)
      def filters = issueService.getFilters(user)
      [filters: filters, project: project]
   }

   def issues = {
      def user = User.get(springSecurityService.principal.id)
      def project = Project.get(params.project)
      def filter = issueService.getFilters(user).find{ it.id == params.int('filter')}
      def limit = params.int('max') ?: 50
      def start = params.int('offset') ?: 0
      def issues = issueService.getIssues(project, params.search, params.type, filter, "", "", "", start, limit)
      [issues:issues, project:project, filter:filter]
   }
}
