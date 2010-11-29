package org.nopalsoft.mercury.domain

class Milestone {
  Long id;
  String name;
  Date startDate;
  Date endDate;
  static belongsTo = [project: Project]
  static hasMany = [issues: Issue]


  static constraints = {
    name(unique: true, blank: false)
    startDate(nullable: true)
    endDate(nullable: true)
  }

  static mapping = {
    project(nullable: false, lazy: true)
  }
}
