<%--
  User: cesarreyes
  Date: 10/12/11
  Time: 22:48
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <meta content="main" name="layout">
   <title>Workspace</title>
</head>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'main']"/>
</content>

<body>

<ul class="nav nav-tabs">
   <li class="first active"><g:link controller="workspace">General</g:link></li>
   <li><g:link controller="workspace" action="users" id="${workspace.id}">Usuarios</g:link></li>
</ul>

<div class="content">

   <h2>Configuracion del workspace</h2>

   <g:form action="save" class="form">
      <g:hiddenField name="id" value="${workspace.id}"/>

      <div class="control-group">
         <label for="name">Nombre</label>

         <div class="controls">
            <g:textField name="name" value="${workspace.name}"/>
         </div>
      </div>

      <div class="actions">
         <g:submitButton name="save" class="btn btn-primary" value="Guardar"/>
      </div>
   </g:form>

</div>


</body>
</html>