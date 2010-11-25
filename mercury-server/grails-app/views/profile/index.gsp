<%--
  User: cesarreyesa
  Date: 25-feb-2010
  Time: 23:01:38
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Perfil</title>
  <meta name="layout" content="main"/>
</head>
<body>
<content tag="navbar">
  <g:render template="/shared/menu"/>
</content>
<g:form action="save" class="form">
  <g:hiddenField name="id" value="${user.id}"/>
  <h1>Update your profile</h1>
  <table class="fields">
    <tr>
      <th><label for="username">Usuario</label></th>
      <td><g:textField name="username" value="${user.username}"/></td>
    </tr>
    <tr>
      <th><label for="firstName">Nombre</label></th>
      <td><g:textField name="firstName" value="${user.firstName}"/></td>
    </tr>
    <tr>
      <th><label for="lastName">Apellido</label></th>
      <td><g:textField name="lastName" value="${user.lastName}"/></td>
    </tr>
    <tr>
      <th><label for="email">Email</label></th>
      <td><g:textField name="email" value="${user.email}"/></td>
    </tr>
    <tr class="buttons">
      <td colspan="2">
        <g:submitButton name="save" value="Save"/>
      </td>
    </tr>
  </table>
</g:form>

<div style="margin-top:20px;"></div>
<g:form action="changePassword" class="form">
  <g:hiddenField name="id" value="${user.id}"/>

  <h1>Cambie su contrase&ntilde;a</h1>
  <p>Ingrese su nueva contrase&ntilde;a y confirmela</p>
  <table class="fields">
    <tr>
      <td>
        <g:passwordField name="password"/>
        <g:passwordField name="confirmPassword"/>
      </td>
    </tr>
    <tr class="buttons">
      <td colspan="2">
        <g:submitButton name="changePassword" value="Cambiar contraseña"/>
      </td>
    </tr>
  </table>
</g:form>

</body>
</html>