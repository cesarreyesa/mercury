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
    <h2>Recuperar contrase&ntilde;a</h2>
    <div class="content login">
      <g:if test="${flash.message}">
        <div class="flash">
          <div class="message error">
            ${flash.message}
          </div>
        </div>
      </g:if>
      <g:form action="sendRecoverPasswordRequest" name="loginForm" class="form">
        <div class="group">
          <label class="label">Email</label>
          <g:textField name="email" value="${email}"/>
        </div>
        <div class="group navform wat-cf">
          <button class="button" type="submit">
            <img src="${resource(dir:'/images/icons', file:'key.png')}" alt="Enviar" /> Enviar
          </button>
        </div>
      </g:form>
    </div>
  </div>
</div>

<script type="text/javascript">
  document.getElementById("email").focus();
</script>

</body>
</html>