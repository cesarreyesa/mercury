package org.nopalsoft.mercury.domain

class Milestone {

  String name
  Date startDate
  Date endDate
  Project project
  static hasMany = [issues: Issue]

  static constraints = {
    name(unique: true, blank: false)
    startDate(nullable: false)
    endDate(nullable: false)
  }

  static mapping = {
    version false
    id generator: 'increment'
    project(nullable: false, lazy: true)
  }
}
