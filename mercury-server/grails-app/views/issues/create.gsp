<%-- User: cesarreyes, Date: 07/11/10, Time: 16:31 --%>
<%@ page import="org.nopalsoft.mercury.domain.Priority; org.nopalsoft.mercury.domain.IssueType" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="main"/>
  <title>
    Nueva incidencia
  </title>
</head>
<body>

<content tag="navbar">
  <g:render template="/shared/menu" model="[selected:'new']"/>
</content>

<div id="main">
  <div class="block" id="block-text">
    <div class="content">
      <h2 class="title">Nueva incidencia</h2>
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
                <g:textField name="summary" value="${issue.summary}" style="width:400px;"/>
              </div>
              <div class="group">
                <label class="label">Descripcion:</label>
                <g:textArea name="description" value="${issue.description}" style="width:400px;height:100px;"/>
              </div>
              <div class="group">
                <label class="label">Tipo de incidencia</label>
                <g:select name="issueType.id" value="${issue.issueType?.id}" from="${IssueType.list()}" optionKey="id" optionValue="name"/>
              </div>
              <div class="group">
                <label class="label">Prioridad</label>
                <g:select name="priority.id" value="${issue.priority?.id}" from="${Priority.list()}" optionKey="id" optionValue="name" />
              </div>
              <div class="group">
                <label class="label">Categoria</label>
                <g:select name="category.id" value="${issue.category?.id}" from="${categories}" optionKey="id" optionValue="name" noSelection="['':'Seleccione...']"/>
              </div>
              <div class="group">
                <label class="label">Fecha de entrega</label>
                <g:textField name="dueDate" value="${formatDate(date:issue.dueDate, format:'dd/MM/yyyy')}" />
              </div>
            </div>
            <div class="column right" style="width:250px;">
              <div class="group">
                <label class="label">Reportador:</label>
                <g:select name="reporter.id" value="${issue.reporter?.id}" from="${project.users.findAll{ it.enabled }.sort{ it.fullName }}" optionKey="id" optionValue="fullName" />
              </div>
              <div class="group">
                <label class="label">Asignado a:</label>
                <g:select name="assignee.id" value="${issue.assignee?.id}" from="${project.users.findAll{ it.enabled }.sort{ it.fullName }}" optionKey="id" optionValue="fullName" noSelection="${['':'Seleccione']}"/>
              </div>
              <div class="group">
                <label class="label">Observadores:</label>
                <g:select name="watchers" from="${project.users.findAll{ it.enabled }.sort{ it.fullName }}" optionKey="id" optionValue="fullName"
                        multiple="true" value="${issue.watchers}" style="height:100px;"/>
              </div>
            </div>
          </div>

          <div class="group navform wat-cf">
            <button class="button" type="submit">
              <img src="${resource(dir:'images/icons', file:'tick.png')}" alt="Guardar" /> Guardar
            </button>
            <g:link action="index" class="button"><img src="${resource(dir:'images/icons', file:'cross.png')}" alt="Cancel"/> Cancelar</g:link>
          </div>
        </g:form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  $(document).ready(function () {
    $("#dueDate").datepicker({dateFormat: 'dd/mm/yy'});
    $('#summary').focus();
  });
</script>

</body>
</html>