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

<div class="row" style="margin-top:20px;">
   <div class="span10">
      <g:if test="${!issue.resolution}">
         <button class="btn" id="resolve">Resolver</button>
      </g:if>
      <g:elseif test="${issue.status?.code != 'closed'}">
         <button class="btn" id="close">Cerrar</button>
      </g:elseif>
      <button class="btn" id="assign">Asignar</button>
      <button class="btn" id="attach">Archivos adjuntos (${issue.attachments.size()})</button>
      <button class="btn" id="edit">Editar</button>
      <button class="btn" id="pomodoro">Iniciar pomodoro</button>
   </div>
   <div class="span2">
      <div id="pomodoroCountdown" class="countdown" style="height: 40px;width: 100px;display:none;"></div>
   </div>
   <div class="span4">
      <div id="successMessage" class="alert-message success" style="display: none;">
        <p><strong>Bien hecho!</strong> Haz terminado un pomodoro completo.</p>
      </div>
   </div>

   %{--<div style="float:right;">--}%
   %{--<span id="back"><<</span>--}%
   %{--<span id="next">>></span>--}%
   %{--</div>--}%
</div>

<div class="row">
   <div class="span12 columns">
      <div class="box">
         <div class="box-inner">
            <span class="small">
               abierta por <strong>${issue.reporter.fullName}</strong> el <g:formatDate date="${issue.date}" format="MMM dd, yyyy"/></span>
            <h2><span class="label-large">${issue.code}</span> ${issue.summary}</h2>

            <span class="small">
               asignado a <strong>${issue.assignee?.fullName}</strong>
            </span>

            <div style="margin-top: 20px;margin-bottom:20px;">
               <p><g:markdownToHtml>${issue.description}</g:markdownToHtml></p>
            </div>

            <div style="margin-top: 20px;margin-bottom:20px;">
               <ul>
                  <g:each in="${issue.childs}" var="child">
                     <li>
                        <g:set var="childClass" value=""/>
                        <g:if test="${child.status.code == 'resolved' || child.status.code == 'closed'}">
                           <g:set var="childClass" value="completed"/>
                        </g:if>
                        <g:link action="view" id="${child.code}" class="${childClass}">[${child.code}] ${child.summary}</g:link>
                     </li>
                  </g:each>
               </ul>
            </div>
         </div>
      </div>

      <g:render template="/shared/comments" model="[conversation: issue.conversation, controller:'issues']"/>

   </div>
   <div class="span4 columns">
      <table style="width:100%;">
         <g:if test="${issue.parent}">
            <tr>
               <td>Padre</td>
               <td><g:link controller="issues" action="view"
                           id="${issue.parent?.code}">${issue.parent.code}</g:link></td>
            </tr>
         </g:if>
         <tr>
            <td>Entrega</td>
            <td><g:link controller="milestone" action="index"
                        id="${issue.milestone?.id}">${issue.milestone ? issue.milestone.name : "Sin asignar"}</g:link></td>
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
            <td>Subscriptores</td>
            <td>
               <ul>
                  <g:each in="${issue.watchers}" var="watcher">
                     <li>${watcher.fullName}</li>
                  </g:each>
               </ul>
            </td>
         </tr>
         <tr>
            <td>Pomodoros</td>
            <td>
               ${pomodoros}
            </td>
         </tr>
      </table>

   </div>
</div>


<div id="assignIssueDialog" style="display:none;" class="modal">
   <g:form action="assignIssue" name="assignIssueForm" id="${issue.code}" class="form-stacked" style="padding-left: 0;">
      <div class="modal-header">
         <a href="#" class="close">×</a>
         <h3>Asignar Incidencia</h3>
      </div>
      <div class="modal-body">
         <div class="clearfix">
            <label for="assignee.id">Asignar a:</label>

            <div class="input"><g:select name="assignee.id" value="${issue.assignee?.id}"
                                         from="${issue.project.users.findAll{ it.enabled }.sort{ it.fullName }}"
                                         optionKey="id"
                                         optionValue="fullName" noSelection="${['':'Seleccione']}"/></div>
         </div>

         <div class="clearfix">
            <label for="assignComment">Comentario:</label>

            <div class="input"><g:textArea name="assignComment" class="xxlarge"/></div>
         </div>
      </div>
      <div class="modal-footer">
         <g:submitButton name="submit" value="Asignar" class="btn primary"/>
      </div>
   </g:form>
