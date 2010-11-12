<%--
  Created by IntelliJ IDEA.
  User: cesarreyes
  Date: 01/11/10
  Time: 19:09
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>${issue.summary}</title>
  <meta name="layout" content="main"/>
</head>
<body>

<content tag="navbar">
  <g:render template="/shared/menu" model="[selected:'issues']"/>
</content>

<div id="leftnav">
  <table style="width:100%;">
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
    %{--<tr>--}%
    %{--<td>Entrega</td>--}%
    %{--<td>${issue}</td>--}%
    %{--</tr>--}%
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
      <td></td>
    </tr>
  </table>
</div>
<div id="content" class="issue">
  <div class="issue-menu">
    <span id="resolve">
      Resolver
      <ul>
        <li>1</li>
        <li>2</li>
        <li>3</li>
      </ul>
    </span>
    <span id="assign">Asignar</span>
    <span id="attach">Adjuntar archivos</span>
    <span id="edit">Editar</span>
    <div style="float:right;">
      <span id="back"><<</span>
      <span id="next">>></span>
    </div>
  </div>

  <h1 style="margin-top:10px;">${issue.code} ${issue.summary}</h1>

  <p style="margin-bottom:20px;">${issue.description}</p>
  <div style="background-color:#F9F9FA;border: 1px solid #ccc;padding:5px;">
    <h2>Historia (0)</h2>
    <div id="logs" style="font-size:x-small;">
      <g:each in="${logs}" var="log">
        <div class="comment" style="margin: 10px;5px;">
            <div class="comment-user" style="padding:4px;background-color:#F0F1F2;border-bottom: 1px solid #D4D5D6;">
                ${log.user.fullName} ${log.date}
            </div>
              %{--<g:if test="${log.changes}">--}%
                %{--<ul>--}%
                  %{--<g:each in="${log.changes}" var="change">--}%
                      %{--<g:set var="property" value="issue.${change.property}"/>--}%
                      %{--<li><strong>${change.property}</strong> cambiado de <em>${change.originalValue}</em> a <em>${change.newValue}</em></li>--}%
                  %{--</g:each>--}%
                %{--</ul>--}%
              %{--</g:if>--}%
            <div>
                ${log.comment}
            </div>
        </div>
      </g:each>
    </div>
    <div style="margin: 5px;">
      <form onsubmit="
        Nopal.Ajax.request({
          url: '/mercury/issues/saveComment.html',
          params: {issueId: 282, comment: Ext.get('comment').dom.value},
          success: function() {
            Ext.get('comment').dom.value = '';
            Ext.get('logs').load({ url: '/mercury/issues/logs.html?id=282' });
          }
        });
        return false;
      ">
        Agregar comentario<br>
        <textarea id="comment" rows="2" cols="30" style="width:100%;border: 2px solid #ccc;"></textarea>
        <input type="submit" value="Agregar Comentario">
      </form>
    </div>
  </div>
</div>

<div id="assignIssueDialog" title="Asignar Incidencia" style="display:none;" class="normal-dialog">
  <g:form action="assignIssue" id="${issue.code}">
    <div class="form">
      <div class="row">
        <div class="label">
          <label>Asignar a:</label>
        </div>
        <div class="field">
          <g:select name="assignee.id" value="${issue.assignee?.id}" from="${issue.project.users.sort{ it.fullName }}" optionKey="id" optionValue="fullName" noSelection="${['':'Seleccione']}"/>
        </div>
      </div>
      <div class="row">
        <div class="label">
          <label>Comentario:</label>
        </div>
        <div class="field">
          <g:textArea name="comment" style="width:500px;height:100px;"/>
        </div>
      </div>
      <div class="row">
        <g:submitButton name="assignIssue" value="Asignar" />
      </div>
    </div>
  </g:form>
</div>

<script type="text/javascript">
  $(function(){
    $("#resolve").styledButton({
      'orientation' : 'alone',
      'action' : function () { alert( 'omfg' ) },
      'dropdown' : { 'element' : 'ul' }
    });
    $("#assign").styledButton({
      'orientation' : 'alone',
      'action' : function () {
        var position = $(this).position();
        $( "#assignIssueDialog").dialog({
          width:550, modal: true, position: [position.left, position.top + $(this).height()]
        });
      }
    });
    $("#attach").styledButton({
      'orientation' : 'alone',
      'action' : function () { alert( 'omfg' ) }
    });
    $("#edit").styledButton({
      'orientation' : 'alone',
      'action' : function () { alert( 'omfg' ) }
    });
    $("#back").styledButton({
      'orientation' : 'alone',
      'action' : function () { alert( 'omfg' ) }
    });
    $("#next").styledButton({
      'orientation' : 'alone',
      'action' : function () { alert( 'omfg' ) }
    });

    $( "#assignIssue").button();
  });
</script>

</body>
</html>