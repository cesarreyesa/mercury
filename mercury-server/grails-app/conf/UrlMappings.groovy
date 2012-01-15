import grails.util.GrailsUtil

class UrlMappings {

   static mappings = {
      "/$controller/$action?/$id?" {
         constraints {
            // apply constraints here
         }
      }

      "/"(controller: "home")
      if(GrailsUtil.getEnvironment() == "development") {
         "500"(view: '/error')
      }else{
         "500"(view: '/error/serverError')
      }
   }
}
