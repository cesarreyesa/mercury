package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Role
import org.nopalsoft.mercury.domain.Project

class AdminController {

  def springSecurityService

  def index = {
    def users = User.listOrderByUsername()
    [users: users]
  }

  def editUser = {
    def user = User.get(params.id)
    [user:user]
  }

  def editRoles = {
    def user = User.get(params.id)
    [user:user, roles: Role.listOrderByAuthority()]
  }

  def addRole = {
    def user = User.get(params.id)
    def role = Role.findByAuthority(params.roleId)
    user.addToAuthorities(role)
    if(user.save(flush:true)){
      redirect action:'editRoles', params:[id:user.id]
    }else{
      flash.message = "Hubo un error al agregar el role"
      render view:'editRoles', model:[user:user]
    }
  }

  def deleteRole = {
    def user = User.get(params.id)
    def role = user.authorities.find { it.authority == params.role }
    user.removeFromAuthorities role
    if(user.save(flush:true)){
      redirect action:'editRoles', params:[id:user.id]
    }else{
      flash.message = "Hubo un error al eliminar el role"
      render view:'editRoles', model:[user:user]
    }
  }

  def projects = {
    def projects = Project.listOrderByName()
    [projects: projects]
  }

  def addProject = {
    def project = new Project()
    [project: project]
  }

  def saveProject = {
    def user = User.get(springSecurityService.principal.id)

    def project = new Project()
    project.properties = params
    project.lead = user
    if(project.validate() && project.save(flush:true)){
      redirect action:'projects'
    }else{
      render view:'addProject', model:[project: project]
    }
  }

  def editProject = {
    def project = Project.get(params.id)
    [project: project]
  }

  def updateProject = {
    def project = Project.get(params.id)
    project.properties = params
    if(project.validate() && project.save(flush:true)){
      redirect action:'projects'
    }else{
      render view:'addProject', model:[project: project]
    }
  }
}
