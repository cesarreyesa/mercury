<%--
  User: cesarreyes
  Date: 04/03/12
  Time: 11:05
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8" />
   <meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
   <title>
   </title>
   <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0.1/jquery.mobile-1.0.1.min.css" />
   <style>
      /* App custom styles */
   </style>
   <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js">
   </script>
   <script src="http://code.jquery.com/mobile/1.0.1/jquery.mobile-1.0.1.min.js">
   </script>
</head>
<body>
<div data-role="page" id="page1">
   <div data-theme="a" data-role="header">
      <h2>
         ${issue.summary}
      </h2>
   </div>
   <div data-role="content">
      <p>
         Abierta por <strong>${issue.reporter.fullName}</strong> el <g:formatDate date="${issue.date}" format="MMM dd, yyyy"/>
      </p>
      <p>
         Estado: <g:message code="status.${issue.status.code}"/>
      </p>
      <p>
         Asignado a <a href="#" id="assign">${issue.assignee ? issue.assignee?.fullName : 'nadie'}</a>
      </p>
      <p>
         <h3>Descripcion:</h3>
         <g:markdownToHtml>${issue.description}</g:markdownToHtml>
      </p>
      <div data-role="collapsible-set" data-theme="" data-content-theme="">
         <div data-role="collapsible" data-collapsed="true">
            <h3>
               Detalles
            </h3>
            <g:if test="${issue.parent}">
               <p>
                  Padre: <g:link controller="issues" action="view" id="${issue.parent?.id}">${issue.parent.code}</g:link>
               </p>
            </g:if>
            <p>
               Entrega: <g:link controller="milestone" action="index"
                           id="${issue.milestone?.id}">${issue.milestone ? issue.milestone.name : "Sin asignar"}</g:link>
            </p>
            <p>
               Fecha de inicio: <g:formatDate date="${issue.startDate}" format="EEE, dd MMM yyyy, HH:mm"/>
            </p>
            <p>
               Tipo: ${issue.issueType.name}
            </p>
            <p>
               Prioidad: ${issue.priority.name}
            </p>
            <p>
               Categoria: ${issue.category?.name}
            </p>
            <p>
               Dependiente:
                  <g:if test="${isseueDependsOn}">
                     <g:each in="${isseueDependsOn.dependsOn}" var="d">
                        <g:link action="view" id="${d.id}">${d.code}</g:link>
                     </g:each>
                     <a href="#" id="dependsOnLinkMore">Agregar mas</a>
                  </g:if>
                  <g:else>
                     <a href="#" id="dependsOnLink">Ninguna</a>
                  </g:else>
            </p>
            <p>
               Subscriptores
                  <ul>
                     <g:each in="${issue.watchers}" var="watcher">
                        <li>${watcher.fullName}</li>
                     </g:each>
                  </ul>
            </p>
            <p>
               Pomodoros: ${pomodoros}
            </p>
         </div>
         <div data-role="collapsible" data-collapsed="true">
            <h3>
               Comentarios (2)
            </h3>
            <p>
               Comentario 1 asndaksd aksdhaks d
               asdjkasd alsdkj alsdkas
               dasdjkasdl asd
            </p>
            <p>
               Comentario 2 askdj asdjlaskd lkas dlasdksj das'dadas
               dsdlks cs;dls csdc
               sdcskdcsdc
            </p>
         </div>
      </div>
      <div data-role="navbar" data-iconpos="top">
         <ul>
            <li>
               <a href="#page1" data-theme="e" data-icon="">
                  Cerrar
               </a>
            </li>
            <li>
               <a href="#page1" data-theme="" data-icon="">
                  Asignar
               </a>
            </li>
            <li>
               <a href="#page1" data-theme="" data-icon="">
                  Comentar
               </a>
            </li>
         </ul>
      </div>
   </div>
</div>
<script>
   //App custom javascript
</script>
</body>
</html>