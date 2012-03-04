<%-- User: cesarreyes, Date: 14/12/11, Time: 23:31--%>${currentUser.fullName} te ha invitado al workspace ${workspace.name}

${createLink(controller: 'home', absolute: true)}

You're getting this email because a teammate of yours invited this email address to join their workspace on Nectar.
If this was an error, talk to your teammate or email support@nectarapp.com.


<g:render template="/emails/footer"/>