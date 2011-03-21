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
      font-family: helvetica, arial, sans-serif;
   }
   .custom-bar a{
      color:#fff;
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
         <g:if test="${flash.message}">
            <div class="flash">
               <div class="message error">
                  ${flash.message}
               </div>
            </div>
         </g:if>
         <g:if test="${flash.success}">
            <div class="flash">
               <div class="message notice">
                  ${flash.success}
               </div>
            </div>
         </g:if>
         <h2 class="title">${milestone?.name ? 'Entrega: ' + milestone.name + ' ( ' + milestone.startDate.format("dd/MM/yyyy") + ' - ' + milestone.endDate.format("dd/MM/yyyy") + ' )' : 'Incidencias sin asignar'}</h2>
         <div class="inner">
            <g:form action="addIssuesToMilestone">
               <g:hiddenField name="id" value="${milestone?.id ?: ''}"/>
               <div style="padding-bottom:10px;">
                  Agregar a: <g:select name="milestone" from="${milestones}" optionKey="id" optionValue="name" noSelection="${['':'Seleccione']}"/>
                  <g:submitButton name="submit" value="Agregar"/>
                  <span style="float:right;">Mostrando <strong>${issues.size()}</strong> incidencias <a href="#">abiertas</a></span>
                  <span id="close" style="float:right; margin-right:5px;">Cerrar Entrega</span>
               </div>
               <g:render template="/shared/issuesTable" model="[issues:issues, includeCheckbox:true, enableIssueSort: false/*milestone != null*/]"/>
            </g:form>
            <g:form name="moveUpForm" controller="milestone" action="moveUp">
               <g:hiddenField name="milestone" value="${milestone?.id}"/>
               <g:hiddenField name="issue"/>
            </g:form>
            <g:form name="moveDownForm" controller="milestone" action="moveDown">
               <g:hiddenField name="milestone" value="${milestone?.id}"/>
               <g:hiddenField name="issue"/>
            </g:form>
         </div>
      </div>
   </div>
</div>
<div id="sidebar">
   <div class="block">
      <div class="custom-bar">
         <div style="display:inline;">
            <span>Entregas <a href="#" id="milestonesFilter">(${message(code:'milestone.statusFilter.' + (params.milestoneStatus ?: 'open'))})</a>:</span>
            <span style="float:right;"><a id="newMilestone" href="#" class="ui-icon ui-icon-circle-plus">Nuevo</a></span>
         </div>
      </div>
      <ul class="navigation">
         <li class="${!milestone ? 'active' : ''}">
            <g:link action="index" params="${[showUnassigned:true]}">Sin asignar</g:link>
         </li>
         <g:each in="${milestones}" var="milestoneItem">
            <li class="${milestone && milestone.id == milestoneItem.id ? 'active' : ''}">
               <g:link action="index" params="${[id:milestoneItem.id, milestoneStatus: params.milestoneStatus]}">${milestoneItem.name}</g:link>
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
               <g:textField name="startDate" value="${formatDate(date:new Date(), format:'dd/MM/yyyy')}"/>
            </div>
         </div>
         <div class="row" style="clear:both;">
            <div class="label">
               <label>Fecha de Final:</label>
            </div>
            <div class="field">
               <g:textField name="endDate" value="${formatDate(date:new Date(), format:'dd/MM/yyyy')}"/>
            </div>
         </div>
      </g:form>
   </div>
</div>

<g:form action="closeMilestone" name="closeMilestoneForm" class="form" style="display:none">
   <g:hiddenField name="id" value="${milestone?.id ?: ''}"/>
   <g:hiddenField name="showUnassigned" value="${showUnassigned}"/>
</g:form>


<div id="milestonesFilterDialog" title="" style="display:none;">
   <g:form name="milestonesFilterForm" action="index" method="get">
      <g:select name="milestoneStatus" from="['open':'Abiertas', 'closed':'Cerradas', 'all':'Todas']" optionKey="key" optionValue="value" value="${params.milestoneStatus}"/>
   </g:form>
</div>

<script type="text/javascript">
   $(function() {
      $("#startDate").datepicker({dateFormat: 'dd/mm/yy'});
      $("#endDate").datepicker({dateFormat: 'dd/mm/yy'});

      $("#newMilestone").click(function() {
         $('#name').focus();
         var position = $(this).position();
         $("#newMilestoneDialog").dialog({
            width:550, modal: true, position: [position.left, position.top + $(this).height()],
            buttons: {
               "Guardar": function() {
                  $('#newMilestoneForm').submit();
               }
            }
         });
      });

      $("#close").styledButton({
         'orientation' : 'alone',
         'action' : function () {
            $('#closeMilestoneForm').submit();
         }
      });

      $('#milestonesFilter').click(function() {
         event.preventDefault();
         var position = $(this).position();
         $("#milestonesFilterDialog").dialog({
            minHeight:0, width:200, position: [position.left, position.top + $(this).height()], resizable:false, dialogClass:'simple'
         });
      });

      $('#milestoneStatus').change(function(){
        $('#milestonesFilterForm').submit();
      });
   });

</script>
</body>
</html>

