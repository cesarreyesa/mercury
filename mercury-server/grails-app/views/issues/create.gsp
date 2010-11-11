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

<h1>Nueva incidencia</h1>

<g:form action="save" name="issueForm">
  <g:hiddenField name="project.id" value="${project.id}"/>
  <div class="form">
    <g:hasErrors bean="${issue}">
       <div class="errors">
          <g:renderErrors bean="${issue}" as="list"/>
       </div>
    </g:hasErrors>
    <div class="left" style="float:left;">
      <div class="row">
        <div class="label">
          <label>Resumen:</label>
        </div>
        <div class="field">
          <g:textField name="summary" value="${issue.summary}" style="width:500px;"/>
        </div>
      </div>
      <div class="row">
        <div class="label">
          <label>Descripcion:</label>
        </div>
        <div class="field">
          <g:textArea name="description" value="${issue.description}" style="width:500px;height:100px;"/>
        </div>
      </div>
      <div class="row">
        <div class="box">
          <label>Tipo de incidencia</label>
          <g:select name="issueType.id" value="${issue.issueType?.id}" from="${IssueType.list()}" optionKey="id" optionValue="name"/>
        </div>
        <div class="box">
          <label>Prioridad</label>
          <g:select name="priority.id" value="${issue.priority?.id}" from="${Priority.list()}" optionKey="id" optionValue="name" />
        </div>
      </div>
      <div class="buttons">
        <span id="save">Guardar</span>
      </div>
    </div>
    <div class="right" style="float:left;padding:10px;">
      <fieldset style="margin-left:20px;">
        <legend>Propiedades</legend>
        <div class="row">
          <div class="box">
            <label>Reportador:</label>
            <g:select name="reporter.id" value="${issue.reporter?.id}" from="${project.users.sort{ it.fullName }}" optionKey="id" optionValue="fullName" />
          </div>
        </div>
        <div class="row">
          <div class="box">
            <label>Asignado a:</label>
            <g:select name="assignee.id" value="${issue.assignee?.id}" from="${project.users.sort{ it.fullName }}" optionKey="id" optionValue="fullName" noSelection="${['':'Seleccione']}"/>
          </div>
        </div>
        <div class="row">
          <div class="box">
            <label>Observadores</label>
            <g:select name="watcher" from="${project.users.sort{ it.fullName }}" optionKey="id" optionValue="fullName" noSelection="${['':'Seleccione']}"/>
          </div>
        </div>
      </fieldset>
    </div>
  </div>
  <script type="text/javascript">
    $(document).ready(function () {
      $('#summary').focus();
      $("#save").styledButton({
        'orientation' : 'alone',
        'action' : function () {
          $('#issueForm').trigger('submit');
        }
      });
    });

  </script>

</g:form>

</body>
</html>