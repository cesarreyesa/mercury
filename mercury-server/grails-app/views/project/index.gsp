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

<ul class="tabs">
   <li class="first active"><g:link controller="project">General</g:link></li>
   <li><g:link action="categories">Categorias</g:link></li>
   <li><g:link controller="project" action="users">Usuarios</g:link></li>
</ul>

<div class="content">

   <g:form action="save">
      <h3>Configuracion del proyecto</h3>
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
      <div class="clearfix">
         <label for="code">Codigo</label>

         <div class="input">
            <g:textField name="code" value="${project.code}"/>
         </div>
      </div>

      <div class="clearfix">
         <label for="name">Nombre</label>

         <div class="input">
            <g:textField name="name" value="${project.name}"/>
         </div>
      </div>

      <div class="clearfix">
         <label for="description">Descripcion</label>

         <div class="input">
            <g:textArea name="description" value="${project.description}"/></div>
      </div>

      <div class="clearfix">
         <label for="lead.id">Lider de proyecto</label>

         <div class="input"><g:select name="lead.id" value="${project.lead.id}" from="${project.users}"
                                      optionKey="id"
                                      optionValue="fullName" noSelection="['': '']"/></div>
      </div>

      <div class="clearfix">
         <label for="currentMilestone.id">Entrega actual</label>

         <div class="input"><g:select name="currentMilestone.id" value="${project.currentMilestone?.id}"
                                      from="${milestones}"
                                      optionKey="id" optionValue="name" noSelection="['': '']"/></div>
      </div>

      <div class="actions">
         <g:submitButton name="save" class="btn primary" value="Guardar"/>
      </div>
   </g:form>
</div>

</body>
</html>