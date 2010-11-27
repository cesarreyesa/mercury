<%--
  User: cesarreyesa
  Date: 25-feb-2010
  Time: 23:01:38
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Perfil</title>
  <meta name="layout" content="main"/>
</head>
<body>

<content tag="navbar">
  <g:render template="/shared/profileMenu"/>
</content>

<div id="main">
  <div class="block" id="block-text">
    <div class="content">
      <h2 class="title">Update your profile</h2>
      <div class="inner">
        <g:form action="save" class="form">
          <g:hiddenField name="id" value="${user.id}"/>
          <div class="group">
            <label for="username" class="label">Usuario:</label>
            <g:textField name="username" value="${user.username}"/>
          </div>
          <div class="group">
            <label for="firstName" class="label">Nombre</label>
            <g:textField name="firstName" value="${user.firstName}"/>
          </div>
          <div class="group">
            <label for="lastName" class="label">Apellido</label>
            <g:textField name="lastName" value="${user.lastName}"/>
          </div>
          <div class="group">
            <label for="email" class="label">Email</label>
            <g:textField name="email" value="${user.email}"/>
          </div>
          <div class="group navform wat-cf">
            <button class="button" type="submit">
              <img src="${resource(dir:'images/icons', file:'tick.png')}" alt="Guardar" /> Guardar
            </button>
          </div>
        </g:form>
      </div>
      <div style="margin-top:20px;"></div>

      <h2 class="title">Cambie su contrase&ntilde;a</h2>
      <div class="inner">
        <g:form action="changePassword" class="form">
          <g:hiddenField name="id" value="${user.id}"/>

          <div class="group">
            <label class="label">Ingrese su nueva contrase&ntilde;a y confirmela</label>
            <g:passwordField name="password"/>
            <g:passwordField name="confirmPassword"/>
          </div>
          <div class="group navform wat-cf">
            <button class="button" type="submit">
              <img src="${resource(dir:'images/icons', file:'tick.png')}" alt="Cambiar contraseña" /> Cambiar contraseña
            </button>
          </div>
        </g:form>
      </div>
    </div>
  </div>
</div>

</body>
</html>