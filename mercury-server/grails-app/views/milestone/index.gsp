<%--
  Created by IntelliJ IDEA.
  User: Gabriel
  Date: 28/11/10
  Time: 11:54 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>Entregas</title>
    <meta name="layout" content="main"/>
  </head>
  <body>
    <content tag="navbar">
      <g:render template="/shared/menu" model="[selected:'release']"/>
    </content>
    <div id="main">
      <div class="block" id="block-text">
        <div class="content">
          <h2 class="title">Incidencias</h2>
          <div class="inner">
            <table class="table" cellpadding="0" cellspacing="0">
              %{--Mostrando <strong>${totalIssues}</strong> incidencias--}%
              <thead>
              <tr>
                <th class="first">P</th>
                <th>Codigo</th>
                <th>Resumen</th>
                <th>Reportador</th>
                <th class="last">A</th>
              </tr>
              </thead>
              <tbody>
              <g:each in="${issues}" var="issue" status="i">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                  <td><img src="${resource(dir: 'images/icons', file: issue.priority.icon)}" alt="${issue.priority.name}"></td>
                  <td style="white-space:nowrap;"><g:link action="view" id="${issue.code}">${issue.code}</g:link></td>
                  <td><g:link action="view" id="${issue.code}">${issue.summary}</g:link></td>
                  <td>${issue.reporter.fullName}</td>
                  <td><g:if test="${issue.attachments}">[A]</g:if></td>
                </tr>
              </g:each>
              </tbody>
            </table>
            %{--<div class="actions-bar wat-cf">--}%
              %{--<div class="pagination">--}%
                %{--<g:paginate next="Siguiente" prev="Atras" maxsteps="4" max="20" total="${totalIssues}" params="${[filter: currentFilter.id]}"/>--}%
              %{--</div>--}%
            %{--</div>--}%

          </div>
        </div>
      </div>
    </div>
    <div id="sidebar">
      <div class="block">
        <h3>Entregas</h3>
        <ul class="navigation">
          <g:each in="${milestones}" var="milestone">
            <li>
              <g:link action="index" params="${[id:milestone.id]}">${milestone.name}</g:link>
            </li>
          </g:each>
        </ul>
      </div>
    </div>

  </body>
</html>