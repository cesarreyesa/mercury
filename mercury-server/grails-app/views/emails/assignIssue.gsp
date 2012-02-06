<%--
  User: cesarreyes
  Date: 21/11/10
  Time: 20:27
--%>
${createdBy.fullName} le ha asignado una incidencia: ${issue.code}.

Tipo: ${message(code: 'issueType.' + issue.issueType.code)}
Estado: ${message(code: 'status.' + issue.status.code)}
<g:if test="${issue.status.name == 'Resolved'}">Resolucion: ${message(code: 'resolution.' + issue.resolution.code)}</g:if>
Prioridad: ${message(code: 'priority.' + issue.priority.code)}
${message(code: 'issue.reporter')}: ${issue.reporter.fullName}

URL: ${createLink(controller: "issues", action: "view", id: issue.id, absolute: true)}

Comentario: ${comment}


Este mail es generado automaticamente por Mercury.