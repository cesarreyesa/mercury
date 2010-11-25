import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.User

class CustomFilters {

  def springSecurityService

  def filters = {
    chooseProject(controller:'*', action:'*'){
      before = {
        if(!session.project && params.changeProject != 'true'){
          def user = User.get(springSecurityService.principal.id)
          if(user && user.settings.projectId){
            session.project = Project.get(user.settings.projectId)
          }
          else if(controllerName != 'home' && actionName != 'changeProject'){
            redirect controller:'home', action:'chooseProject'
          }
        }
      }
    }
  }
}