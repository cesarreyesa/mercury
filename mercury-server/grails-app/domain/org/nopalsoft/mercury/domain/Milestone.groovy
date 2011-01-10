package org.nopalsoft.mercury.domain

class Milestone {

  String name
  Date startDate
  Date endDate
  Project project
  static hasMany = [issues: Issue]
//  List issues

  def moveUp(issue){
    issues.eachWithIndex(){ o, idx ->
      if ((o.id == issue.id) && idx > 0) {
        def swap = issues[idx-1]
        issues[idx-1] = issues[idx]
        issues[idx] = swap
        save()
        return
      }
    }
  }

  def moveDown(issue){
    def max = issues.size()
    def index = 0
    issues.eachWithIndex(){ o, idx ->
      if ((o.id == issue.id)) {
        index = idx
        return
      }
    }
    if(index < issues.size()){
      Collections.swap(issues, index, index + 1)
      save()
    }
  }

  static constraints = {
    name(unique: true, blank: false)
    startDate(nullable: false)
    endDate(nullable: false)
  }

  static mapping = {
    version false
    id generator: 'increment'
    project(nullable: false, lazy: true)
    issues(inverse:true)
  }
}
