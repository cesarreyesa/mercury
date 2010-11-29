package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project

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
}
