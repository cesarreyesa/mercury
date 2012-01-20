package mercury.server


class RemindersJob {
   
   def issueService
   
   static triggers = {
      cron name: 'remindersTrigger', cronExpression: "0 0 9 * * ?"
   }
   def group = "IssuesGroup"

   def execute() {
      def issues = issueService.getIssuesScheduledForToday()
      for(def issue : issues){
         issueService.remindStartIssue(issue)
      }
   }
}
