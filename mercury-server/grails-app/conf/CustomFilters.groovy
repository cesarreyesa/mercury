import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Workspace
import javax.servlet.http.Cookie

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
//            if (!request.project && request.changeProject != 'true') {
//               if (user && user.settings.projectId) {
//                  request.project = Project.get(user.settings.projectId)
//               }
//               else if (controllerName != 'home' && actionName != 'changeProject') {
//                  //redirect controller: 'home', action: 'chooseProject'
//                  return
//               }
//            }
            def workspaceCookie = getCookie(request, "workspace")
            if(workspaceCookie){
               def workspace = Workspace.get(Long.parseLong(workspaceCookie.value))
               session.workspace = workspace
               println "tomando el workspace $workspace.name de los cookies"
            }
            if(!request.project){
               def projectCookie = getCookie(request, "project")
               if(projectCookie){
                  def project = Project.get(Long.parseLong(projectCookie.value))
                  request.project = project
                  println "tomando el proyecto $project.name de los cookies"
               }
            }
            if(session.workspace){
               def projects = Project.findAllByWorkspace(session.workspace)
               request.workspaceProjects = projects
               if(request.project){
                  if(projects && !projects.id.contains(request.project.id)){
                     println "el proyecto $request.project.name no se encuentra dentro del workspace"
                     request.project = projects.first()
                     println "se selecciona el primer proyecto $request.project del workspace"
                     setCookie(response, "project", request.project.id.toString(), 60 * 24 * 30)
                  }else{
                     println "el proyecto $request.project se encuentra dentro del workspace"
                  }
               }else if(projects){
                  request.project = projects.first()
                  println "se selecciona el primer proyecto $request.project del workspace"
               }
            }else{
               println "no hay workspace seleccionado"
            }
         }
      }
   }

   private void setCookie(response, name, value, maxAge) {
      Cookie cookie = new Cookie(name, value)
      cookie.setMaxAge(maxAge)
//      cookie.domain = "/"
      cookie.path = "/"
      response.addCookie(cookie)
   }

   private Cookie getCookie(request, name) {
        def cookies = request.getCookies()
        if (cookies == null || name == null || name.length() == 0) {
            return null
        }
        // Otherwise, we have to do a linear scan for the cookie.
        for (int i = 0; i < cookies.length; i++) {
            if (cookies[i].name.equals(name)) {
                return cookies[i]
            }
        }
        return null;
    }
}