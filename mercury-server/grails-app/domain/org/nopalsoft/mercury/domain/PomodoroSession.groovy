package org.nopalsoft.mercury.domain

class PomodoroSession {

   Date dateStarted
   Date dateEnd
   int secondsElapsed
   Issue issue
   User user
   boolean completed

   static constraints = {
      dateStarted(nullable: false)
      dateEnd(nullable: true)
      issue(nullable: false)
      user(nullable: false)
   }
}
