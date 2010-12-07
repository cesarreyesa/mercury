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

<div id="main">
  <div class="block" id="block-text">

    <div class="secondary-navigation">
      <ul class="wat-cf">
        <li class="first"><g:link action="index">Usuarios</g:link></li>
        <li class="active"><g:link action="projects">Proyectos</g:link></li>
        <li><a href="#block-forms-2">Catalogos</a></li>
        <li><a href="#block-messages">Herramientas</a></li>
      </ul>
    </div>

    <div class="content">
      <h2 class="title">Editar proyecto</h2>
      <div class="inner">
      </div>
    </div>
  </div>
</div>

</body>
</html>