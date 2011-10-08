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

   <form method="post" id="loginForm" action="${postUrl}" onsubmit="saveUsername(this);" class="form login">
      <div class="modal" style="position: relative; top: auto; left: auto; margin: 0 auto; z-index: 1">
         <div class="modal-header">
            <h3>Ingresar a ${message(code: 'application.name')}</h3>

            <p>Bug tracking, issue tracking and project management software.</p>
         </div>

         <div class="modal-body">
            <div class="form">
               <g:if test="${flash.message}">
                  <div class="alert-message warning">
                     <p>Nombre de usuario o contrase&ntilde;a no v&aacute;lido, por favor, int&eacute;ntelo de nuevo.</p>
                  </div>

                  <div class="flash">
                     <div class="message error">

                     </div>
                  </div>
               </g:if>
               <div class="clearfix">
                  <label for="j_username">Usuario</label>

                  <div class="input">
                     <input type="text" name="j_username" id="j_username" tabindex="1"/>
                  </div>
               </div>

               <div class="clearfix">
                  <label for="j_password">Contrase&ntilde;a</label>

                  <div class="input">
                     <input type="password" name="j_password" id="j_password" tabindex="2"/>
                  </div>
               </div>

               <div class="clearfix">
                  <div class="input">
                     <label for="_spring_security_remember_me">
                        <input type="checkbox" name="_spring_security_remember_me" value="true" checked="checked"
                               id="_spring_security_remember_me" tabindex="3"/>
                        <span>Recordarme</span>
                     </label>
                  </div>
               </div>

            </div>
         </div>

         <div class="modal-footer">
            <button class="btn primary" type="submit">Entrar</button>
            <g:link controller="login" action="forgotPassword">&iquest;Olvid&oacute; su contrase&ntilde;a?</g:link>
         </div>
      </div>
   </form>

</div>

<script type="text/javascript">
   if (getCookie("username") != null) {
      document.getElementById("j_username").value = getCookie("username");
      document.getElementById("j_password").focus();
   } else {
      document.getElementById("j_username").focus();
   }

   function saveUsername(theForm) {
      var expires = new Date();
      expires.setTime(expires.getTime() + 24 * 30 * 60 * 60 * 1000); // sets it for approx 30 days.
      setCookie("username", document.getElementById('j_username').value, expires, "${ctx}");
   }
</script>

</body>
</html>