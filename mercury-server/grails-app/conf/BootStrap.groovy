import org.nopalsoft.mercury.domain.User
import org.nopalsoft.mercury.domain.Role

class BootStrap {

  def springSecurityService

  def init = {servletContext ->
    def admin = User.findByUsername("cesar.reyes")
    println springSecurityService.encodePassword("21Tangolunda")
    println admin.password
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