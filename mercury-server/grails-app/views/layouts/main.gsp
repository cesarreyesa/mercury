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
   <title><g:layoutTitle default="${message(code:'application.name')}"/> :: ${message(code:'application.name')}</title>

   <link rel="Shortcut Icon" href="${resource(dir: 'images', file: 'favicon.ico')}">

   <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css"/>
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}" type="text/css" media="screen"/>
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.6.custom.css')}"/>
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.countdown.css')}"/>

   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.6/jquery-ui.min.js"></script>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'application.js')}"></script>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap-modal.js')}"></script>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap-dropdown.js')}"></script>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap-popover.js')}"></script>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap-buttons.js')}"></script>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.countdown.js')}"></script>

   %{--<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.8.6.custom.min.js')}"></script>--}%
   %{--<script type="text/javascript" src="/mercury-web/js/global.js${cmpVersion}"></script>--}%
   <g:layoutHead/>
</head>

<body>
<div class="topbar" data-dropdown="dropdown">
   <div class="topbar-inner">
      <div class="container">
         <h3>
            <g:link controller="home">
               <g:if test="${session.workspace}">
                  ${session.workspace.name}
               </g:if>
               <g:else>
                  ${message(code:'application.name')}
               </g:else>
            </g:link>
         </h3>
         <ul class="nav">
            <g:pageProperty name="page.navbar"/>
         </ul>
         <g:form controller="issues" action="index" method="get">
            <g:textField name="search" placeholder="Buscar" style="width:150px;"/>
         </g:form>
         <ul class="nav secondary-nav">
            <li><g:link controller="issues" action="create" elementId="newIssueLink">[+]</g:link></li>
            %{--<li style="color: #ffffff;">Trabajando en:--}%
            %{--<g:set var="workingOn" value="${session.user.workingOn()}"/>--}%
            %{--<g:if test="${workingOn}">--}%
            %{--<g:link controller="issues" action="view" id="${workingOn.code}">${workingOn.code}</g:link>--}%
            %{--</g:if>--}%
            %{--<g:else>--}%
            %{--nada--}%
            %{--</g:else>--}%
            %{--</li>--}%
            <li class="dropdown">
               <a href="#" class="dropdown-toggle"><img src="${resource(dir: 'images', file: 'cog.png')}"/></a>
               <ul class="dropdown-menu">
                  <li><a id="newWorkspaceLink" href="#"><g:message code="workspace.new"/></a></li>
                  <li>
                     <g:link controller="home" action="chooseWorkspace"
                        params="[changeWorkspace:'true']"><g:message code="workspace.change"/></g:link>
                  </li>
                  <li><g:link controller="workspace">Configuraci&oacute;n del workspace</g:link></li>
                  <li class="divider"></li>
                  <li><g:link controller="project">Configuraci&oacute;n de proyecto</g:link></li>
                  <li><g:link controller="admin">Administraci&oacute;n</g:link></li>
               </ul>
            </li>
            <li class="dropdown">
               <a href="#" class="dropdown-toggle" style="padding-top: 5px;padding-bottom: 0;">
                  <sec:ifLoggedIn>
                     <img src="http://www.gravatar.com/avatar/${session.user.email.encodeAsMD5()}?s=30" />
                     <span >${session.user}</span>
                  </sec:ifLoggedIn>
               </a>
               <ul class="dropdown-menu">
                  <li><g:link controller="profile">Perfil</g:link></li>
                  <li><g:link controller="logout" class="logout">salir</g:link></li>
               </ul>
            </li>
         </ul>
      </div>
   </div>
</div>

<div class="container" style="margin-top: 50px;">
   <g:if test="${request.workspaceProjects}">
      <ul class="pills">
         <li class=""><a href="#">Todos</a></li>
         <g:each in="${request.workspaceProjects}" var="p">
            <li class="${(request.project != null && request.project == p) ? 'active' : ''}">
               <g:link controller="home" action="changeProject" params="[projectId: p.id]">${p.name}</g:link></li>
         </g:each>
      </ul>
   </g:if>
   <g:layoutBody/>
</div>

<div class="container">
   <div class="footer" style="margin-top: 30px;">
      <hr/>
      <p>
         <a href="https://github.com/cesarreyesa/mercury"
            target="_blank">${message(code:'application.name')}</a> version 1.1.0
      </p>
      %{--<div style="float:right;"><a href="http://nopalsoft.net/mercury/new" target="_blank">Enviar sugerencia</a></div>--}%
      %{--<p>Copyright &copy; 2010 Your Site.</p>--}%
   </div>
</div>

<div id="newIssueDialog" title="Nueva Incidencia" style="display:none;width: 800px;" class="modal">

</div>

<div id="newWorkspaceDialog" style="display:none;width: 400px;" class="modal">
   <g:form class="form-stacked" action="newWorkspace" controller="home">
      <div class="modal-header">
         <a href="#" class="close">×</a>
         <h3>${message(code:'workspace.new')}</h3>
      </div>

      <div class="modal-body">
            <div class="clearfix">
               <label>Nombre</label>
               <div class="input">
                  <g:textField name="name" />
               </div>
            </div>
      </div>
      <div class="modal-footer">
         <g:submitButton name="newWorkspace" value="Guardar" class="btn primary" id="newWorkspace"/>
         <a href="#" class="btn" id="newWorkspaceCancel">Cancelar</a>
      </div>
   </g:form>
</div>

<div id="changeWorkspaceDialog" style="display:none;width: 400px;" class="modal">
   <div class="modal-header">
      <a href="#" class="close">×</a>
      <h3>${message(code:'workspace.change')}</h3>
   </div>

   <div class="modal-body">
      <g:form class="form-stacked">
         <div class="clearfix">
            <label>Workspace</label>
            <div class="input">

            </div>
         </div>
      </g:form>
   </div>
   <div class="modal-footer">
      <g:submitButton name="changeWorkspace" value="Guardar" class="btn primary" id="changeWorkspace"/>
      <a href="#" class="btn" id="newIssueCancel">Cancelar</a>
   </div>
</div>

<script type="text/javascript">
   $(function() {
      $("#newWorkspaceDialog").modal({ keyboard: true });
      $('#newWorkspaceLink').click(function(e) {
         e.preventDefault();
         $("#newWorkspaceDialog").modal('show');
      });
   });
</script>
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


