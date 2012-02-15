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
   <meta charset="utf-8">
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   <title><g:layoutTitle default="${message(code: 'application.name')}"/> :: ${message(code: 'application.name')}</title>

   <link rel="Shortcut Icon" href="${resource(dir: 'images', file: 'favicon.ico')}">

   <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css"/>
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.responsive.css')}" type="text/css"/>
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}" type="text/css" media="screen"/>
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.6.custom.css')}"/>
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.countdown.css')}"/>

   <script type="text/javascript" src="${resource(dir:'js', file: 'jquery-1.7.1.min.js')}"></script>
   <script type="text/javascript" src="${resource(dir:'js', file: 'jquery-ui-1.8.17.custom.min.js')}"></script>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'application.js')}"></script>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'bootstrap.js')}"></script>

   %{--<script type="text/javascript" src="${resource(dir: 'js', file: 'jquery-ui-1.8.6.custom.min.js')}"></script>--}%
   %{--<script type="text/javascript" src="/mercury-web/js/global.js${cmpVersion}"></script>--}%
   <g:layoutHead/>
</head>

<body>

<div class="navbar navbar-fixed-top">
   <div class="navbar-inner">
      <div class="container">
         <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
         </a>
         <g:link controller="home" class="brand">
            <g:if test="${session.currentWorkspace}">
               ${session.currentWorkspace.name}
            </g:if>
            <g:else>
               ${message(code: 'application.name')}
            </g:else>
         </g:link>
         <ul class="nav">
            <g:pageProperty name="page.navbar"/>
         </ul>
         <g:form controller="issues" action="index" method="get" class="navbar-search pull-left">
            <g:textField name="search" placeholder="Buscar" class="search-query" />
         </g:form>
         <ul class="nav pull-right">
            <li><g:link controller="issues" action="create" elementId="newIssueLink">[+]</g:link></li>
            <li class="dropdown">
               <a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="${resource(dir: 'images', file: 'cog.png')}"/><b class="caret"></b></a>
               <ul class="dropdown-menu">
                  <li><a id="newWorkspaceLink" href="#"><g:message code="workspace.new"/></a></li>
                  <li>
                     <g:link controller="home" action="chooseWorkspace"
                             params="[changeWorkspace: 'true']"><g:message code="workspace.change"/></g:link>
                  </li>
                  <g:if test="${session.currentWorkspace}">
                     <li><g:link controller="workspace">Configuraci&oacute;n del workspace</g:link></li>
                  </g:if>

                  <li class="divider"></li>
                  <g:if test="${session.currentWorkspace}">
                     <li><a id="newProjectLink" href="#">Nuevo proyecto</a></li>
                  </g:if>
                  <g:if test="${request.project}">
                     <li><g:link controller="project">Configuraci&oacute;n de proyecto</g:link></li>
                  </g:if>
                  <sec:ifAllGranted roles="role_admin">
                     <li><g:link controller="admin">Administraci&oacute;n</g:link></li>
                  </sec:ifAllGranted>
               </ul>
            </li>
            <li class="dropdown">
               <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="padding-top: 5px;padding-bottom: 0;">
                  <sec:ifLoggedIn>
                     <img src="http://www.gravatar.com/avatar/${session.user.email.encodeAsMD5()}?s=30"/>
                     <span>${session.user}</span>
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
      <ul class="nav nav-pills">
         <li class=""><a href="#">Todos</a></li>
         <g:each in="${request.workspaceProjects}" var="p">
            <li class="${(request.project != null && request.project == p) ? 'active' : ''}">
               <g:link controller="home" action="changeProject" params="[projectId: p.id]">${p.name}</g:link></li>
         </g:each>
      </ul>
   </g:if>
   <g:elseif test="${session.currentWorkspace}">
      <div class="alert">
         No hay proyectos en este Workspace. <a id="newProjectLink2" href="#">Agregar un proyecto</a>
      </div>
   </g:elseif>
   <g:layoutBody/>
</div>

<div class="container">
   <div class="footer" style="margin-top: 30px;">
      <hr/>

      <p>
         <a href="https://github.com/cesarreyesa/mercury"
            target="_blank">${message(code: 'application.name')}</a> version 1.1.0
      </p>
      %{--<div style="float:right;"><a href="http://nopalsoft.net/mercury/new" target="_blank">Enviar sugerencia</a></div>--}%
      %{--<p>Copyright &copy; 2010 Your Site.</p>--}%
   </div>
</div>

<div id="newIssueDialog" title="Nueva Incidencia" style="display:none;width: 800px;" class="modal">

</div>

<div id="newWorkspaceDialog" style="display:none;width: 400px;" class="modal">
   <g:form class="form-stacked-w" action="newWorkspace" controller="home">
      <div class="modal-header">
         <a href="#" class="close">×</a>

         <h3>${message(code: 'workspace.new')}</h3>
      </div>

      <div class="modal-body">
         <div class="clearfix">
            <label for="name">Nombre</label>

            <div class="input">
               <g:textField name="name"/>
            </div>
         </div>
      </div>

      <div class="modal-footer">
         <g:submitButton name="newWorkspace" value="Guardar" class="btn btn-primary" id="newWorkspace"/>
         <a href="#" class="btn" id="newWorkspaceCancel">Cancelar</a>
      </div>
   </g:form>
</div>

<div id="newProjectDialog" style="display:none;width: 400px;" class="modal hide">
   <g:form class="form-stacked-w" action="newProject" controller="home">
      <div class="modal-header">
         <a href="#" class="close">×</a>

         <h3>Nuevo proyecto</h3>
      </div>

      <div class="modal-body">
         <div class="clearfix">
            <label for="projectName">Nombre</label>

            <div class="input">
               <g:textField name="projectName"/>
            </div>
         </div>
      </div>

      <div class="modal-footer">
         <g:submitButton name="newProject" value="Guardar" class="btn btn-primary" id="newProject"/>
         <a href="#" class="btn" id="newProjectCancel">Cancelar</a>
      </div>
   </g:form>
</div>

<div id="changeWorkspaceDialog" style="display:none;width: 400px;" class="modal">
   <div class="modal-header">
      <a href="#" class="close">×</a>

      <h3>${message(code: 'workspace.change')}</h3>
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
      <g:submitButton name="changeWorkspace" value="Guardar" class="btn btn-primary" id="changeWorkspace"/>
      <a href="#" class="btn" id="newIssueCancel">Cancelar</a>
   </div>
</div>

<script type="text/javascript">
   $(function () {
//      $("#newWorkspaceDialog").modal({ keyboard:true });
      $('#newWorkspaceLink').click(function (e) {
         e.preventDefault();
         $("#newWorkspaceDialog").modal('show');
      });

//      $("#newProjectDialog").modal({ keyboard:true });
      $('#newProjectLink').click(function (e) {
         e.preventDefault();
         $("#newProjectDialog").modal('show');
      });
      $('#newProjectLink2').click(function (e) {
         e.preventDefault();
         $("#newProjectDialog").modal('show');
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


