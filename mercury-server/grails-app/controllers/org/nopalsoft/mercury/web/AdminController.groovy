package org.nopalsoft.mercury.web

import org.nopalsoft.mercury.domain.User

class AdminController {

  def index = {
    def users = User.listOrderByUsername()
    [users: users]
  }

  def editUser = {
    def user = User.get(params.id)
    [user:user]
  }
}
