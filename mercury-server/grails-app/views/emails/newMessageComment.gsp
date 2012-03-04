<%-- User: cesarreyes, Date: 08/07/11, Time: 08:42--%><%@ page contentType="text/html;charset=UTF-8" %>Se ha comentado sobre un mensaje en Mercury, creado por ${comment.user.fullName}

Mensaje:
${message.title}

Comentario:
${comment.content}

Puedes ver el mensaje completo en:
${createLink(controller: "messages", action: "view", id: message.id, absolute: true)}


<g:render template="/emails/footer"/>