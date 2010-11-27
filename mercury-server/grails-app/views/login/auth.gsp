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
  <title>Mercury</title>
  <link rel="stylesheet" href="${resource(dir:'css', file:'base.css')}" type="text/css" media="screen" />
  <link rel="stylesheet" href="${resource(dir:'css/themes/drastic-dark', file:'styles.css')}" type="text/css" media="screen" />

  <script type="text/javascript" src="${resource(dir: 'js', file: 'global.js')}"></script>
</head>
<body>

<div id="box">
  <h1>Mercury</h1>
  <p>Bug tracking, issue tracking and project management software.</p>
  <div class="block" id="block-login">
    <h2>Ingresar a Mercury</h2>
    <div class="content login">
      <g:if test="${flash.message}">
        <div class="flash">
          <div class="message error">
            Nombre de usuario o contrase&ntilde;a no v&aacute;lido, por favor, int&eacute;ntelo de nuevo.
          </div>
        </div>
      </g:if>
      <form method="post" id="loginForm" action="${postUrl}" onsubmit="saveUsername(this);" class="form login">
        <div class="group wat-cf">
          <div class="left">
            <label class="label right">Usuario</label>
          </div>
          <div class="right">
            <input type="text" class="text_field" name="j_username" id="j_username" tabindex="1"/>
          </div>
        </div>
        <div class="group wat-cf">
          <div class="left">
            <label class="label right">Contrase&ntilde;a</label>
          </div>
          <div class="right">
            <input type="password" class="text_field" name="j_password" id="j_password" tabindex="2"/>
            <span><g:link controller="login" action="forgotPassword">&iquest;Olvid&oacute; su contrase&ntilde;a?</g:link></span>
          </div>
        </div>
        <div class="group wat-cf">
          <div class="right">
            <input type="checkbox" class="checkbox" name="_spring_security_remember_me" value="true" checked="checked" id="_spring_security_remember_me" tabindex="3"/>
            <label for="_spring_security_remember_me" class="choice">Recordarme</label>
          </div>
        </div>
        <div class="group navform wat-cf">
          <div class="right">
            <button class="button" type="submit">
              <img src="${resource(dir:'/images/icons', file:'key.png')}" alt="Entrar" /> Entrar
            </button>
          </div>
        </div>
        %{--<p>--}%
        %{--&iquest;No es miembro? <a href="#">Crear</a> una cuenta.--}%
        %{--</p>--}%
        %{--<p>--}%
  %{--<div id="footer" class="clearfix">--}%

    %{--<div id="divider">--}%
      %{--<div></div>--}%
    %{--</div>--}%
    %{--<span class="left">Version ${version}</span>--}%
    %{--<span class="right">--}%
    %{--&copy; <a href="http://nopalsoft.net">Nopalsoft</a>--}%
    %{--</span>--}%
  %{--</div>--}%

      </form>
    </div>
  </div>
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