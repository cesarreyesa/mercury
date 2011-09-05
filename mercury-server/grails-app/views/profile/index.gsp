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
   <g:render template="/shared/profileMenu"/>
</content>

<div class="content">
   <h2 class="title">Update your profile</h2>

   <g:form action="save" class="form">
      <g:hiddenField name="id" value="${user.id}"/>
      <div class="clearfix">
         <label for="username">Usuario:</label>
         <div class="input"><g:textField name="username" value="${user.username}"/></div>
      </div>

      <div class="clearfix">
         <label for="firstName">Nombre</label>
         <div class="input"><g:textField name="firstName" value="${user.firstName}"/></div>
      </div>

      <div class="clearfix">
         <label for="lastName">Apellido</label>
         <div class="input"><g:textField name="lastName" value="${user.lastName}"/></div>
      </div>

      <div class="clearfix">
         <label for="email">Email</label>
         <div class="input"><g:textField name="email" value="${user.email}"/></div>
      </div>

      <div class="actions">
         <g:submitButton name="save" class="btn primary" value="Guardar"/>
      </div>
   </g:form>

   <div style="margin-top:20px;"></div>

   <h2 class="title">Cambie su contrase&ntilde;a</h2>

   <g:form action="changePassword" class="form">
      <g:hiddenField name="id" value="${user.id}"/>

      <div class="clearfix">
         <label>Ingrese su nueva contrase&ntilde;a y confirmela</label>
         <div class="input"><g:passwordField name="password"/>
         <g:passwordField name="confirmPassword"/></div>
      </div>

      <div class="actions">
         <g:submitButton name="save" class="btn primary" value="Guardar"/>
      </div>
   </g:form>
</div>

</body>
</html>