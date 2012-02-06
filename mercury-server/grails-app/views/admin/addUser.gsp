<%--
  User: cesarreyes
  Date: 28/12/10
  Time: 19:51
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <title>Agregar usuario</title>
   <meta content="main" name="layout"/>
</head>

<body>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'main']"/>
</content>

<div class="content">
   <h1>Agregar usuario</h1>

   <g:form action="saveUser" class="form-inline">
      <g:hasErrors bean="${user}">
         <div class="errors">
            <g:renderErrors bean="${user}" as="list"/>
         </div>
      </g:hasErrors>

      <div class="control-group">
         <label for="email">Email</label>
         <div class="controls"><g:textField name="email" value="${user.email}"/></div>
      </div>

      <div class="control-group">
         <label for="firstName">Nombre</label>
         <div class="controls"><g:textField name="firstName" value="${user.firstName}"/></div>
      </div>

      <div class="control-group">
         <label for="lastName">Apellido</label>
         <div class="controls"><g:textField name="lastName" value="${user.lastName}"/></div>
      </div>

      <div class="control-group">
         <label for="password">Contrase&ntilde;a</label>
         <div class="controls"><g:passwordField name="password"/></div>
      </div>

      <div class="control-group">
         <label for="enabled">Activo</label>
         <div class="controls"><g:checkBox name="enabled" value="${user.enabled}"/></div>
      </div>

      <div class="form-actions">
         <button class="btn btn-primary" type="submit">Guardar</button>
         <g:link action="index" class="button">cancelar</g:link>
      </div>
   </g:form>
</div>

<script type="text/javascript">
   $(function() {
      $('#username').focus();
   });
</script>
</body>
</html>