</div>

<div id="closeIssueDialog" style="display:none;" class="modal">
   <g:form action="closeIssue" name="closeIssueForm" id="${issue.code}" class="form-stacked" style="padding-left: 0;">
      <div class="modal-header">
         <a href="#" class="close">×</a>
         <h3>Cerrar Incidencia</h3>
      </div>
      <div class="modal-body">
         <div class="clearfix">
            <label for="closeComment">Comentario:</label>

            <div class="input"><g:textArea name="closeComment" style="width:500px;height:100px;"/></div>
         </div>
      </div>
      <div class="modal-footer">
         <g:submitButton name="submit" value="Cerrar" class="btn primary"/>
      </div>
   </g:form>
</div>

<div id="addAttachmentDialog" style="display:none;" class="modal">
   <g:uploadForm name="attachmentsForm" action="addAttachment" id="${issue.code}" class="form-stacked" style="padding-left: 0;">
      <div class="modal-header">
         <a href="#" class="close">×</a>
         <h3>Archivos adjuntos</h3>
      </div>
      <div class="modal-body">
         <table>
            <g:each in="${issue.attachments}" var="attachment">
               <tr>
                  <td><g:link action="showAttachment" id="${issue.id}" params="[attachmentId:attachment.id]"
                              target="_blank">${attachment.description ?: attachment.file}</g:link></td>
               </tr>
            </g:each>
         </table>
         <hr/>
         <h4>Agregar archivo adjunto</h4>

         <div class="clearfix">
            <label>Archivo:</label>
            <div class="input">
               <input type="file" name="file"/>
            </div>
         </div>

         <div class="clearfix">
            <label>Descripcion:</label>

            <div class="input">
               <g:textField name="description"/>
            </div>
         </div>
      </div>
      <div class="modal-footer">
         <g:submitButton name="submit" value="Adjuntar archivo" class="btn primary"/>
      </div>
   </g:uploadForm>
</div>

<div id="resolveIssueDialog" style="display:none;" class="modal">
   <g:form action="resolveIssue" id="${issue.code}" name="resolveIssueForm" class="form-stacked" style="padding-left: 0;">
      <div class="modal-header">
         <a href="#" class="close">×</a>
         <h3>Resolver incidencia</h3>
      </div>
      <div class="modal-body">
         <div class="clearfix">
            <label for="resolution">Resolucion:</label>

            <div class="input"><g:select name="resolution" from="${Resolution.list()}" optionKey="id" optionValue="name"
                                         noSelection="['':'Seleccione...']"/></div>
         </div>

         <div class="clearfix">
            <label for="notifyToText">Notificar a:</label>

            <div class="input">
               <g:textField type="text" name="notifyToText" value="" class="autocomplete" style="width:100%;"/>
               <g:hiddenField name="notifyTo"/>
               %{--<g:select name="notifyTo" from="${issue.project.users.findAll{ it.enabled && it.id != issue.reporter.id }.sort{ it.fullName }}" optionKey="id" optionValue="fullName" noSelection="['':'Seleccione...']"/>--}%
               <span class="help-inline">Si desea que alguien m&aacute;s, ademas de quien abrio la incidencia sea notificado.</span>
            </div>
         </div>

         <div class="clearfix">
            <label for="resolveComment">Comentario:</label>

            <div class="input"><g:textArea name="resolveComment" style="width:100%;height:100px;"/></div>
         </div>
      </div>
      <div class="modal-footer">
         <g:submitButton name="submit" value="Resolver" class="btn primary"/>
      </div>
   </g:form>
