<%--
  Created by IntelliJ IDEA.
  User: Gabriel
  Date: 28/11/10
  Time: 11:54 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>Entregas</title>
    <meta name="layout" content="main"/>
  </head>
  <body>
    <content tag="navbar">
      <g:render template="/shared/menu" model="[selected:'release']"/>
    </content>
    <div id="sidebar">
      <div class="block">
        <h3>Entregas</h3>
        <ul class="navigation">
          <g:each in="${milestones}" var="milestone">
            <li>
              <g:link action="index" params="${[id:milestone.id]}">${milestone.name}</g:link>
            </li>
          </g:each>
        </ul>
      </div>
    </div>


  </body>
</html>