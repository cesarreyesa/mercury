package org.nopalsoft.mercury.domain

class IssueAttachment {

  String description
  String file
  User addedBy
  Date date

  static belongsTo = [issue:Issue]

  public IssueAttachment(){
  }

  public IssueAttachment(String file, String description, User addedBy, Date date){
      this.file = file
      this.description = description
      this.addedBy = addedBy
      this.date = date
  }

  public IssueAttachment(String file, Date date){
      this.file = file
      this.date = date
  }

  static constraints = {

  }

  static mapping = {
    id generator: 'increment'
    version false
    description column: 'description_'
    file column: 'file_'
    addedBy column: 'added_by_id'
    date column: 'date_'
  }
}
