<%--
  User: cesarreyes
  Date: 12/12/10
  Time: 10:23
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <title>Agregar proyecto</title>
   <meta content="main" name="layout"/>
</head>

<body>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'main']"/>
</content>

<ul class="nav nav-tabs">
   <li><g:link action="index">Usuarios</g:link></li>
   <li class="active"><g:link action="projects">Proyectos</g:link></li>
   <li><a href="#block-forms-2">Catalogos</a></li>
   <li><a href="#block-messages">Herramientas</a></li>
</ul>

<div class="content">
   <h2>Agregar proyecto</h2>

   <g:form action="saveProject" class="form-stacked">
      <g:hasErrors bean="${project}">
         <div class="errors">
            <g:renderErrors bean="${project}" as="list"/>
         </div>
      </g:hasErrors>
      <div class="clearfix">
         <label for="code">C&oacute;digo</label>
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
         <g:submitButton name="save" class="btn btn-primary" value="Guardar"/>
         <g:link action="projects">cancelar</g:link>
      </div>
   </g:form>
</div>

<script type="text/javascript">
   $(function() {
      $('#code').focus();
   });
</script>

</body>
</html>