<%-- User: cesarreyes Date: 25/11/10 Time: 20:17 --%>Hey, we heard you lost your password.  Say it ain't so!

Use the following link within the next 24 hours to reset your password:

${createLink(controller: "login", action: "recoverPassword", params: ["token": token], absolute: true)}

Thanks


<g:render template="/emails/footer"/>