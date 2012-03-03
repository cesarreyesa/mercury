<%-- User: cesarreyes, Date: 07/11/10, Time: 16:31 --%>
<%@ page import="org.nopalsoft.mercury.domain.Priority; org.nopalsoft.mercury.domain.IssueType" contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <meta name="layout" content="main"/>
   <title>
      Nueva ${message(code: 'nectar.task.lower')}
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
   <h2 class="title">Nueva ${message(code: 'nectar.task.lower')}</h2>

   <g:uploadForm action="save" name="issueForm" class="form-stacked">
      <g:hiddenField name="project.id" value="${project.id}"/>
      <g:hasErrors bean="${issue}">
         <div class="alert alert-error">
            <p>Hubo un error al crear la ${message(code: 'nectar.task.lower')}, revisa los siguientes mensajes:</p>
            <ul>
               <g:eachError bean="${issue}">
                  <li><g:message error="${it}"/></li>
               </g:eachError>
            </ul>
         </div>
      </g:hasErrors>
      <div class="row">
         <div class="span8 columns">
            <div class="control-group">
               <label for="summary">Resumen:</label>

               <div class="controls">
                  <g:textField name="summary" value="${issue.summary}" class="span6"/>
               </div>
            </div>

            <div class="control-group">
               <label class="control-label" for="description">Descripcion:</label>

               <div class="controls"><g:textArea name="description" value="${issue.description}"
                                              style="height:100px;" class="span6" /></div>
            </div>

            <div class="accordion" id="accordion2">
               <div class="accordion-group">
                  <div class="accordion-heading">
                     <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
                        Fechas
                     </a>
                  </div>
                  <div id="collapseOne" class="accordion-body collapse">
                     <div class="accordion-inner">
                        <div class="control-group">
                           <label>Entrega</label>

                           <div class="controls"><g:select name="milestone.id" value="${issue.milestone?.id}" from="${milestones}"
                                                           optionKey="id"
                                                           optionValue="name" noSelection="['':'-Sin asignar-']"/></div>
                        </div>

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
                           <label>Fecha de entrega</label>
                           <div class="input"><g:textField name="dueDate"
                                                           value="${formatDate(date:issue.dueDate, format:'dd/MM/yyyy')}" style="width: 80px;"/></div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>

            <div class="clearfix">
               <label>Tipo de ${message(code: 'nectar.task.lower')}</label>

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

      <div class="form-actions">
         <g:submitButton name="save" class="btn btn-primary" value="Guardar"/>
         <g:link action="index">cancelar</g:link>
      </div>
   </g:uploadForm>
</div>

<script type="text/javascript">
   $(function() {
      $("#dueDate").datepicker({dateFormat: 'dd/mm/yy'});
      $("#startDate").datepicker({dateFormat: 'dd/mm/yy'});
      $('#summary').focus();
      $('#description').markItUp(mySettings);
   });
</script>

</body>
</html>