<%-- User: cesarreyes, Date: 07/11/10, Time: 16:31 --%>
<%@ page import="org.nopalsoft.mercury.domain.Priority; org.nopalsoft.mercury.domain.IssueType" contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <meta name="layout" content="main"/>
   <title>
      Nueva incidencia
   </title>
   <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/skins/simple', file: 'style.css')}"/>
   <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/sets/default', file: 'style.css')}"/>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.markitup.js')}"></script>
   <script type="text/javascript" src="${resource(dir: 'js/sets/default', file: 'set.js')}"></script>
</head>

<body>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'new']"/>
</content>

<div class="content">
   <h2 class="title">Nueva incidencia</h2>

   <g:uploadForm action="save" name="issueForm" class="form-stacked">
      <g:hiddenField name="project.id" value="${project.id}"/>
      <g:hasErrors bean="${issue}">
         <div class="alert-message block-message error">
            <p>Hubo un error al crear la incidencia, revisa los siguientes mensajes:</p>
            <ul>
               <g:eachError bean="${issue}">
                  <li><g:message error="${it}"/></li>
               </g:eachError>
            </ul>
         </div>
      </g:hasErrors>
      <div class="row">
         <div class="span8 columns">
            <div class="clearfix">
               <label for="summary">Resumen:</label>

               <div class="input">
                  <g:textField name="summary" value="${issue.summary}" class="xlarge"/>
               </div>
            </div>

            <div class="clearfix">
               <label>Descripcion:</label>

               <div class="input"><g:textArea name="description" value="${issue.description}"
                                              style="height:100px;width: 420px;"
                                              class="text_area"/></div>
            </div>

            <div class="clearfix">
               <label>Entrega</label>

               <div class="input"><g:select name="milestone.id" value="${issue.milestone?.id}" from="${milestones}"
                                            optionKey="id"
                                            optionValue="name" noSelection="['':'-Sin asignar-']"/></div>
            </div>

            <div class="clearfix">
               <label for="startDate">Fecha de inicio</label>
               <div class="input"><g:textField name="startDate" value="${formatDate(date:issue.startDate, format:'dd/MM/yyyy')}"/></div>
            </div>

            <div class="clearfix">
               <label>Fecha de entrega</label>
               <div class="input"><g:textField name="dueDate"
                                               value="${formatDate(date:issue.dueDate, format:'dd/MM/yyyy')}"
                                               class="text_field" style="width:100px;"/></div>
            </div>

            <div class="clearfix">
               <label>Tipo de incidencia</label>

               <div class="input"><g:select name="issueType.id" value="${issue.issueType?.id}"
                                            from="${IssueType.list()}" optionKey="id"
                                            optionValue="name"/></div>
            </div>

            <div class="clearfix">
               <label>Prioridad</label>

               <div class="input"><g:select name="priority.id" value="${issue.priority?.id}" from="${Priority.list()}"
                                            optionKey="id"
                                            optionValue="name"/></div>
            </div>

            <div class="clearfix">
               <label for="category.id">Categoria</label>

               <div class="input"><g:select name="category.id" value="${issue.category?.id}" from="${categories}"
                                            optionKey="id"
                                            optionValue="name" noSelection="['':'Seleccione...']"/></div>
            </div>

            <div class="clearfix">
               <label for="attachment">Adjuntar archivo</label>
               <div class="input">
                  <g:textField name="attachmentDescription" placeholder="Descripción"/>
               </div>
               <div class="input">
                  <input type="file" name="attachment" id="attachment"/>
               </div>
            </div>
         </div>

         <div class="span4 columns">
            <div class="clearfix">
               <label>Reportador:</label>

               <div class="input"><g:select name="reporter.id" value="${issue.reporter?.id}"
                                            from="${project.users.findAll{ it.enabled }.sort{ it.fullName }}"
                                            optionKey="id"
                                            optionValue="fullName"/></div>
            </div>

            <div class="clearfix">
               <label>Asignado a:</label>

               <div class="input"><g:select name="assignee.id" value="${issue.assignee?.id}"
                                            from="${project.users.findAll{ it.enabled }.sort{ it.fullName }}"
                                            optionKey="id"
                                            optionValue="fullName" noSelection="${['':'Seleccione']}"/></div>
            </div>

            <div class="clearfix">
               <label>Observadores:</label>

               <div class="input"><g:select name="watchers"
                                            from="${project.users.findAll{ it.enabled }.sort{ it.fullName }}"
                                            optionKey="id" optionValue="fullName"
                                            multiple="true" value="${issue.watchers}" style="height:100px;"/></div>
            </div>
         </div>
      </div>

      <div class="actions">
         <g:submitButton name="save" class="btn primary" value="Guardar"/>
         <g:link action="index">cancelar</g:link>
      </div>
   </g:uploadForm>
</div>

<script type="text/javascript">
   $(function() {
      $("#dueDate").datepicker({dateFormat: 'dd/mm/yy'});
      $('#summary').focus();
      $('#description').markItUp(mySettings);
   });
</script>

</body>
</html>