package org.nopalsoft.mercury.workflow

import org.nopalsoft.mercury.domain.Issue
import org.nopalsoft.mercury.domain.Status

/**
 * User: cesarreyes
 * Date: 14/11/10
 * Time: 09:39
 */
class Workflow {

  public static String getInitialStatus(){
    return "open"
  }

  public static List<Action> getAvailableActions(Issue issue){
    if(issue.status.code == "open"){
      return [Action.APPROVE, Action.START_PROGRESS, Action.RESOLVE, Action.CLOSE]
    }
    if(issue.status.code == "inProgress"){
      return [Action.APPROVE, Action.STOP_PROGRESS, Action.RESOLVE]
    }
    if(issue.status.code == "resolved"){
      return [Action.OPEN, Action.CLOSE]
    }
    []
  }

  static String getNextStatus(String currentStatus, Action action) {
    if(action == Action.RESOLVE){
      return "resolved"
    }
    return null
  }
}
