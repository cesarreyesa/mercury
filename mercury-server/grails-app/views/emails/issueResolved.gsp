<%-- User: cesarreyes Date: 21/11/10 Time: 20:33 --%>
Se ha resuelto la ${message(code: 'nectar.task.lower')}: ${issue.code}. Resolucion: ${resolution.code}

${issue.description}

${createLink(controller: "issues", action: "view", id: issue.id, absolute: true)}

${comment}


<g:render template="/emails/footer"/>