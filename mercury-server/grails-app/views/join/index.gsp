<%--
  User: cesarreyes
  Date: 14/12/11
  Time: 23:48
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta content="public" name="layout">
   <title>${message(code: 'application.name')}</title>
</head>
<body>

<g:form action="join" name="joinForm" class="form">
   <div class="modal" style="position: relative; top: auto; left: auto; margin: 0 auto; z-index: 1">
      <div class="modal-header">
         <h3>Crear una cuenta</h3>
      </div>

      <div class="modal-body">
         <div class="form">
            <g:hiddenField name="workspaceId" value="${invitation.workspace.id}"/>
            <g:hiddenField name="invitationId" value="${invitation.id}"/>
            <g:hasErrors bean="${user}">
               <div class="alert-message block-message error">
                  <p>Hubo un error al crear la cuenta, revisa los siguientes mensajes:</p>
                  <ul>
                     <g:eachError bean="${user}">
                        <li><g:message error="${it}"/></li>
                     </g:eachError>
                  </ul>
               </div>
            </g:hasErrors>

            <g:if test="${flash.message}">
               <div class="alert-message warning">
                  <p>${flash.message}</p>
               </div>
            </g:if>
            <div class="clearfix">
               <label for="firstName">Nombre</label>
               <div class="input">
                  <g:textField name="firstName" value="${user.firstName}"/>
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
                  <g:passwordField name="password" value="${user.password}"/>
               </div>
            </div>
            <div class="clearfix">
               <label for="confirmPassword">Confirmar contrase&ntilde;a</label>
               <div class="input">
                  <g:passwordField name="confirmPassword" value=""/>
               </div>
            </div>
         </div>
      </div>

      <div class="modal-footer">
         <button class="btn primary" type="submit">Enviar</button>
      </div>
   </div>
</g:form>

<script type="text/javascript">
   document.getElementById("firstName").focus();
</script>

</body>
</html>