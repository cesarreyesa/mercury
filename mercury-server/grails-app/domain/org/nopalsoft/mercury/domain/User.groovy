package org.nopalsoft.mercury.domain

/**
 * org.nopalsoft.mercury.domain.User domain class.
 */
class User {
  static transients = ['pass']
  static hasMany = [authorities: Role]
  static belongsTo = Role

  /** Username   */
  String username
  String firstName
  String lastName
  /** MD5 Password   */
  String password
  /** enabled   */
  boolean enabled
  boolean accountLocked
  boolean passwordExpired
  boolean accountExpired

  String email

  def getFullName() {
    return "$firstName $lastName";
  }
//  boolean emailShow

  /** description   */
//  String description = ''

  /** plain password to create a MD5 password   */
  String pass = '[secret]'

  static constraints = {
    username(blank: false, unique: true)
//    fullName(blank: false)
    password(blank: false)
    enabled()
  }

  static mapping = {
    table 'app_user'
    version false
    enabled column: 'account_enabled'
    accountLocked column: 'account_locked'
    passwordExpired column: 'credentials_expired'
    authorities joinTable: [name: 'user_role', key: 'user_id', column: 'role_name']
  }
}
