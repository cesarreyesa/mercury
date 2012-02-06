<%--
  User: cesarreyes
  Date: 21/11/10
  Time: 20:33
--%>
Se ha resuelto la incidencia: ${issue.code}. Resolucion: ${resolution.code}

${issue.description}

${createLink(controller: "issues", action: "view", id: issue.id, absolute: true)}

${comment}


Este mail es generado automaticamente por Mercury.