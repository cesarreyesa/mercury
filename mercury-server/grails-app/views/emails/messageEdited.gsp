<%-- User: cesarreyes, Date: 04/07/11, Time: 23:50 --%><%@ page contentType="text/html;charset=UTF-8" %>Se ha editado un mensaje en Mercury, creado por ${message.user.fullName}

Titulo:
${message.title}

Puedes ver el mensaje completo en:

${createLink(controller: "messages", action: "view", id: message.id, absolute: true)}



Este mail es generado automaticamente por Mercury.