package org.nopalsoft.mercury.web

class ErrorController {

   def serverError = {
      render(view: 'error')
   }

   def notFound = {
      render(view: 'notFound')
   }
}
