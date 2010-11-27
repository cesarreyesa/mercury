<%--
  User: cesarreyes
  Date: 24/11/10
  Time: 22:20
--%>

<g:if test="${session.project}">
  <li <g:if test="${selected == 'main'}">class="selected"</g:if>>
    <g:link controller="home">${session.project.name}</g:link></li>

  <li class="selected">
    <g:link controller="issues">Perfil</g:link></li>

</g:if>

