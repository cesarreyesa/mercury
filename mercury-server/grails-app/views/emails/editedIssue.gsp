<%-- User: cesarreyes Date: 02/01/11 Time: 19:03 --%>Se ha editado la ${message(code: 'nectar.task.lower')}: ${issue.code}. Editada por ${editedBy.fullName}

Tipo: ${message(code: 'issueType.' + issue.issueType.code)}
Estado: ${message(code: 'status.' + issue.status.code)}
<g:if test="${issue.status.name == 'Resolved'}">Resolucion: ${message(code: 'resolution.' + issue.resolution.code)}</g:if>
Prioridad: ${message(code: 'priority.' + issue.priority.code)}
${message(code: 'issue.reporter')}: ${issue.reporter.fullName}
${message(code: 'issue.assignee')}: ${issue.assignee?.fullName}

Titulo:
${issue.summary}

Descripcion:
${issue.description}

Comentario:
${comment}

${createLink(controller: "issues", action: "view", id: issue.id, absolute: true)}


<g:render template="/emails/footer"/>