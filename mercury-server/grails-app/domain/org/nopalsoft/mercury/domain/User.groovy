package org.nopalsoft.mercury.domain

/**
 * org.nopalsoft.mercury.domain.User domain class.
 */
class User {
   static transients = ['pass', 'workingOn']
   static hasMany = [authorities: Role]
   static belongsTo = Role

   /** Username    */
   String username
   String firstName
   String lastName
   /** MD5 Password    */
   String password
   /** enabled    */
   boolean enabled
   boolean accountLocked
   boolean passwordExpired
   boolean accountExpired

   String email

   Map settings

   def getFullName() {
      return "$firstName $lastName";
   }
//  boolean emailShow

   /** description    */
//  String description = ''

   /** plain password to create a MD5 password    */
   String pass = '[secret]'

   static constraints = {
      username(blank: false, unique: true)
//    fullName(blank: false)
      password(blank: false)
      enabled()
   }

   static mapping = {
      id generator: 'increment'
      table 'app_user'
      version false
      enabled column: 'account_enabled'
      accountLocked column: 'account_locked'
      passwordExpired column: 'credentials_expired'
      authorities joinTable: [name: 'user_role', key: 'user_id', column: 'role_name']
   }

   public String toString() {
      fullName
   }

   public boolean isInProject(Project project){
      return project?.users?.id?.contains(id)
   }

   public boolean isProjectLead(Project project){
      return project?.lead?.id == id
   }

   public Issue workingOn(){
      def issueId = settings["WorkingOn"]
      if(issueId){
         return Issue.get(Long.parseLong(issueId.toString()))
      }
      return null
   }


}
