package org.nopalsoft.mercury.domain

class IssueLog {

  Issue issue
  User user
  Date date
  String comment
  List changes
  static hasMany = [changes:LogChange]

  static constraints = {
    comment maxSize: 4000
  }

  static mapping = {
    id generator: 'increment'
    version false
    date column: 'date_'
    comment column: 'comment_'
    changes column:'issue_log_id'
//    changes joinColumn:[name:"issue_log_id", updatable: true]
  }
}
