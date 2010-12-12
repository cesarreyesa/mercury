<%--
  Created by IntelliJ IDEA.
  User: cesarreyes
  Date: 12/12/10
  Time: 10:23
  To change this template use File | Settings | File Templates.
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

<div id="main">
  <div class="block" id="block-tables">
    <div class="secondary-navigation">
      <ul class="wat-cf">
        <li class="first"><g:link action="index">Usuarios</g:link></li>
        <li class="active"><g:link action="projects">Proyectos</g:link></li>
        <li><a href="#block-forms-2">Catalogos</a></li>
        <li><a href="#block-messages">Herramientas</a></li>
      </ul>
    </div>

    <div class="content">
      <h2 class="title">Agregar proyecto</h2>
      <div class="inner">
        <g:form action="saveProject" class="form">
          <g:hasErrors bean="${project}">
             <div class="errors">
                <g:renderErrors bean="${project}" as="list"/>
             </div>
          </g:hasErrors>
          <div class="group">
            <label class="label">Codigo</label>
            <g:textField name="code" value="${project.code}"/>
          </div>
          <div class="group">
            <label class="label">Nombre</label>
            <g:textField name="name" value="${project.name}"/>
          </div>
          <div class="group">
            <label class="label">Descripci&oacute;n</label>
            <g:textArea name="description" rows="5" cols="30" value="${project.description}" />
          </div>
          <div class="group navform wat-cf">
            <button class="button" type="submit">
              <img src="${resource(dir:'images/icons', file:'tick.png')}" alt="Guardar" /> Guardar
            </button>
            <g:link action="projects" class="button"><img src="${resource(dir:'images/icons', file:'cross.png')}" alt="Cancel"/> Cancel</g:link>
          </div>
        </g:form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  $(function(){
    $('#code').focus();
  });
</script>

</body>
</html>