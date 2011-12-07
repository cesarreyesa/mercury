<%--
  User: cesarreyes
  Date: 06/12/10
  Time: 23:35
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <title>Editar projecto</title>
   <meta content="main" name="layout"/>
</head>

<body>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'main']"/>
</content>

<ul class="tabs">
   <li><g:link action="index">Usuarios</g:link></li>
   <li class="active"><g:link action="projects">Proyectos</g:link></li>
   <li><a href="#block-forms-2">Catalogos</a></li>
   <li><a href="#block-messages">Herramientas</a></li>
</ul>

<div class="content">
   <h2>Editar proyecto</h2>

   <g:form action="updateProject" id="${project.id}" class="form">
      <g:hasErrors bean="${project}">
         <div class="errors">
            <g:renderErrors bean="${project}" as="list"/>
         </div>
      </g:hasErrors>
      <div class="clearfix">
         <label for="workspace.id">Workspace</label>
         <div class="input">
            <g:select from="${workspaces}" name="workspace.id" optionKey="id" optionValue="name"/>
         </div>
      </div>

      <div class="clearfix">
         <label for="code">Codigo</label>
         <div class="input"><g:textField name="code" value="${project.code}"/></div>
      </div>

      <div class="clearfix">
         <label for="name">Nombre</label>
         <div class="input"><g:textField name="name" value="${project.name}"/></div>
      </div>

      <div class="clearfix">
         <label for="description">Descripci&oacute;n</label>
         <div class="input"><g:textArea name="description" rows="5" cols="30" value="${project.description}"/></div>
      </div>

      <div class="actions">
         <g:submitButton name="save" class="btn primary" value="Guardar"/>
         <g:link action="projects">cancelar</g:link>
      </div>
   </g:form>
</div>

</body>
</html>