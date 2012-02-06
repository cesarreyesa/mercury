<%--
  User: cesarreyes
  Date: 25/11/10
  Time: 21:06
--%>
<%--
  ~ Copyright 2006-2009 the original author or authors.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~       http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  --%>
<!DOCTYPE html>
<html lang="en">
<head>
   <title>${message(code: 'application.name')}</title>
   <meta name="layout" content="public">
</head>

<body>

<g:form action="resetPassword" name="loginForm">

   <div class="modal" style="position: relative; top: auto; left: auto; margin: 0 auto; z-index: 1">
      <div class="modal-header">
         <h3>Cambie su contrase&ntilde;a</h3>
      </div>
      <div class="modal-body">
         <g:hiddenField name="userId" value="${user.id}"/>
         <div class="control-group">
            <label for="password">Contrase&ntilde;a</label>
            <div class="controls">
               <g:passwordField name="password"/>
            </div>
         </div>
         <div class="control-group">
            <label for="confirmPassword">Confirmar contrase&ntilde;a</label>
            <div class="controls">
               <g:passwordField name="confirmPassword"/>
            </div>
         </div>
      </div>
      <div class="modal-footer">
         <button class="btn btn-primary" type="submit">
            Enviar
         </button>
      </div>
   </div>
</g:form>

<script type="text/javascript">
   document.getElementById("password").focus();
</script>

</body>
</html>