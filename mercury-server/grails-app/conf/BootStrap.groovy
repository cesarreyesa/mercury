import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Role
import org.codehaus.groovy.grails.commons.ApplicationHolder
import org.nopalsoft.mercury.domain.Comment
import org.nopalsoft.mercury.domain.IssueLog
import org.nopalsoft.mercury.domain.Conversation
import org.nopalsoft.mercury.domain.Issue
import org.nopalsoft.mercury.domain.IssueComment
import groovy.sql.Sql
import org.eclipse.jdt.internal.compiler.util.CompoundNameVector
import org.nopalsoft.mercury.domain.Message
import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.Workspace

class BootStrap {

   def springSecurityService
   def dataSource

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
//      migrateProjects()
//      migrateComments()
//      migrateCommentsV2()
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

   private migrateComments(){
      def issues = Issue.list()
//      def issues = [Issue.findByCode('15')]
      println "procesando ${issues.size()} issues"
      def count = 1
      issues.each { Issue issue ->
         println "procesando issue [${issue.code}] ${count++} de ${issues.size()}"
         def logs = IssueLog.findAllByIssue(issue)
         def conversation = new Conversation()
         if(issue.conversation){
            conversation = issue.conversation
         }
         logs.each { IssueLog log ->
            def comment = new IssueComment()
            if(log.comment)
               comment.content =  log.comment
            comment.dateCreated = log.date
            comment.user = log.user
            comment.project = issue.project
            comment.issue = issue

            if(log.changes){
               comment.content += "\n\n" + log.changes.collect { c -> "**$c.property** cambio de **$c.originalValue** a **$c.newValue**" }.join("\n\n")
            }
            if(comment.content){
               comment.save(flush:true)
               conversation.addToComments(comment)
            }
         }

         conversation.save(flush:true)
         issue.conversation = conversation
         issue.save(flush:true)
      }

   }

   def migrateCommentsV2(){
      def db = new Sql(dataSource)
      println "creando columnas"
      db.execute("alter table comment_ add column project_id bigint null")
      db.execute("alter table comment_ add column class varchar(255) null")
      println "recorriendo conversaciones"
      def conversations = Conversation.list()
      for(Conversation conversation: conversations){
         for(Comment comment : conversation.comments){
            def issue = Issue.findByConversation(conversation)
            if(issue) {
               db.execute("update comment_ set project_id = ?, class = ?, issue_id = ? where id = ?",
                     [issue.project.id, 'org.nopalsoft.mercury.domain.IssueComment', issue.id, comment.id])
            }else{
               def message = Message.findByConversation(conversation)
               if(!message) continue

               db.execute("update comment_ set project_id = ?, class = ?, message_id = ? where id = ?",
                     [message.project.id, 'org.nopalsoft.mercury.domain.MessageComment', message.id, comment.id])
            }

         }
      }
      println "eliminando comentarios huerfanos"
      db.execute("delete from comment_ where id not in (select comment_id from conversation_comment_)")
      db.execute("delete from conversation_comment_ where comment_id in (select id from comment_ where project_id is null)")
      db.execute("delete from comment_ where project_id is null")
      println "set not null a columnas"
      db.execute("alter table comment_ alter column project_id set not null")
      db.execute("alter table comment_ alter column class set not null")
      println "fin"
   }

   def migrateProjects(){
      def projects = Project.list()
      def workspace = new Workspace()
      workspace.name = "Default workspace"
      workspace.owner = User.findByUsername('cesarreyesa')
      if(workspace.save(flush: true)){
         for(def project in projects){
            project.workspace = workspace
            project.save(flush: true)
         }
      }
   }

   def destroy = {
   }
}