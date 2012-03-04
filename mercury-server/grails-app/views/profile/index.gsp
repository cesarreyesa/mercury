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
   <g:form action="save" class="form">
      <fieldset>
         <legend>Actualiza tu perfil</legend>
         <g:hiddenField name="id" value="${user.id}"/>
         <div class="controls">
            <label for="email">Email</label>
            <div class="control-group"><g:textField name="email" value="${user.email}"/></div>
         </div>

         <div class="controls">
            <label for="firstName">Nombre</label>
            <div class="control-group"><g:textField name="firstName" value="${user.firstName}"/></div>
         </div>

         <div class="controls">
            <label for="lastName">Apellido</label>
            <div class="control-group"><g:textField name="lastName" value="${user.lastName}"/></div>
         </div>

         <div class="actions">
            <g:submitButton name="save" class="btn btn-primary" value="Guardar"/>
         </div>
      </fieldset>
   </g:form>

   <g:form action="changePassword" class="form">
      <fieldset>
         <legend>Cambie su contrase&ntilde;a</legend>
         <g:hiddenField name="id" value="${user.id}"/>

         <div class="controls">
            <label>Ingrese su nueva contrase&ntilde;a y confirmela</label>
            <div class="control-group"><g:passwordField name="password"/>
               <g:passwordField name="confirmPassword"/></div>
         </div>

         <div class="actions">
            <g:submitButton name="save" class="btn btn-primary" value="Guardar"/>
         </div>
      </fieldset>
   </g:form>


   <fieldset>
      <legend>Cambiar su imagen de perfil</legend>

      <div class="controls">
         <p>Para cambiar su imagen de perfil crea una cuenta gravatar. O si ya la tienes asocia tu correo que usas en Nectar a una imagen de perfil:
            <a href="https://es.gravatar.com/site/signup" target="_blank">https://es.gravatar.com/site/signup</a></p>
      </div>
   </fieldset>
</div>

</body>
</html>