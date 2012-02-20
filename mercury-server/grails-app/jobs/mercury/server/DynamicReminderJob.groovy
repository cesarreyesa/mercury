package mercury.server

import org.nopalsoft.mercury.domain.Issue

/**
 * User: cesarreyes
 * Date: 17/02/12
 * Time: 22:26
 */
class DynamicReminderJob {

   def issueService

   def group = "issues-startDate"

   def execute(context) {
      def issue = Issue.get(context.mergedJobDataMap.get('issueId'))
      issueService.remindStartIssue(issue)
   }

}
