package org.nopalsoft.mercury.domain

class IssueComment extends Comment {

   IssueComment() {
   }

   IssueComment(Issue issue, String action) {
      this.issue = issue
      this.project = issue.project
      this.action = action
   }

   String action
   Issue issue

   /**
    * Es un usuario relacionado con el comentario/accion. En el caso de una asignacion, es la persona asignada.
    */
   User relatedUser

   static constraints = {
      relatedUser(nullable: true)
   }
}
