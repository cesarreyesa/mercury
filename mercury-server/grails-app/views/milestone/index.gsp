<%--
  Created by IntelliJ IDEA.
  User: Gabriel
  Date: 28/11/10
  Time: 11:54 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="org.nopalsoft.mercury.domain.Milestone" contentType="text/html;charset=UTF-8" %>
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
          <h2 class="title">${milestone?.name ? 'Entrega: ' + milestone.name + ' ( ' + milestone.startDate.format("dd/MM/yyyy") + ' - ' + milestone.endDate.format("dd/MM/yyyy") + ' )' : 'Incidencias sin asignar'}</h2>
          <div class="inner">
            <g:form action="addIssuesToMilestone">
              <table class="table" cellpadding="0" cellspacing="0">
                <tr>
                  <td colspan="6">
                    Agregar a: <g:select name="milestone" from="${milestones}" optionKey="id" optionValue="name" noSelection="${['':'Seleccione']}"/>
                    <g:submitButton name="submit" value="Agregar"/>
                  </td>
                </tr>
                <tr>
                  <th class="first">
                    <g:checkBox name="selectAll" onclick="jQuery('[name=issue]').attr('checked', this.checked)"/>
                  </th>
                  <th>P</th>
                  <th>Codigo</th>
                  <th>Resumen</th>
                  <th>Reportador</th>
                  <th class="last">A</th>
                </tr>
                <tbody>
                <g:each in="${issues}" var="issue" status="i">
                  <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td><g:checkBox name="issue" value="${issue.id}" checked="false"/></td>
                    <td><img src="${resource(dir: 'images/icons', file: issue.priority.icon)}" alt="${issue.priority.name}"></td>
                    <td style="white-space:nowrap;"><g:link action="view" id="${issue.code}">${issue.code}</g:link></td>
                    <td><g:link action="view" id="${issue.code}">${issue.summary}</g:link></td>
                    <td>${issue.reporter.fullName}</td>
                    <td><g:if test="${issue.attachments}">[A]</g:if></td>
                  </tr>
                </g:each>
                </tbody>
              </table>
            </g:form>
          </div>
        </div>
      </div>
    </div>
  <div id="sidebar">
    <div class="block">
        <h3>Entregas</h3>
        <ul class="navigation">
          <li class="${!milestone ? 'active' : ''}">
            <g:link action="index">Sin asignar</g:link>
          </li>
          <g:each in="${milestones}" var="milestoneItem">
            <li class="${milestone && milestone.id == milestoneItem.id ? 'active' : ''}">
              <g:link action="index" params="${[id:milestoneItem.id]}">${milestoneItem.name}</g:link>
            </li>
          </g:each>
        </ul>
      </div>
    </div>

  </body>
</html>