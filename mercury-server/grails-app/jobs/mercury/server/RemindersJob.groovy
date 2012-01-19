package mercury.server


class RemindersJob {
   
   def issueService
   
   static triggers = {
      cron name: 'remindersTrigger', cronExpression: "0 * * * * ?"
   }
   def group = "IssuesGroup"

   def execute() {
      def issues = issueService.getIssuesScheduledForToday()
      for(def issue : issues){
         println "debe enviar correo de incidenco ${issue.code}"
         issueService.remindStartIssue(issue)
      }
   }
}
