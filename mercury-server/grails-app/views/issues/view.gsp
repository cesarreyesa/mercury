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

      <div class="issue-menu" style="margin-top:20px;">
         <g:if test="${!issue.resolution}">
            <button class="btn" id="resolve">Resolver</button>
         </g:if>
         <g:elseif test="${issue.status?.code != 'closed'}">
            <button class="btn" id="close">Cerrar</button>
         </g:elseif>
         <button class="btn" id="assign">Asignar</button>
         <button class="btn" id="attach">Archivos adjuntos (${issue.attachments.size()})</button>
         <button class="btn" id="edit">Editar</button>
         %{--<div style="float:right;">--}%
         %{--<span id="back"><<</span>--}%
         %{--<span id="next">>></span>--}%
         %{--</div>--}%
      </div>

      <div class="row">
         <div class="span12 columns">
            <div style="background-color: #eee;padding: 4px;margin-top:10px;margin-bottom:10px;">
               <div style="background-color: #fff;border: 1px solid #aaa;padding: 4px;">
                  <span style="font-size: 88%;">
                     abierta por <strong>${issue.reporter.fullName}</strong> el <g:formatDate date="${issue.date}" format="MMM dd, yyyy"/></span>
                  <h2>${issue.code} ${issue.summary}</h2>

                  <span style="font-size: 88%;">
                     asignado a <strong>${issue.assignee.fullName}</strong>
                  </span>
                  %{--<div style="border: 1px solid #aaa;background-color: #efefef;padding-left: 5px;padding-right: 5px;padding-top: 8px;padding-bottom: 8px;">--}%

                  %{--</div>--}%
                  <div style="margin-bottom:20px;">
                     <p><g:markdownToHtml>${issue.description}</g:markdownToHtml></p>
                  </div>
               </div>
            </div>

            <div style="background-color:#F9F9FA;border: 1px solid #ccc;padding:5px;">
               <h4>Historia (${logs.size()})</h4>

               <div id="logs" style="font-size:x-small;">
                  <g:each in="${logs}" var="log">
                     <div class="comment" style="margin: 10px;5px;">
                        <div class="comment-user"
                             style="padding:4px;background-color:#F0F1F2;border-bottom: 1px solid #D4D5D6;">
                           ${log.user.fullName} ${log.date}
                        </div>
                        <g:if test="${log.changes}">
                           <ul>
                              <g:each in="${log.changes}" var="change">
                                 <g:set var="property" value="issue.${change.property}"/>
                                 <li><strong>${change.property}</strong> cambiado de <em>${change.originalValue}</em> a <em>${change.newValue}</em>
                                 </li>
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
                  <g:form action="addComment" id="${issue.code}" class="form-stacked">
                     <div class="clearfix">
                        <label>Agregar comentario</label>
                        <div class="input">
                           <g:textArea name="comment" rows="2" cols="30" style="width:100%;border: 2px solid #ccc;"/>
                        </div>
                     </div>
                     <div >
                        <g:submitButton class="btn" name="addComment" value="Agregar comentario"/>
                     </div>
                  </g:form>
               </div>
            </div>
         </div>
         <div class="span4 columns">
            <table style="width:100%;">
               <g:if test="${issue.parent}">
                  <tr>
                     <td>Padre</td>
                     <td><g:link controller="issues" action="view"
                                 id="${issue.parent?.id}">${issue.parent.code}</g:link></td>
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
            </table>

         </div>
      </div>

   </div>

<div id="assignIssueDialog" style="display:none;">
   <h1>Asignar Incidencia</h1>
   <g:form action="assignIssue" name="assignIssueForm" id="${issue.code}" class="form-stacked">
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
   </g:form>
</div>

<div id="closeIssueDialog" style="display:none;">
   <h1>Cerrar Incidencia</h1>
   <g:form action="closeIssue" name="closeIssueForm" id="${issue.code}" class="form-stacked">
      <div class="clearfix">
         <label for="closeComment">Comentario:</label>

         <div class="input"><g:textArea name="closeComment" style="width:500px;height:100px;"/></div>
      </div>
   </g:form>
</div>

<div id="addAttachmentDialog" style="display:none;">
   <h1>Archivos adjuntos</h1>
   <table>
      <g:each in="${issue.attachments}" var="attachment">
         <tr>
            <td><g:link action="showAttachment" id="${issue.id}" params="[attachmentId:attachment.id]"
                        target="_blank">${attachment.description ?: attachment.file}</g:link></td>
         </tr>
      </g:each>
   </table>
   <hr/>
   <g:uploadForm name="attachmentsForm" action="addAttachment" id="${issue.code}" class="form-stacked">
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

   </g:uploadForm>
</div>
</div>

<div id="resolveIssueDialog" style="display:none;">
   <h1>Resolver incidencia</h1>
   <g:form action="resolveIssue" id="${issue.code}" name="resolveIssueForm" class="form-stacked">
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
   </g:form>
</div>

<script type="text/javascript">
   $(function() {
      if ($("#resolve")) {
         $('#resolve').click(function(e) {
            var position = $(this).position();
            $("#resolveIssueDialog").dialog2({
               width:550, modal: true, position: [position.left, position.top + $(this).height()],
               buttons:{
                  "Resolver":function() {
                     $('#resolveIssueForm').submit();
                  }
               }
            });
         });
      }

      if ($("#close")) {
         $('#close').click(function(e) {
            var position = $(this).position();
            $("#closeIssueDialog").dialog({
               width:550, modal: true, position: [position.left, position.top + $(this).height()],
               buttons:{
                  "Cerrar":function() {
                     $('#closeIssueForm').submit();
                  }
               }
            });
         });
      }

      $('#assign').click(function () {
         var position = $(this).position();
         $("#assignIssueDialog").dialog2({
            width:550, modal: true, position: [position.left, position.top + $(this).height()],
            buttons:{
               "Asignar": function() {
                  $('#assignIssueForm').submit();
               }
            }
         });
      });
      $('#attach').click(function () {
         var position = $(this).position();
         $("#addAttachmentDialog").dialog2({
            width:550, modal: true, position: [position.left, position.top + $(this).height()],
            buttons:{
               "Adjuntar archivo":function() {
                  $('#attachmentsForm').submit();
               }
            }
         });
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