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

<%@ taglib uri="http://forzaframework.org/tags/misc-tags" prefix="n" %>
<%@ taglib uri="http://forzaframework.org/tags/form-tags" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>Mercury</title>
  <link rel="Shortcut Icon" href="${resource(dir: 'images', file: 'favicon.ico')}">
  <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'reset-min.css')}"/>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'base.css')}"/>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'styledButton.css')}"/>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.6.custom.css')}"/>

  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
  %{--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.6/jquery-ui.min.js"></script>--}%
  <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.8.6.custom.min.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.styledButton.js')}"></script>
  %{--<script type="text/javascript" src="/mercury-web/js/global.js${cmpVersion}"></script>--}%
  <g:layoutHead/>
</head>

<body>
<div id="container">
  <div id="top">
    <div id="userBox">
      <div class="userInfo">
        <div><sec:loggedInUserInfo field="username"/></div>
        <div>Trabajando en: nada
          | <g:link controller="profile">Perfil</g:link>
          | <g:link controller="project">Configuraci&oacute;n</g:link>
          | <a href="${ctx}/settings">Administracion</a>
          | <g:link controller="logout">Salir</g:link>
        </div>
      </div>
    </div>
    <div class="title">
      <h1><img src="${resource(dir: 'images', file: 'logo.png')}" width="24" height="24" alt="Mercury"/> Mercury <a href="#" style="color:#000;font-size:x-small" onclick="Ext.getCmp('change-project-window').show();
      Ext.getCmp('change-project-window').alignTo(Ext.get(this), 'br');">(cambiar proyecto)</a></h1>
    </div>
    <ul id="toolbar">
      <g:pageProperty name="page.navbar"/>
    </ul>
  </div>
  <div id="wrapper">
    <g:layoutBody/>
  </div>
  <div id="footer">
    <div id="dc"></div>
    <div style="float:left;"><a href="http://code.google.com/p/mercuryframework" target="_blank">Mercury</a> version 1.1.0</div>
    <div style="float:right;"><a href="http://nopalsoft.net/mercury/new" target="_blank">Enviar sugerencia</a></div>
  </div>
</div>

</body>

%{--<script type="text/javascript">--}%

%{--Ext.get('loading').fadeOut({remove: true});--}%

<%--function showMessage(message){--%>
<%--Ext.get('message').update('<img src="${ctx}/images/success.gif" />&nbsp;&nbsp;' + message);--%>
<%--Ext.get('message').setVisible(true);--%>
<%--setTimeout(function(){--%>
<%--Ext.get('message').setVisible(false, {duration: 2});--%>
<%--}, 2000);--%>
<%--}--%>


%{--var map = new Ext.KeyMap(document, [{--}%
%{--key: 'n', ctrl: true, shift:true, stopEvent: true, fn: function(e) { document.location.href = '${ctx}/new'; }--}%
%{--},{--}%
%{--key: 'b', ctrl: true, shift: true, stopEvent: true, fn: function(e) { Ext.get('query').focus(); }--}%
%{--},{--}%
%{--key: 'p', ctrl: true, shift: true, stopEvent: true, fn: function(e) { Ext.get('project').focus(); }--}%
%{--},{--}%
%{--key: '1', ctrl: true, stopEvent: true, fn: function(e) { document.location.href = '${ctx}/'; }--}%
%{--},{--}%
%{--key: '2', ctrl: true, stopEvent: true, fn: function(e) { document.location.href = '${ctx}/issues'; }--}%
%{--},{--}%
%{--key: '3', ctrl: true, stopEvent: true, fn: function(e) { document.location.href = '${ctx}/new'; }--}%
%{--},{--}%
%{--key: '4', ctrl: true, stopEvent: true, fn: function(e) { document.location.href = '${ctx}/project'; }--}%
%{--},{--}%
%{--key: '5', ctrl: true, stopEvent: true, fn: function(e) { document.location.href = '${ctx}/tools'; }--}%
%{--},{--}%
%{--key: '6', ctrl: true, stopEvent: true, fn: function(e) { document.location.href = '${ctx}/settings'; }--}%
%{--}]);--}%
%{--map.enable();--}%

%{--//});--}%
%{--</script>--}%

%{--<body>--}%
%{--<div id="header">--}%
%{--<div id="userBox">--}%
%{--<div class="userInfo">--}%
%{--<div><g:loggedInUserInfo field="fullName"/></div>--}%
%{--<div>Trabajando en: nada--}%
%{--| <g:link controller="profile">Perfil</g:link>--}%
%{--| <g:link controller="project">Configuraci&oacute;n</g:link>--}%
%{--| <a href="${ctx}/settings">Administracion</a>--}%
%{--| <g:link controller="logout">Salir</g:link>--}%
%{--</div>--}%
%{--</div>--}%
%{--</div>--}%
%{--<div class="title">--}%
%{--<h1><img src="/mercury-web/images/logo.png" width="24" height="24" alt="Mercury"/> Mercury <a href="#" style="color:#000;font-size:x-small" onclick="Ext.getCmp('change-project-window').show();--}%
%{--Ext.getCmp('change-project-window').alignTo(Ext.get(this), 'br');">(cambiar proyecto)</a></h1>--}%
%{--</div>--}%
%{--<ul id="toolbar">--}%
%{--<g:pageProperty name="page.navbar"/>--}%
%{--</ul>--}%
%{--</div>--}%
%{--<div id="main">--}%
%{--<g:layoutBody/>--}%
%{--</div>--}%
%{--<div id="footer" class="footer" style="background-color: #333;color:#fff;height:100%;padding:5px;font-size:x-small;">--}%
%{--<div id="dc"></div>--}%
%{--<div style="float:left;"><a href="http://code.google.com/p/mercuryframework" target="_blank">Mercury</a> version ${version}</div>--}%
%{--<div style="float:right;"><a href="http://nopalsoft.net/mercury/new" target="_blank">Enviar sugerencia</a> :: Powered by <a href="http://www.forzaframework.org" target="_blank">forzaframework</a></div>--}%
%{--</div>--}%

%{--<script type="text/javascript">--}%
%{--new Ext.Viewport({--}%
%{--layout:'border',--}%
%{--defaults: {--}%
%{--},--}%
%{--border: false,--}%
%{--items:   [--}%
%{--{--}%
%{--region: "north",--}%
%{--titleCollapse: true,--}%
%{--border: false,--}%
%{--height: 86,--}%
%{--contentEl:'header'--}%
%{--},--}%
%{--{--}%
%{--id: "center",--}%
%{--region: "center",--}%
%{--titleCollapse: true,--}%
%{--preventBodyReset:true,--}%
%{--border: false,--}%
%{--bodyStyle: "padding :5px;",--}%
%{--//        contentEl:'main'--}%
%{--"layout": "card",--}%
%{--"items": [      {--}%
%{--"xtype": "panel",--}%
%{--"titleCollapse": true,--}%
%{--"border": false,--}%
%{--"layout": "fit"--}%
%{--}],--}%
%{--"activeItem": 0--}%
%{--},--}%
%{--{--}%
%{--xtype: "panel",--}%
%{--region: "south",--}%
%{--titleCollapse: true,--}%
%{--border: false,--}%
%{--height: 25,--}%
%{--contentEl: "footer"--}%
%{--}--}%
%{--]--}%
%{--})--}%
%{--</script>--}%
%{--</body>--}%
</html>

