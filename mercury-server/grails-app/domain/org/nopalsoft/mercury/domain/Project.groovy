package org.nopalsoft.mercury.domain

class Project {

  String code
  String name
  String description
  Integer lastIssueId
  User lead
  Milestone currentMilestone
//  private List<Component> components = new ArrayList<Component>();
  static hasMany = [users:User]

  static constraints = {
    code(blank: false)
    name(blank: false)
    lastIssueId(nullable: true)
    currentMilestone(nullable: true)
  }
  
  static mapping = {
    version false
    users joinTable:[name:'projetc_user', key:'project_id', column:'user_id']
  }

}
