<%--
  User: cesarreyes
  Date: 18/01/12
  Time: 23:25
--%>
La tarea #${issue.code} ha sido programada para iniciarse hoy.

${issue.summary}
${issue.description}

${createLink(controller: "issues", action: "view", id: issue.id, absolute: true)}


Este mail es generado automaticamente por Mercury.