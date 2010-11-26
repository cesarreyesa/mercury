package org.nopalsoft.mercury.domain

class ResetPasswordRequest {

  User user
  Date date
  String token

  static constraints = {
  }
}
