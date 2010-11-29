package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Milestone

class MilestoneController {

    def index = {
      def project = Project.load(session.project.id)
      def milestones =  Milestone.findByProject(project)

      [milestones: milestones]
    }
}
