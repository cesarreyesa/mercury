import org.nopalsoft.mercury.domain.Project

class CustomFilters {
  def filters = {
    chooseProject(controller:'*', action:'*'){
      before = {
        if(!session.project){
          def cookie = request.cookies.find { it.name == 'projectId'}
          if(cookie != null){
            session.project = Project.get(cookie.value)
          }
          if(!session.project){
            // redirect
          }
        }
      }
    }
  }
}