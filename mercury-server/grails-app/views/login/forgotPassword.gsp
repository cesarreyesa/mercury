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

<g:form action="sendRecoverPasswordRequest" name="loginForm" class="form">
   <div class="modal" style="position: relative; top: auto; left: auto; margin: 0 auto; z-index: 1">
      <div class="modal-header">
         <h3>Recuperar contrase&ntilde;a</h3>
      </div>

      <div class="modal-body">
         <div class="form">
            <g:if test="${flash.message}">
               <div class="alert">
                  <p>${flash.message}</p>
               </div>
            </g:if>
            <div class="clearfix">
               <label for="email">Email</label>

               <div class="input">
                  <g:textField name="email" value="${email}"/>
               </div>
            </div>

         </div>
      </div>

      <div class="modal-footer">
         <button class="btn btn-primary" type="submit">Enviar</button>
      </div>
   </div>
</g:form>

<script type="text/javascript">
  document.getElementById("email").focus();
</script>

</body>
</html>