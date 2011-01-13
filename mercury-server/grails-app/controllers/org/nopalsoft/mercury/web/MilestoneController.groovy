package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Milestone
import org.nopalsoft.mercury.domain.Issue
import org.nopalsoft.mercury.domain.MilestoneStatus

class MilestoneController {
  def issueService

  def index = {
    if (!session.project) {
      redirect(controller: 'home')

    } else {
      def issues
      def milestone = null
      def project = Project.load(session.project.id)
      def id = params.long('id')
      def showUnassigned = params.boolean('showUnassigned')
      def milestoneIsReadyToClose = false

      if (id) {
        milestone = Milestone.get(id)
        issues = milestone.issues.findAll{ it.status.code != 'resolved' && it.status.code != 'closed'}
        def resolvedIssues = milestone.issues.findAll{ it.status.code == 'resolved' || it.status.code == 'closed'}
        milestoneIsReadyToClose = issues.empty && !resolvedIssues.empty
      } else if(project.currentMilestone && !showUnassigned) {
        milestone = project.currentMilestone
        issues = project.currentMilestone.issues.findAll{ it.status.code != 'resolved' && it.status.code != 'closed'}
      }else {
        issues = issueService.getIssuesNotInMilestone(project)
      }

      def milestones = Milestone.findAll("from Milestone m where m.project = :projectParam and (m.status = :statusParam or m.status is null) order by startDate desc",
              [projectParam: project, statusParam: MilestoneStatus.OPEN ])

      if (milestoneIsReadyToClose) {
        flash.success = "Ya no existen incidencias abiertas en la entrega."
      }
      [milestone: milestone, milestones: milestones, issues: issues, showUnassigned: showUnassigned, milestoneIsReadyToClose: milestoneIsReadyToClose]
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
    issue.milestone = milestone
    issue.save()
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
      def openIssues = milestone.issues.findAll{ it.status.code != 'resolved' && it.status.code != 'closed'}
      def resolvedIssues = milestone.issues.findAll{ it.status.code == 'resolved' || it.status.code == 'closed'}
      if (openIssues.empty && !resolvedIssues.empty) {
        milestone.status = MilestoneStatus.CLOSE
        milestone.save()
        redirect action: 'index'
      } else if (resolvedIssues.empty){
        flash.message = "No se puede cerrar la entrega porque no tiene incidencias asignadas."
      } else {
        flash.message = "No se puede cerrar la entrega porque existen incidencias abiertas."
      }

    }

    redirect action: 'index', params: [id: params.id, showUnassigned: params.showUnassigned]
  }
}
