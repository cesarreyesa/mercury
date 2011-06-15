import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.User

class CustomFilters {

   def springSecurityService

   def filters = {
      chooseProject(controller: '*', action: '*') {
         before = {
            User user = null
            if(springSecurityService.principal instanceof org.codehaus.groovy.grails.plugins.springsecurity.GrailsUser){
               user = User.get(springSecurityService.principal.id)
               session.user = user
            }
            if (!session.project && params.changeProject != 'true') {
               if (user && user.settings.projectId) {
                  session.project = Project.get(user.settings.projectId)
               }
               else if (controllerName != 'home' && actionName != 'changeProject') {
                  //redirect controller: 'home', action: 'chooseProject'
                  return
               }
            }
         }
      }
   }
}