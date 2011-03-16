<%--
  User: cesarreyes
  Date: 01/11/10
  Time: 19:09
--%>

<%@ page import="org.nopalsoft.mercury.domain.Resolution" contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>${issue.summary}</title>
  <meta name="layout" content="main"/>
</head>
<body>

<content tag="navbar">
  <g:render template="/shared/menu" model="[selected:'issues']"/>
</content>

<div id="main">
  <div class="block" id="block-text">
    <div class="content">
      <div class="inner">

        <div class="issue-menu" style="margin-top:20px;">
          <span id="resolve">Resolver</span>
          <span id="assign">Asignar</span>
          <span id="attach">Archivos adjuntos (${issue.attachments.size()})</span>
          <span id="edit">Editar</span>
          %{--<div style="float:right;">--}%
            %{--<span id="back"><<</span>--}%
            %{--<span id="next">>></span>--}%
          %{--</div>--}%
        </div>

        <h2 class="title">${issue.code} ${issue.summary}</h2>

        <div style="margin-bottom:20px;">
          <p>${issue.description}</p>
        </div>

        <div style="background-color:#F9F9FA;border: 1px solid #ccc;padding:5px;">
          <h3>Historia (${logs.size()})</h3>
          <div id="logs" style="font-size:x-small;">
            <g:each in="${logs}" var="log">
              <div class="comment" style="margin: 10px;5px;">
                  <div class="comment-user" style="padding:4px;background-color:#F0F1F2;border-bottom: 1px solid #D4D5D6;">
                      ${log.user.fullName} ${log.date}
                  </div>
                    <g:if test="${log.changes}">
                      <ul>
                        <g:each in="${log.changes}" var="change">
                            <g:set var="property" value="issue.${change.property}"/>
                            <li><strong>${change.property}</strong> cambiado de <em>${change.originalValue}</em> a <em>${change.newValue}</em></li>
                        </g:each>
                      </ul>
                    </g:if>
                  <div>
                      ${log.comment}
                  </div>
              </div>
            </g:each>
          </div>
          <div style="margin: 5px;">
            <g:form action="addComment" id="${issue.code}">
              Agregar comentario<br>
              <g:textArea name="comment" rows="2" cols="30" style="width:100%;border: 2px solid #ccc;"/>
              <g:submitButton name="addComment" value="Agregar comentario"/>
            </g:form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="sidebar">
  <div class="block">
    <h3>Propiedades</h3>
    <div class="content">
      <table style="width:100%;">
        <tr>
          <td>Entrega</td>
          <td>${issue.milestone ? issue.milestone.name : "Sin asignar"}</td>
        </tr>
        <tr>
          <td>Fecha de entrega</td>
          <td><g:formatDate date="${issue.dueDate}" format="EEE, dd MMM yyyy"/></td>
        </tr>
        <tr>
          <td>Tipo</td>
          <td>${issue.issueType.name}</td>
        </tr>
        <tr>
          <td>Estado</td>
          <td>${issue.status.name}</td>
        </tr>
        <tr>
          <td>Prioidad</td>
          <td>${issue.priority.name}</td>
        </tr>
        <tr>
          <td>Categoria</td>
          <td>${issue.category?.name}</td>
        </tr>
        <tr>
          <td>Reportador</td>
          <td>${issue.reporter.fullName}</td>
        </tr>
        <tr>
          <td>Asignado a</td>
          <td>${issue.assignee?.fullName}</td>
        </tr>
        <tr>
          <td>Subscriptores</td>
          <td>
            <ul>
              <g:each in="${issue.watchers}" var="watcher">
                <li>${watcher.fullName}</li>
              </g:each>
            </ul>
          </td>
        </tr>
      </table>
    </div>
  </div>
</div>


