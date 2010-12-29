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
    <style type="text/css">
      .custom-bar {
          -moz-border-radius-topleft: 4px;
          -moz-border-radius-topright: 4px;
          background: none repeat scroll 0 0 #36393D;
          border-bottom: 5px solid #1A1A1A;
          color: #FFFFFF;
          font-size: 13px;
          margin: 0;
          padding: 10px 15px;
          font-family: helvetica,arial,sans-serif;
      }

    </style>
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
              <g:hiddenField name="id" value="${milestone?.id ?: ''}"/>
              <table class="table" cellpadding="0" cellspacing="0">
                <tr>
                  <td colspan="5">
                    Agregar a: <g:select name="milestone" from="${milestones}" optionKey="id" optionValue="name" noSelection="${['':'Seleccione']}"/>
                    <g:submitButton name="submit" value="Agregar"/>
                  </td>
                  <td style="text-align:right;">
                    Mostrando <strong>${issues.size()}</strong> incidencias <a href="#">abiertas</a>
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
                    <td><g:link controller="issues" action="view" id="${issue.code}">${issue.summary}</g:link></td>
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
      <div class="custom-bar">
        <div style="display:inline;">
          <span>Entregas</span>
          <span style="float:right;"><a id="newMilestone" href="#" class="ui-icon ui-icon-circle-plus">Nuevo</a></span>
        </div>
      </div>
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

  <div id="newMilestoneDialog" title="Nueva lista de entregas" style="display:none;">
    <div class="form">
      <g:form action="create" name="newMilestoneForm">
        <div class="row">
          <div class="box">
            <div class="label">
              <label>Nombre:</label>
            </div>
            <div class="field">
              <g:hiddenField name="actualMilestone" value="${milestone?.id ?: ''}"/>
              <g:textField name="name" style="width:400px;"/>
            </div>
          </div>
        </div>
        <div class="row" style="clear:both;">
          <div class="label">
            <label>Fecha de Inicio:</label>
          </div>
          <div class="field">
            <g:textField name="startDate" value="${formatDate(date:new Date(), format:'dd/MM/yyyy')}" />
          </div>
        </div>
        <div class="row" style="clear:both;">
          <div class="label">
            <label>Fecha de Final:</label>
          </div>
          <div class="field">
            <g:textField name="endDate" value="${formatDate(date:new Date(), format:'dd/MM/yyyy')}" />
          </div>
        </div>
      </g:form>
    </div>
  </div>


  <script type="text/javascript">
    $(function() {
      $("#startDate").datepicker({dateFormat: 'dd/mm/yy'});
      $("#endDate").datepicker({dateFormat: 'dd/mm/yy'});

      $("#newMilestone").click(function(){
        $('#name').focus();
        var position = $(this).position();
        $("#newMilestoneDialog").dialog({
          width:550, modal: true, position: [position.left, position.top + $(this).height()],
          buttons: {
            "Guardar": function(){
              $('#newMilestoneForm').submit();
            }
          }
        });
      });
    });

</script>
  </body>
</html>

