import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Role
import org.codehaus.groovy.grails.commons.ApplicationHolder

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

   def destroy = {
   }
}