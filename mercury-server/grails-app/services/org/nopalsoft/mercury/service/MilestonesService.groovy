package org.nopalsoft.mercury.service

import org.nopalsoft.mercury.domain.Milestone
import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.MilestoneStatus

class MilestonesService {

    static transactional = true

    def getMilestones(Project project, MilestoneStatus milestoneStatus) {
       def hql = "from Milestone m where m.project = :project "
       def params = [:]
       params.project = project
       if(milestoneStatus != null){
          hql += " and ((m.status = :status) "
          if(milestoneStatus == MilestoneStatus.OPEN)
            hql += " or m.status is null "
          hql += ")"
          params.status = milestoneStatus
       }
       hql += " order by startDate desc"
       Milestone.findAll(hql, params)
    }
}
