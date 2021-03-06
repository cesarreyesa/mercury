<%-- User: cesarreyes, Date: 06/08/11, Time: 22:27 --%>
<%@ page import="org.nopalsoft.mercury.domain.Priority; org.nopalsoft.mercury.domain.IssueType" contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <meta name="layout" content="plain"/>
   <title>
      Nueva ${message(code: 'nectar.task.lower')}
   </title>
   <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/skins/simple', file: 'style.css')}"/>
   <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/sets/default', file: 'style.css')}"/>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.markitup.js')}"></script>
   <script type="text/javascript" src="${resource(dir: 'js/sets/default', file: 'set.js')}"></script>
</head>

<body>

<g:form action="save" name="issueForm" class="form-stacked">
   <div class="modal-header">
      <a href="#" class="close">×</a>
      <h3>Nueva ${message(code: 'nectar.task.lower')}</h3>
   </div>

   <div class="modal-body">
      <g:hiddenField name="project.id" value="${project.id}"/>
      <g:hiddenField name="parent.id" value="${issue.parent?.id}"/>
      <g:hasErrors bean="${issue}">
         <div class="errors">
            <g:renderErrors bean="${issue}" as="list"/>
         </div>
      </g:hasErrors>
      <div class="row">
         <div class="span8 columns">
            <div class="clearfix">
               <label for="summary">Resumen:</label>
               <div class="input">
                  <g:textField name="summary" value="${issue.summary}" class="text_field"/>
               </div>
            </div>

            <div class="clearfix">
               <label for="description">Descripcion:</label>
               <div class="input">
                  <g:textArea name="description" value="${issue.description}" style="height:100px;width: 420px;"
                           class="text_area"/>
               </div>
            </div>

            <div class="clearfix">
               <label for="issueType.id">Tipo de ${message(code: 'nectar.task.lower')}</label>
               <div class="input">
                  <g:select name="issueType.id" value="${issue.issueType?.id}" from="${IssueType.list()}" optionKey="id"
                         optionValue="name"/>
               </div>
            </div>

            <div class="clearfix">
               <label for="priority.id">Prioridad</label>
               <div class="input">
                  <g:select name="priority.id" value="${issue.priority?.id}" from="${Priority.list()}" optionKey="id"
                         optionValue="name"/>
               </div>
            </div>

            <div class="clearfix">
               <label for="category.id">Categoria</label>
               <div class="input">
                  <g:select name="category.id" value="${issue.category?.id}" from="${categories}" optionKey="id"
                         optionValue="name" noSelection="['':'Seleccione...']"/>
               </div>
            </div>
         </div>

         <div class="span3 columns">
            <div class="control-group">
               <label for="startDate">Fecha de inicio</label>
               <div class="controls">
                  <g:textField name="startDate" value="${formatDate(date:issue.startDate, format:'dd/MM/yyyy')}" style="width: 80px;"/>
                  <g:textField name="startDate.hours" value="${formatDate(date:issue.startDate, format:'HH')}" style="width: 20px;"/> :
                  <g:textField name="startDate.minutes" value="${formatDate(date:issue.startDate, format:'mm')}" style="width: 20px;"/>
                  Repetir
                  <g:select name="repeatMode" from="['Nunca', 'Cada dia', 'Cada semana', 'Todos los meses']"/>
               </div>
            </div>

            <div class="clearfix">
               <label for="milestone.id">Entrega</label>
               <div class="input">
                  <g:select name="milestone.id" value="${issue.milestone?.id}" from="${milestones}" optionKey="id"
                         optionValue="name" noSelection="['':'-Sin asignar-']"/>
               </div>
            </div>

            <div class="clearfix">
               <label for="dueDate">Fecha de entrega</label>
               <div class="input">
                  <g:textField name="dueDate" value="${formatDate(date:issue.dueDate, format:'dd/MM/yyyy')}"
                            class="text_field" style="width:100px;"/>
               </div>
            </div>
            <div class="clearfix">
               <label for="reporter.id">Reportador:</label>
               <div class="input">
                  <g:select name="reporter.id" value="${issue.reporter?.id}"
                         from="${project.users.findAll{ it.enabled }.sort{ it.fullName }}" optionKey="id"
                         optionValue="fullName"/>
               </div>
            </div>

            <div class="clearfix">
               <label for="assignee.id">Asignado a:</label>
               <div class="input">
                  <g:select name="assignee.id" value="${issue.assignee?.id}"
                         from="${project.users.findAll{ it.enabled }.sort{ it.fullName }}" optionKey="id"
                         optionValue="fullName" noSelection="${['':'Seleccione']}"/>
               </div>
            </div>

            <div class="clearfix">
               <label for="watchers">Observadores:</label>
               <div class="input">
                  <g:select name="watchers" from="${project.users.findAll{ it.enabled }.sort{ it.fullName }}"
                         optionKey="id" optionValue="fullName"
                         multiple="true" value="${issue.watchers}" style="height:100px;"/>
               </div>
            </div>
         </div>
      </div>
   </div>
   <div class="modal-footer">
      <g:submitButton name="newIssue" value="Guardar" class="btn btn-primary" id="newIssueButton"/>
      <a href="#" class="btn" id="newIssueCancel">Cancelar</a>
   </div>
</g:form>

<script type="text/javascript">
   $(function() {
      $("#dueDate").datepicker({dateFormat: 'dd/mm/yy'});
      $('#summary').focus();
      $('#newIssueButton').click(function(e){
         e.preventDefault();
         $.post('${createLink(controller:'issues', action: 'saveAjax')}', $('#issueForm').serialize(), function(data, textStatus){
            $("#newIssueDialog").html('${message(code: 'nectar.task')} creada exitosamente');
            setTimeout(function(){
               $('#newIssueDialog').dialog('close');
               <g:if test="${params.reload == 'true'}">
                  window.location=window.location;
               </g:if>
            }, 1000)
         });
      });
      $('#newIssueCancel').click(function(e){
         e.preventDefault();
         $('#newIssueDialog').modal('hide');
         $("#newIssueDialog").html('');
      });
      $('#description').markItUp(mySettings);
   });
</script>

</body>
</html>