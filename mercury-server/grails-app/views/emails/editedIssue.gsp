<%--
  User: cesarreyes
  Date: 02/01/11
  Time: 19:03
--%>
Se ha editado la incidencia: ${issue.code}. Editada por ${editedBy.fullName}

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

${grailsApplication.config.grails.serverURL}/issues/view/${issue.code}


Este mail es generado automaticamente por Mercury.