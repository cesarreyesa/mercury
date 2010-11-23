import org.springframework.security.access.vote.RoleVoter

beans = {

  roleVoter(RoleVoter){
    rolePrefix = ""
  }

}