<%--
  Created by IntelliJ IDEA.
  User: cesarreyes
  Date: 28/11/10
  Time: 23:34
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <title>Administracion</title>
   <meta name="layout" content="main"/>
</head>

<body>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'main']"/>
</content>

<ul class="nav nav-tabs">
   <li class="active"><a href="#block-text">Usuarios</a></li>
   <li><g:link action="projects">Proyectos</g:link></li>
   <li><a href="#block-forms-2">Catalogos</a></li>
   <li><a href="#block-messages">Herramientas</a></li>
</ul>

<div class="content">
   <div class="row">
      <div class="span6">
         <h2 class="title">Usuarios</h2>
      </div>
      <div class="span1 offset5">
         <g:link action="addUser" class="btn btn-primary">Agregar</g:link>
      </div>
   </div>


   <p>
   <div class="btn-group" data-toggle="buttons-radio">
      <g:link params="[active:'active']" class="btn ${params.active != 'inactive' ? 'active' : ''}">Activos</g:link>
      <g:link params="[active:'inactive']" class="btn ${params.active == 'inactive' ? 'active' : ''}">Inactivos</g:link>
   </div>
   </p>

   <table class="table table-striped table-bordered table-condensed">
      <tr>
         <th>Usuario</th>
         <th>Nombre</th>
         <th>Email</th>
         %{--<th>Idioma</th>--}%
         <th>&nbsp;</th>
      </tr>
      <tbody>
      <g:each in="${users}" var="user">
         <tr>
            <td>${user.username}</td>
            <td>${user.fullName}</td>
            <td>${user.email}</td>
            %{--<td>${user.lastName}</td>--}%
            <td class="last"><g:link action="editUser" id="${user.id}">editar</g:link> | <a href="#">eliminar</a>
            </td>
         </tr>
      </g:each>
      </tbody>
   </table>
</div>

</body>
</html>