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

<div id="main">
  <div class="block" id="block-tables">
    <div class="secondary-navigation">
      <ul class="wat-cf">
        <li class="first active"><a href="#block-text">Usuarios</a></li>
        <li><a href="#block-forms">Proyectos</a></li>
        <li><a href="#block-forms-2">Catalogos</a></li>
        <li><a href="#block-messages">Herramientas</a></li>
      </ul>
    </div>

    <div class="content">
      <h2 class="title">Usuarios</h2>
      <div class="inner">
        <table class="table">
          <thead>
            <tr>
              <th>Usuario</th>
              <th>Nombre</th>
              <th>Email</th>
              %{--<th>Idioma</th>--}%
              <th>&nbsp;</th>
            </tr>
          </thead>
          <tbody>
            <g:each in="${users}" var="user">
              <tr>
                <td>${user.username}</td>
                <td>${user.fullName}</td>
                <td>${user.email}</td>
                %{--<td>${user.lastName}</td>--}%
                <td class="last"><g:link action="editUser" id="${user.id}">edit</g:link> | <a href="#">delete</a></td>
              </tr>
            </g:each>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

</body>
</html>