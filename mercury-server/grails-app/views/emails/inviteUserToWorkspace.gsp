<%-- User: cesarreyes, Date: 14/12/11, Time: 23:31--%>
${invitation.workspace.name} is getting organized on Nectar

Join ${invitation.user} and the rest of your team by clicking below

${grailsApplication.config.grails.serverURL}${createLink(controller: 'join', params:[token: invitation.token])}

You're getting this email because a teammate of yours invited this email address to join their workspace on Nectar.
If this was an error, talk to your teammate or email support@nectarapp.com.