package org.nopalsoft.mercury.domain

class Status {

  Long id
  String code
  String name  

  static constraints = {
  }

  static mapping = {
    table 'admin_status'
    version false
  }
}
