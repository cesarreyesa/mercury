<%--
  User: cesarreyesa
  Date: 28-feb-2010
  Time: 21:05:42
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Configuracion del proyecto</title>
  <meta name="layout" content="main"/>
</head>
<body>
<content tag="navbar">
  <li><g:link controller="home">${session.project.name}</g:link></li>
  <li class="selected"><g:link controller="project">General</g:link></li>
  <li><g:link controller="project" action="users">Usuarios</g:link></li>
</content>

<g:form action="save" class="form">
  <g:hiddenField name="id" value="${project.id}"/>
  <h1>Configuracion del proyecto</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <table class="fields">
    <tr>
      <th><label for="code">Codigo</label></th>
      <td><g:textField name="code" value="${project.code}"/></td>
    </tr>
    <tr>
      <th><label for="name">Nombre</label></th>
      <td><g:textField name="name" value="${project.name}"/></td>
    </tr>
    <tr>
      <th><label for="description">Descripcion</label></th>
      <td><g:textArea name="description" value="${project.description}"/></td>
    </tr>
    <tr>
      <th><label for="lead.id">Lider de proyecto</label></th>
      <td><g:select name="lead.id" value="${project.lead.id}" from="${project.users}" optionKey="id" optionValue="fullName" noSelection="['': '']"/></td>
    </tr>
    <tr class="buttons">
      <td colspan="2">
        <g:submitButton name="save" value="Save"/>
      </td>
    </tr>
  </table>
</g:form>

</body>
</html>