</div>

<script type="text/javascript">
   $(function() {
      if ($("#resolve")) {
         $("#resolveIssueDialog").modal({ keyboard: true, backdrop: true });

         $('#resolve').click(function() {
            $("#resolveIssueDialog").modal('show');
         });
      }

      if ($("#close")) {
         $("#closeIssueDialog").modal({ keyboard: true, backdrop: true });
         $('#closeIssueDialog').bind('shown', function(){ $('#closeComment').focus(); });
         $('#close').click(function(e) {
            $("#closeIssueDialog").modal('show');
         });
      }

      $("#assignIssueDialog").modal({ keyboard: true, backdrop: true });
      $('#assign').click(function () {
         $("#assignIssueDialog").modal('show');
      });

      $("#addAttachmentDialog").modal({ keyboard: true, backdrop: true });
      $('#attach').click(function () {
         $("#addAttachmentDialog").modal('show');
      });

      $('#edit').click(function () {
         document.location.href = '${createLink(action:'edit', id: issue.code)}';
      });
//    $("#back").styledButton({
//      'orientation' : 'alone',
//      'action' : function () { alert( 'omfg' ) }
//    });
//    $("#next").styledButton({
//      'orientation' : 'alone',
//      'action' : function () { alert( 'omfg' ) }
//    });

      $('#notifyToText')
            .bind("keydown", function(event) {
               if (event.keyCode === $.ui.keyCode.TAB &&
                     $(this).data("autocomplete").menu.active) {
                  event.preventDefault();
               }
            })
            .autocomplete({
               source: function(request, response) {
                  $.getJSON('${createLink(action:'users')}', {
                     term: extractLast(request.term)
                  }, response);
               },
               search: function() {
                  // custom minLength
                  var term = extractLast(this.value);
                  if (term.length < 2) {
                     return false;
                  }
               },
               focus: function() {
                  // prevent value inserted on focus
                  return false;
               },
               select: function(event, ui) {
                  var texts = split(this.value);
                  texts.pop();
                  texts.push(ui.item.label);
                  texts.push("");
                  this.value = texts.join(", ");

                  var ids = split($('#notifyTo').val());
                  ids.pop();
                  ids.push(ui.item.value);
                  ids.push("");
                  $('#notifyTo').val(ids.join(", "));

                  return false;
               }
            });

      var pomodoroRunning = false;
      var pomodoroSessionId;
      $('#pomodoro').click(function(e){
         e.preventDefault();
         if(!pomodoroRunning){
            pomodoroRunning = true;
            $.ajax({url: '${createLink(action:"startPomodoroSession", id: issue.code)}', dataType: 'json',
               success: function(data){
                  if(data.success){
                     pomodoroSessionId = data.pomodoroSessionId
                  }
               }
            });
            $('#pomodoro').html('Invalidar pomodoro');
            $("#pomodoroCountdown").css('display', '');
            $('#pomodoroCountdown').countdown({until: '+25m', format: 'YOWDHMS', significant: 2,
               onExpiry: function(){
                  pomodoroRunning = false;
                  $.ajax({url: '${createLink(action:"endPomodoroSession")}/' + pomodoroSessionId, dataType: 'json'});
                  $('#pomodoro').html('Iniciar pomodoro');
                  $('#successMessage').show();
                  setTimeout(function(){
                     $('#successMessage').fadeOut(2000);
                  }, 2000);
                  $('#pomodoroCountdown').countdown('destroy');
                  $("#pomodoroCountdown").css('display', 'none');
               }
            });
         }else{
            pomodoroRunning = false;
            $('#pomodoro').html('Iniciar pomodoro');
            $('#pomodoroCountdown').countdown('destroy');
            $("#pomodoroCountdown").css('display', 'none');
         }
      });
   });

   function extractLast(term) {
      return split(term).pop();
   }
   function split(val) {
      return val.split(/,\s*/);
   }
</script>

</body>
</html>