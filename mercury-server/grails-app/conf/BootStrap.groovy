import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Role

class BootStrap {

  def springSecurityService

  def init = {servletContext ->
    String.metaClass.'static'.randomString = { length ->
      // The chars used for the random string
      def list = ('a'..'z')+('A'..'Z')+('0'..'9')
      // Make sure the list is long enough
      list = list * (1+length / list.size())
      // Shuffle it up good
      Collections.shuffle(list)
      length > 0 ? list[0..length-1].join() : ''
    }
    def admin = User.findByUsername("cesar.reyes")
//    if (admin) {
//      if (!admin.authorities) {
//        def role = new Role(authority: "ROLE_ADMIN", description: "Administrator")
//        role.save()
//        admin.addToAuthorities role
//        if (admin.save()) {
//          println "Updated admin user: cesar.reyes"
//        } else {
//          pringln "Admin user cesar.reyes not updated: ${admin.errors}"
//        }
//      }
//    }else {
//      admin = new User()
//      admin.username = "cesar.reyes"
//      admin.password = authenticateService.encodePassword("21Chivas")
////      admin.userRealName = "Cesar Reyes"
//      admin.email = "cesar@mexicovenuefinders.com"
//      admin.enabled = true
//      def role = new Role(authority: "ROLE_ADMIN", description: "Administrator")
//      role.save()
//      admin.addToAuthorities role
//      if (admin.save()) {
//        println "Created admin user: cesar.reyes"
//      } else {
//        pringln "Admin user cesar.reyes not created: ${admin.errors}"
//      }
//    }
  }
  def destroy = {
  }
}