<div id="assignIssueDialog" title="Asignar Incidencia" style="display:none;">
  <g:form action="assignIssue" name="assignIssueForm" id="${issue.code}" class="form">
    <div class="group">
      <label class="label">Asignar a:</label>
      <g:select name="assignee.id" value="${issue.assignee?.id}" from="${issue.project.users.findAll{ it.enabled }.sort{ it.fullName }}" optionKey="id" optionValue="fullName" noSelection="${['':'Seleccione']}"/>
    </div>
    <div class="group">
      <label class="label">Comentario:</label>
      <g:textArea name="assignComment" style="width:500px;height:100px;"/>
    </div>
  </g:form>
</div>

<div id="addAttachmentDialog" title="Archivos adjuntos" style="display:none;">
  <div class="form">
    <div class="row">
      <table>
        <g:each in="${issue.attachments}" var="attachment">
          <tr>
            <td><g:link action="showAttachment" id="${issue.id}" params="[attachmentId:attachment.id]" target="_blank">${attachment.description ?: attachment.file}</g:link></td>
          </tr>
        </g:each>
      </table>
    </div>
    <g:uploadForm action="addAttachment" id="${issue.code}">
      <hr/>
      <h2>Agregar archivo adjunto</h2>
      <div class="row">
        <div class="label">
          <label>Archivo:</label>
        </div>
        <div class="field">
          <input type="file" name="file"/>
        </div>
      </div>
      <div class="row">
        <div class="label">
          <label>Descripcion:</label>
        </div>
        <div class="field">
          <g:textField name="description"/>
        </div>
      </div>
      <div class="row">
        <g:submitButton name="addAttachment" value="Adjuntar archivo" />
      </div>
    </g:uploadForm>
  </div>
</div>

<div id="resolveIssueDialog" title="Resolver incidencia" style="display:none;">
  <g:form action="resolveIssue" id="${issue.code}" name="resolveIssueForm" class="form">
    <div class="group">
      <label class="label">Resolucion:</label>
      <g:select name="resolution" from="${Resolution.list()}" optionKey="id" optionValue="name" noSelection="['':'Seleccione...']"/>
    </div>
    <div class="group">
      <label class="label">Notificar a:</label>
      <g:select name="notifyTo" from="${issue.project.users.findAll{ it.enabled && it.id != issue.reporter.id }.sort{ it.fullName }}" optionKey="id" optionValue="fullName" noSelection="['':'Seleccione...']"/>
      <div class="description">Si desea que alguien m&aacute;s, ademas de quien abrio la incidencia sea notificado.</div>
    </div>
    <div class="group">
      <label class="label">Comentario:</label>
      <g:textArea name="resolveComment" style="width:500px;height:100px;"/>
    </div>
  </g:form>
</div>

<script type="text/javascript">
  $(function(){
    $("#resolve").styledButton({
      'orientation' : 'alone',
      'action' : function () {
        var position = $(this).position();
        $( "#resolveIssueDialog").dialog({
          width:550, modal: true, position: [position.left, position.top + $(this).height()],
          buttons:{
            "Resolver":function(){
              $('#resolveIssueForm').submit();
            }
          }
        });
      }
    });
    $("#assign").styledButton({
      'orientation' : 'alone',
      'action' : function () {
        var position = $(this).position();
        $( "#assignIssueDialog").dialog({
          width:550, modal: true, position: [position.left, position.top + $(this).height()],
          buttons:{
            "Asignar": function(){
              $('#assignIssueForm').submit();
            }
          }
        });
      }
    });
    $("#attach").styledButton({
      'orientation' : 'alone',
      'action' : function () {
        var position = $(this).position();
        $( "#addAttachmentDialog").dialog({
          width:550, modal: true, position: [position.left, position.top + $(this).height()]
        });
      }
    });
    $("#edit").styledButton({
      'orientation' : 'alone',
      'action' : function () {
        document.location.href = '${createLink(action:'edit', id: issue.code)}';
      }
    });
//    $("#back").styledButton({
//      'orientation' : 'alone',
//      'action' : function () { alert( 'omfg' ) }
//    });
//    $("#next").styledButton({
//      'orientation' : 'alone',
//      'action' : function () { alert( 'omfg' ) }
//    });

    $( "#assignIssue").button();
  });
</script>

</body>
</html>