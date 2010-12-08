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

  <li <g:if test="${selected == 'new'}">class="active"</g:if>>
    <g:link controller="issues" action="create">Nueva Incidencia</g:link></li>

  <li <g:if test="${selected == 'release'}">class="active"</g:if>>
    <g:link controller="milestone" action="index">Entregas</g:link></li>
  %{--<li style="float:right;padding:3px;">--}%
    %{--<g:form controller="issues">--}%
      %{--<g:textField class="searchBox" type="text" id="query" name="query" title="Enter a query and press enter to jump" value="${params.query ?: 'Buscar'}"--}%
              %{--onfocus="if (this.value == 'Buscar') {--}%
                %{--this.value = '';--}%
              %{--}" onblur="if (this.value == '') {--}%
        %{--this.value = 'Buscar';--}%
      %{--}"/>--}%
    %{--</g:form>--}%
  %{--</li>--}%
</g:if>
<g:else>

</g:else>

