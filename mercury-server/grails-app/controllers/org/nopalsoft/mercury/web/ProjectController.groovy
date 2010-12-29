package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.Project
import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Milestone

class ProjectController {

  def index = {
    def project = Project.get(session.project.id)
    def milestones = Milestone.findAllByProject(project)
    [project: project, milestones: milestones]
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
    def users = User.findAllByEnabled(true)

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

  def deleteUser = {
    if(request.post){
      def project = Project.get(params.id)
      def user = User.get(params.userId)
      project.removeFromUsers user
      if(project.save(flush:true)){
        flash.success = "Se elimino al usuario correctamente"
        redirect action:'users'
      }
    }
  }

  def categories = {
    def project = Project.get(session.project.id)
    def categories = org.nopalsoft.mercury.domain.Category.findAllByProject(project)
    [project: project, categories: categories]
  }

  def addCategory = {
    def project = Project.get(session.project.id)
    def category = new org.nopalsoft.mercury.domain.Category(name: params.name)
    category.project = project
    if(category.save(flush:true)){
      redirect action:'categories'
    }
  }
}
