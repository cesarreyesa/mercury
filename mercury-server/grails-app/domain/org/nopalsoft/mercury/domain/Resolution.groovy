package org.nopalsoft.mercury.domain

class Resolution {

  String code
  String name
  String description

  static constraints = {
    code(blank: false)
    name(blank: false)
  }

  static mapping = {
    id generator:'increment'
    version false
  }
}
