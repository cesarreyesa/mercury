package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.User

class ProjectController {

  def index = {
    def project = Project.get(session.project.id)
    [project: project]
  }

  def save = {
    def project = Project.get(params.id)
    project.properties = params
    if(!project.hasErrors() && project.save(flish:true)){
      flash.success = "Se actualizo correctamente el proyecto."
      redirect action:'index'
    }else{
      flash.message = "Hubo un error al salvar el proyecto"
      render(view:'index', model:[project:project])
    }
  }

  def users = {
    def project = Project.get(session.project.id)
    def users = User.list()

    [project: project, usersNotInProject: users]
  }

  def addUser = {
    if(request.post){
      def project = Project.get(params.id)
      def user = User.get(params.long('user.id'))
      project.addToUsers(user)
      if(project.save(flush:true)){
        flash.success = "Se agrego al usuario correctamente"
        redirect action:'users'
      }
    }
  }
}
