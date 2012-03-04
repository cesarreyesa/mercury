<%-- User: cesarreyes Date: 21/11/10 Time: 16:06 --%>Se ha creado una nueva ${message(code: 'nectar.task.lower')}: ${issue.code}. Creada por ${createdBy.fullName}

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

${createLink(controller: "issues", action: "view", id: issue.id, absolute: true)}


<g:render template="/emails/footer"/>