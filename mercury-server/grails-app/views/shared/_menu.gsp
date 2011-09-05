<%--
  User: cesarreyesa
  Date: 28-feb-2010
  Time: 12:43:56
--%>

<g:if test="${session.project}">
  <li class="first <g:if test="${selected == 'main'}">active"</g:if><g:else>"</g:else>>
    <g:link controller="home">${session.project.name}</g:link></li>

  <li <g:if test="${selected == 'issues'}">class="active"</g:if>>
    <g:link controller="issues">Incidencias</g:link></li>

   <li <g:if test="${selected == 'messages'}">class="active"</g:if>>
     <g:link controller="messages">Mensajes</g:link></li>

  <li <g:if test="${selected == 'release'}">class="active"</g:if>>
    <g:link controller="milestone" action="index">Entregas</g:link></li>

  <li <g:if test="${selected == 'reports'}">class="active"</g:if>>
    <g:link controller="reports" action="index">Reportes</g:link></li>
</g:if>
<g:else>

</g:else>

