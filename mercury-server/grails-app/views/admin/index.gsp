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

<ul class="tabs">
   <li class="active"><a href="#block-text">Usuarios</a></li>
   <li><g:link action="projects">Proyectos</g:link></li>
   <li><a href="#block-forms-2">Catalogos</a></li>
   <li><a href="#block-messages">Herramientas</a></li>
</ul>

<div class="content">
   <h2 class="title">Usuarios</h2>

   <div class="inner">
      <table class="table">
         <tr>
            <td colspan="4" align="right"><g:link action="addUser">Agregar</g:link></td>
         </tr>
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
</div>

</body>
</html>