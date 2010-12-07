package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Role
import org.nopalsoft.mercury.domain.Project

class AdminController {

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
    [projects:projects]
  }
}
