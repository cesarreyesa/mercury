package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Milestone

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

        def milestones =  Milestone.findByProject(project)
        [milestone: milestone, milestones: milestones, issues: issues]
      }
    }
}
