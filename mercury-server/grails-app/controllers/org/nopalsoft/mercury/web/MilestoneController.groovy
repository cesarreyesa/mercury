package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Milestone
import org.nopalsoft.mercury.domain.Issue

class MilestoneController {
  def issueService

  def index = {
    if (!session.project) {
      render(view: 'chooseProject', model: [projects: Project.findAll()])

    } else {
      def issues
      def milestone = null
      def project = Project.load(session.project.id)
      def id = params.long('id')
      if (id) {
        milestone = Milestone.get(id)
        issues = milestone.issues
      } else {
        issues = issueService.getIssuesNotInMilestone(project)
      }

      def milestones = Milestone.findAllByProject(project)
      [milestone: milestone, milestones: milestones, issues: issues]
    }
  }

  def addIssuesToMilestone = {
    def milestone = Milestone.get(params.milestone)
    def issueIds = params['issue']
    issueIds.each{
      def issue = Issue.load(it as long)
      issue.milestone = milestone
      issue.save()
    }
    flash.message = "Si se pudo"
    redirect action:'index'
  }
}
