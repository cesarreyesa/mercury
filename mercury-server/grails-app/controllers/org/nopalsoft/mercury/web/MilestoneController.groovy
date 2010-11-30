package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Milestone

class MilestoneController {
  def issueService

    def index = {
      if (!session.project) {
          render(view: 'chooseProject', model: [projects: Project.findAll()])

      } else {
        def project = Project.load(session.project.id)
        def milestones =  Milestone.findByProject(project)
        def issues = issueService.getIssuesNotInMilestone(project)
        [milestones: milestones, issues: issues]
      }
    }
}
