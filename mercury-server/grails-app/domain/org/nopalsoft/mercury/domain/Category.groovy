package org.nopalsoft.mercury.domain

class Category {

  String name

  static belongsTo = [project: Project]

  static constraints = {
    name(unique: true, blank: false)
  }

  public String toString(){
    name
  }
}
