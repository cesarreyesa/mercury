package org.nopalsoft.mercury.domain

class LogChange {

  static belongsTo = IssueLog
  String property
  String originalValue
  String newValue

  public LogChange(String property, String originalValue, String newValue) {
      this.property = property;
      this.originalValue = originalValue;
      this.newValue = newValue;
  }

  static constraints = {
    property blank:false
    originalValue maxSize: 4000
    newValue maxSize: 4000
  }

  static mapping = {
    id generator:'increment'
    version false
  }
}
