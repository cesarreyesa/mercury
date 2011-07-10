<%--
  User: cesarreyes
  Date: 06/12/10
  Time: 23:29
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Proyectos</title>
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
        <li class="first"><g:link action="index">Usuarios</g:link></li>
        <li class="active"><g:link action="projects">Proyectos</g:link></li>
        <li><a href="#block-forms-2">Catalogos</a></li>
        <li><a href="#block-messages">Herramientas</a></li>
      </ul>
    </div>

    <div class="content">
      <h2 class="title">Proyectos</h2>
      <div class="inner">
        <table class="table">
          <tr>
            <td colspan="3" style="text-align:right;"><g:link action="addProject">[+] agregar</g:link></td>
          </tr>
          <tr>
            <th>Codigo</th>
            <th>Nombre</th>
            <th>&nbsp;</th>
          </tr>
          <tbody>
            <g:each in="${projects}" var="project">
              <tr>
                <td>${project.code}</td>
                <td>${project.name}</td>
                <td class="last"><g:link action="editProject" id="${project.id}">editar</g:link> | <a href="#">eliminar</a></td>
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