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
   }

   private addDynamicMethods(klass) {

      klass.metaClass.isMobileDevice = {
         def device = request.getAttribute("currentDevice")
         device.isMobile()
      }
   }

   def destroy = {
   }
}