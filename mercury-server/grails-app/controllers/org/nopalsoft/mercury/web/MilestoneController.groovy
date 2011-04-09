package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Milestone
import org.nopalsoft.mercury.domain.Issue
import org.nopalsoft.mercury.domain.MilestoneStatus
import grails.plugins.springsecurity.Secured
import org.nopalsoft.mercury.domain.Status

@Secured(['user'])
class MilestoneController {
   def issueService
   def milestonesService

   def index = {
      if (!session.project) {
         redirect(controller: 'home')
      } else {
         def issues
         def milestone = null
         def project = Project.load(session.project.id)
         def id = params.long('id')
         def showUnassigned = params.boolean('showUnassigned')

         def milestoneStatus = MilestoneStatus.OPEN
         if (params.milestoneStatus) {
            if(params.milestoneStatus == "all"){
               milestoneStatus = null
            }
            if(params.milestoneStatus == "closed"){
               milestoneStatus = MilestoneStatus.CLOSED
            }
         }
         def milestones = milestonesService.getMilestones(project, milestoneStatus)

          def issueStatusId = params.long("issueStatus")
          def status
          if (issueStatusId != null) {
              status = Status.findById(issueStatusId)
          } else {
              status = Status.findByCode('open')
          }

          def orderByProperties = ["priority", "date"]
         if (id) {
            milestone = Milestone.load(id)
             issues = issueService.getIssues (milestone, status, orderByProperties)
//            issues = milestone.issues
         } else if (project.currentMilestone && !showUnassigned && params.id != 'pending') {
            if(milestones.contains(project.currentMilestone)) {
               milestone = project.currentMilestone
                issues = issueService.getIssues (milestone, status, orderByProperties)
            } else {
               issues = issueService.getIssuesNotInMilestone(project, status, orderByProperties)
            }
         } else {
            issues = issueService.getIssuesNotInMilestone(project, status, orderByProperties)
         }

          [milestone: milestone, milestones: milestones, issues: issues, showUnassigned: showUnassigned, status: status, statusList: Status.all]
      }
   }

   def addIssuesToMilestone = {
      def milestone = Milestone.load(params.milestone)
      def issueIds = params['issue']
      //Se valida si se selecciono uno o varios
      if (issueIds instanceof String) {
         addIssueToMilestone(issueIds, milestone)
      } else {
         issueIds.each {
            addIssueToMilestone(it, milestone)
         }
      }
      flash.success = "Las incidencias se han agregado correctamente a la entrega."
      redirect action: 'index', params: [id: params.id, showUnassigned: params.showUnassigned]
   }

   private def addIssueToMilestone(it, Milestone milestone) {
      def issue = Issue.get(it as long)
      milestone.addToIssues(issue)
      milestone.save()
   }

   def moveUp = {
      def milestone = Milestone.load(params.milestone)
      def issue = Issue.load(params.issue)
      milestone.moveUp issue
      redirect action: 'index', id: params.milestone
   }

   def moveDown = {
      def milestone = Milestone.load(params.milestone)
      def issue = Issue.load(params.issue)
      milestone.moveDown issue
      redirect action: 'index', id: params.milestone
   }

   def create = {
      def milestone = new Milestone()
      def project = Project.load(session.project.id)
      milestone.project = project
      milestone.name = params.name
      milestone.startDate = Date.parse("dd/MM/yyyy", params.startDate)
      milestone.endDate = Date.parse("dd/MM/yyyy", params.endDate)
      milestone.save()

      redirect action: 'index', id: params.actualMilestone
   }

   def closeMilestone = {
      def milestoneId = params.long("id")
      if (milestoneId) {
         def milestone = Milestone.get(milestoneId)
         def issues = milestone.issues.findAll { it.status.code != 'resolved' && it.status.code != 'closed'}
         if (issues.empty) {
            milestone.status = MilestoneStatus.CLOSED
            milestone.save()
            redirect action: 'index'
         } else {
            flash.message = "No se puede cerrar la entrega porque existen incidencias abiertas."
         }

      }

      redirect action: 'index', params: [id: params.id, showUnassigned: params.showUnassigned]
   }
}
