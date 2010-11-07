package org.nopalsoft.mercury.domain

class Project {

  String code
  String name
  String description
  Integer lastIssueId
  User lead
//  private Milestone currentMilestone;
//  private List<Component> components = new ArrayList<Component>();
//  private List<User> users = new ArrayList<User>();

  static constraints = {
    code(blank: false)
    name(blank: false)
    description(blank: false)
  }
  
  static mapping = {
    version false
  }

}
