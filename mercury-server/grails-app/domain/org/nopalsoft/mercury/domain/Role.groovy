package org.nopalsoft.mercury.domain

/**
 * Authority domain class.
 */
class Role {

  static hasMany = [people: User]

  /** description  */
  String description
  /** ROLE String  */
  String authority

  static constraints = {

    authority(blank: false, unique: true)
    description()
  }

  static mapping = {
    id name: 'authority'
    authority (column: 'name')
    version false
    people joinTable:[name:'user_role', key:'role_name', column:'user_id']
  }
}
