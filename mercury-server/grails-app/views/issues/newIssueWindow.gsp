<%-- User: cesarreyes, Date: 06/08/11, Time: 22:27 --%>
<%@ page import="org.nopalsoft.mercury.domain.Priority; org.nopalsoft.mercury.domain.IssueType" contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <meta name="layout" content="plain"/>
   <title>
      Nueva incidencia
   </title>
   <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/skins/simple', file: 'style.css')}"/>
   <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/sets/default', file: 'style.css')}"/>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.markitup.js')}"></script>
   <script type="text/javascript" src="${resource(dir: 'js/sets/default', file: 'set.js')}"></script>
</head>

<body>

<div class="content">
   <div class="inner">
      <g:form action="save" name="issueForm" class="form">
         <g:hiddenField name="project.id" value="${project.id}"/>
         <g:hasErrors bean="${issue}">
            <div class="errors">
               <g:renderErrors bean="${issue}" as="list"/>
            </div>
         </g:hasErrors>
         <div class="columns wat-cf">
            <div class="column left" style="width:420px;">
               <div class="group">
                  <label for="summary" class="label">Resumen:</label>
                  <g:textField name="summary" value="${issue.summary}" class="text_field"/>
               </div>

               <div class="group">
                  <label class="label">Descripcion:</label>
                  <g:textArea name="description" value="${issue.description}" style="height:100px;width: 420px;"
                              class="text_area"/>
               </div>

               <div class="group">
                  <label class="label">Tipo de incidencia</label>
                  <g:select name="issueType.id" value="${issue.issueType?.id}" from="${IssueType.list()}" optionKey="id"
                            optionValue="name"/>
               </div>

               <div class="group">
                  <label class="label">Prioridad</label>
                  <g:select name="priority.id" value="${issue.priority?.id}" from="${Priority.list()}" optionKey="id"
                            optionValue="name"/>
               </div>

               <div class="group">
                  <label class="label">Categoria</label>
                  <g:select name="category.id" value="${issue.category?.id}" from="${categories}" optionKey="id"
                            optionValue="name" noSelection="['':'Seleccione...']"/>
               </div>
            </div>

            <div class="column right" style="width:250px;">
               <div class="group">
                  <label class="label">Entrega</label>
                  <g:select name="milestone.id" value="${issue.milestone?.id}" from="${milestones}" optionKey="id"
                            optionValue="name" noSelection="['':'-Sin asignar-']"/>
               </div>

               <div class="group">
                  <label class="label">Fecha de entrega</label>
                  <g:textField name="dueDate" value="${formatDate(date:issue.dueDate, format:'dd/MM/yyyy')}"
                               class="text_field" style="width:100px;"/>
               </div>
               <div class="group">
                  <label class="label">Reportador:</label>
                  <g:select name="reporter.id" value="${issue.reporter?.id}"
                            from="${project.users.findAll{ it.enabled }.sort{ it.fullName }}" optionKey="id"
                            optionValue="fullName"/>
               </div>

               <div class="group">
                  <label class="label">Asignado a:</label>
                  <g:select name="assignee.id" value="${issue.assignee?.id}"
                            from="${project.users.findAll{ it.enabled }.sort{ it.fullName }}" optionKey="id"
                            optionValue="fullName" noSelection="${['':'Seleccione']}"/>
               </div>

               <div class="group">
                  <label class="label">Observadores:</label>
                  <g:select name="watchers" from="${project.users.findAll{ it.enabled }.sort{ it.fullName }}"
                            optionKey="id" optionValue="fullName"
                            multiple="true" value="${issue.watchers}" style="height:100px;"/>
               </div>
            </div>
         </div>

         <div class="group navform">
            <g:submitButton name="newIssue" value="Guardar" id="newIssueButton"/>
            <a href="#" id="newIssueCancel">cancelar</a>
         </div>
      </g:form>
   </div>
</div>

<script type="text/javascript">
   $(function() {
      $("#dueDate").datepicker({dateFormat: 'dd/mm/yy'});
      $('#summary').focus();
      $('#newIssueButton').button();
      $('#newIssueButton').click(function(e){
         e.preventDefault();
         $.post('${createLink(controller:'issues', action: 'saveAjax')}', $('#issueForm').serialize(), function(data, textStatus){
            $("#newIssueDialog").html('Incidencia creada exitosamente');
            setTimeout(function(){
               $('#newIssueDialog').dialog('close');
            }, 1000)
         });
      });
      $('#newIssueCancel').click(function(e){
         e.preventDefault();
         $('#newIssueDialog').dialog('close');
         $("#newIssueDialog").html('');
      });
      $('#description').markItUp(mySettings);
   });
</script>

</body>
</html>