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
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   <title><g:layoutTitle default="Mercury"/> :: Mercury</title>

   <link rel="Shortcut Icon" href="${resource(dir: 'images', file: 'favicon.ico')}">

   <link rel="stylesheet" href="${resource(dir: 'css', file: 'base.css')}" type="text/css" media="screen"/>
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}" type="text/css" media="screen"/>
   %{--<link rel="stylesheet" href="${resource(dir:'css/themes/default', file:'styles.css')}" type="text/css" media="screen" />--}%
   <link rel="stylesheet" href="${resource(dir: 'css/themes/drastic-dark', file: 'styles.css')}" type="text/css"
         media="screen"/>
   %{--<link rel="stylesheet" href="${resource(dir:'css/themes/bec-green', file:'styles.css')}" type="text/css" media="screen" />--}%
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.6.custom.css')}"/>
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'styledButton.css')}"/>

   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.6/jquery-ui.min.js"></script>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.styledButton.js')}"></script>
   %{--<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.8.6.custom.min.js')}"></script>--}%
   %{--<script type="text/javascript" src="/mercury-web/js/global.js${cmpVersion}"></script>--}%
   <g:layoutHead/>
</head>

<body>
<div id="container">
   <div id="header">
      <h1 style="color:#fff;">Mercury <g:link style="color:#ccc;font-size:x-small" controller="home"
                                              action="chooseProject"
                                              params="[changeProject:'true']">(cambiar proyecto)</g:link></h1>

      <div id="user-navigation">
         <ul class="wat-cf">
            <li><g:link controller="issues" action="create">[+]</g:link></li>
            <li style="color: #ffffff;">Trabajando en:
               <g:set var="workingOn" value="${session.user.workingOn()}"/>
               <g:if test="${workingOn}">
                  <g:link controller="issues" action="view" id="${workingOn.code}">${workingOn.code}</g:link>
               </g:if>
               <g:else>
                  nada
               </g:else>
            </li>
            <li><g:link controller="profile"><sec:ifLoggedIn>${session.user}</sec:ifLoggedIn> (ver perfil)</g:link></li>
            <li><g:link controller="project">Configuraci&oacute;n</g:link></li>
            <li><g:link controller="admin"><img src="${resource(dir:'images', file:'cog.png')}" /> </g:link></li>
            <li><g:link controller="logout" class="logout">salir</g:link></li>
         </ul>
      </div>

      <div id="search-box">
         <g:form controller="issues" action="index" method="get">
            <g:textField name="search" class="text_field" style="width:150px;"/>
            <g:submitButton name="submit" value="Buscar"/>
         </g:form>
      </div>

      <div id="main-navigation">

         <ul class="wat-cf">
            <g:pageProperty name="page.navbar"/>
         </ul>
      </div>

   </div>

   <div id="wrapper" class="wat-cf">
      <g:layoutBody/>
      <div id="footer" style="clear:both;">
         <div class="block">
            <p>
               <a style="color:#fff;" href="https://github.com/cesarreyesa/mercury"
                  target="_blank">Mercury</a> version 1.1.0
            </p>
            %{--<div style="float:right;"><a href="http://nopalsoft.net/mercury/new" target="_blank">Enviar sugerencia</a></div>--}%
            %{--<p>Copyright &copy; 2010 Your Site.</p>--}%
         </div>
      </div>
   </div>

</div>
</body>
</html>


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


