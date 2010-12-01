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
  <g:render template="/shared/menu" model="[selected:'main']"/>
</content>

<div id="main">
  <div class="block" id="block-tables">
    <div class="secondary-navigation">
      <ul class="wat-cf">
        <li class="first active"><g:link controller="project">General</g:link></li>
        <li><g:link controller="project" action="users">Usuarios</g:link></li>
      </ul>
    </div>
    <div class="content">
      <h2 class="title">Configuracion del proyecto</h2>
      <div class="inner">
        <g:form action="save" class="form">
          <g:hiddenField name="id" value="${project.id}"/>
          <g:if test="${flash.message}">
            <div class="flash">
              <div class="message error">
                ${flash.message}
              </div>
            </div>
          </g:if>
          <g:if test="${flash.success}">
            <div class="flash">
              <div class="message notice">
                ${flash.success}
              </div>
            </div>
          </g:if>
          <div class="group">
            <label for="code" class="label">Codigo</label>
            <g:textField name="code" value="${project.code}"/>
          </div>
          <div class="group">
            <label for="name" class="label">Nombre</label>
            <g:textField name="name" value="${project.name}"/>
          </div>
          <div class="group">
            <label for="description" class="label">Descripcion</label>
            <g:textArea name="description" value="${project.description}"/>
          </div>
          <div class="group">
            <label for="lead.id" class="label";>Lider de proyecto</label>
            <g:select name="lead.id" value="${project.lead.id}" from="${project.users}" optionKey="id" optionValue="fullName" noSelection="['': '']"/>
          </div>
          <div class="group navform wat-cf">
            <button class="button" type="submit">
              <img src="${resource(dir:'images/icons', file:'tick.png')}" alt="Guardar" /> Guardar
            </button>
          </div>
        </g:form>
      </div>
    </div>
  </div>
</div>

</body>
</html>