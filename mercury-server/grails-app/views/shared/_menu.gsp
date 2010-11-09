<%--
  User: cesarreyesa
  Date: 28-feb-2010
  Time: 12:43:56
--%>

<g:if test="${session.project}">
  <li <g:if test="${selected == 'main'}">class="selected"</g:if>>
    <g:link controller="home">${session.project.name}</g:link></li>

  <li <g:if test="${selected == 'issues'}">class="selected"</g:if>>
    <g:link controller="issues">Incidencias</g:link></li>

  <li <g:if test="${selected == 'new'}">class="selected"</g:if>>
    <g:link controller="issues" action="create">Nueva Incidencia</g:link></li>

  <li <g:if test="${selected == 'release'}">class="selected"</g:if>>
    <a href='${ctx}/project'>Entregas</a></li>

  <li style="float:right;padding:3px;">
    <form action="${ctx}/issues/">
      <input class="searchBox" type="text" id="query" name="query" title="Enter a query and press enter to jump" value="${searchValue}"
              onfocus="if (this.value == 'Buscar') {
                this.value = '';
              }" onblur="if (this.value == '') {
        this.value = 'Buscar';
      }"/>
      <%--<input class="searchSubmit" type="submit" value="Buscar">--%>
    </form>
  </li>
</g:if>
<g:else>

</g:else>

