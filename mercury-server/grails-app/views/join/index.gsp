<%--
  User: cesarreyes
  Date: 14/12/11
  Time: 23:48
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <title>${message(code: 'application.name')}</title>
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css"/>
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}" type="text/css" media="screen"/>

   <script type="text/javascript" src="${resource(dir: 'js', file: 'global.js')}"></script>
</head>
<body>

<div class="topbar">
   <div class="topbar-inner">
      <div class="container">
         <h3>
            <g:link controller="home">${message(code: 'application.name')}</g:link>
         </h3>
      </div>
   </div>
</div>

<div class="container" style="margin-top: 100px;">

   <g:form action="sendRecoverPasswordRequest" name="loginForm" class="form">
      <div class="modal" style="position: relative; top: auto; left: auto; margin: 0 auto; z-index: 1">
         <div class="modal-header">
            <h3>Crear una cuenta</h3>
         </div>

         <div class="modal-body">
            <div class="form">
               <g:if test="${flash.message}">
                  <div class="alert-message warning">
                     <p>${flash.message}</p>
                  </div>
               </g:if>
               <div class="clearfix">
                  <label for="firstName">Nombre</label>
                  <div class="input">
                     <g:textField name="firstName" value="${invitation.firstName}"/>
                  </div>
               </div>
               <div class="clearfix">
                  <label for="lastName">Apellido</label>
                  <div class="input">
                     <g:textField name="lastName" value="${user.lastName}"/>
                  </div>
               </div>
               <div class="clearfix">
                  <label for="email">Email</label>
                  <div class="input">
                     <g:textField name="email" value="${user.email}"/>
                  </div>
               </div>
               <div class="clearfix">
                  <label for="password">Contrase&ntilde;a</label>
                  <div class="input">
                     <g:textField name="password" value="${user.password}"/>
                  </div>
               </div>
               <div class="clearfix">
                  <label for="confirmPassword">Confirmar contrase&ntilde;a</label>
                  <div class="input">
                     <g:textField name="confirmPassword" value="${user.confirmPassword}"/>
                  </div>
               </div>
            </div>
         </div>

         <div class="modal-footer">
            <button class="btn primary" type="submit">Enviar</button>
         </div>
      </div>
   </g:form>

</div>

<script type="text/javascript">
   document.getElementById("email").focus();
</script>

</body>
</html>