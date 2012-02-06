<%--
  User: cesarreyes
  Date: 28/11/10
  Time: 23:48
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <title>Edit user</title>
   <meta content="main" name="layout"/>
</head>

<body>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'main']"/>
</content>

<ul class="nav nav-tabs">
   <li class="active"><g:link action="editUser" id="${user.id}">Editar</g:link></li>
   <li><g:link action="editRoles" id="${user.id}">Permisos</g:link></li>
</ul>

<div class="content">
   <h2 class="title">Editar usuario</h2>

   <div class="inner">
      <g:form action="updateUser" class="form">
         <g:hiddenField name="id" value="${user.id}"/>

         <div class="clearfix">
            <label for="username">Usuario</label>
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

         <div class="clearfix">
            <label for="enabled">Activo</label>
            <div class="input"><g:checkBox name="enabled" value="${user.enabled}"/></div>
         </div>

         <div class="actions">
            <g:submitButton name="save" class="btn btn-primary" value="Guardar"/>
            <g:link action="index">cancelar</g:link>
         </div>
      </g:form>
   </div>
</div>

</body>
</html>