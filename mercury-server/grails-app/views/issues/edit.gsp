<%--
  User: cesarreyes
  Date: 18/11/10
  Time: 23:06
--%>

<%@ page import="org.nopalsoft.mercury.domain.IssueType; org.nopalsoft.mercury.domain.Priority" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="main">
  <title>${issue.summary}</title>
</head>
<body>

<content tag="navbar">
  <g:render template="/shared/menu" model="[selected:'issues']"/>
</content>

<div id="main">
  <div class="block" id="block-text">
    <div class="content">
      <h1>Editar incidencia</h1>

      <g:form action="saveEdit" name="issueForm" class="form">
        <g:hiddenField name="id" value="${issue.id}"/>
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
              <g:link action="view" id="${issue.code}">cancelar</g:link>
            </div>
          </div>
        </div>
      </g:form>
    </div>
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

</body>
</html>