import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Role
import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.nopalsoft.mercury.domain.Comment
import org.nopalsoft.mercury.domain.IssueLog
import org.nopalsoft.mercury.domain.Conversation
import org.nopalsoft.mercury.domain.Issue

class BootStrap {

   def springSecurityService

   def init = {servletContext ->
      String.metaClass.'static'.randomString = { length ->
         // The chars used for the random string
         def list = ('a'..'z') + ('A'..'Z') + ('0'..'9')
         // Make sure the list is long enough
         list = list * (1 + length / list.size())
         // Shuffle it up good
         Collections.shuffle(list)
         length > 0 ? list[0..length - 1].join() : ''

      }

      def application = ApplicationHolder.application
      application.getArtefacts("Controller").each { klass -> addDynamicMethods(klass) }

      createAdminUser()
      //migrateComents()
   }

   private addDynamicMethods(klass) {

      klass.metaClass.isMobileDevice = {
         def device = request.getAttribute("currentDevice")
         device.isMobile()
      }
   }

   private createAdminUser() {
      def application = ApplicationHolder.application
      def username = application.config.adminUsername
      def password = application.config.adminPassword

      def admin = User.findByUsername(username)
      if (!admin) {
         admin = new User()
         admin.username = username
         admin.password = springSecurityService.encodePassword(password)
         admin.firstName = "Admin"
         admin.lastName = "Test"
         admin.email = "test@nectarapp.com"
         admin.enabled = true
         def role = new Role(authority: "role_admin", description: "Administrator")
         if(role.save(insert:true, flush:true, failOnError: true)){
            println "si"
         }else{
            println "no"
         }
         println role.errors
         admin.addToAuthorities role
         if (admin.save(flush:true)) {
            println "Created admin user: $username"
         } else {
            println "Admin user $username not created: ${admin.errors}"
         }
      }
   }

   private migrateComents(){
      def issues = Issue.list()
//def issues = [Issue.get((long)368)]
      issues.each { Issue issue ->
         def logs = IssueLog.findAllByIssue(issue)
         def conversation = new Conversation()
         if(issue.conversation){
            conversation = issue.conversation
         }
         logs.each { IssueLog log ->
            def comment = new Comment()
            comment.content =  log.comment
            comment.dateCreated = log.date
            comment.user = log.user

            if(log.changes){
               comment.content += "\n\n" + log.changes.collect { c -> "**$c.property** cambio de **$c.originalValue** a **$c.newValue**" }.join("\n\n")
            }
            conversation.comments.add(comment)
         }

         conversation.save(flush:true)
         issue.conversation = conversation
         issue.save(flush:true)
      }

   }

   def destroy = {
   }
}