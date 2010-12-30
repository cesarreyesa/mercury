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
      if (id) {
        milestone = Milestone.get(id)
        issues = milestone.issues.findAll{ it.status.code != 'resolved' && it.status.code != 'closed'}
      } else if(project.currentMilestone && !showUnassigned) {
        milestone = project.currentMilestone
        issues = project.currentMilestone.issues.findAll{ it.status.code != 'resolved' && it.status.code != 'closed'}
      }else {
        issues = issueService.getIssuesNotInMilestone(project)
      }

      def milestones = Milestone.findAll("from Milestone m where m.project = :projectParam and (m.status = :statusParam or m.status is null) order by startDate desc",
              [projectParam: project, statusParam: MilestoneStatus.OPEN ])

      [milestone: milestone, milestones: milestones, issues: issues, showUnassigned: showUnassigned]
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
    flash.message = "Si se pudo"
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
      def issues = milestone.issues.findAll{ it.status.code != 'resolved' && it.status.code != 'closed'}
      if (issues.empty) {
        milestone.status = MilestoneStatus.CLOSE
        milestone.save()
        redirect action: 'index'
      }
    }

    redirect action: 'index', params: [id: params.id, showUnassigned: params.showUnassigned]
  }
}
