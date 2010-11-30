package org.nopalsoft.mercury.domain

class Milestone {
  String name;
  Date startDate;
  Date endDate;
  static belongsTo = [project: Project]
  static hasMany = [issues: Issue]


  static constraints = {
    name(unique: true, blank: false)
    startDate(nullable: false)
    endDate(nullable: false)
  }

  static mapping = {
    project(nullable: false, lazy: true)
  }
}
