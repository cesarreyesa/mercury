<%--
  Created by IntelliJ IDEA.
  User: cesarreyesa
  Date: 28-feb-2010
  Time: 21:33:01
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/shared/taglibs.jsp" %>
<html>
<head>
  <title>Escoge un proyecto</title>
  <meta name="layout" content="main"/>
</head>
<body>
<content tag="navbar">
  <g:render template="/shared/menu"/>
</content>

<g:form action="changeProject" class="form">
  <h1>Seleccione un proyecto</h1>
  <table>
    <tr>
      <td><g:select from="${projects}" name="project" optionKey="id" optionValue="name" noSelection="${['':'Seleccione...']}"/></td>
    </tr>
    <tr class="buttons">
      <td>
        <g:submitButton name="changeProject" value="Aceptar"/>
      </td>
    </tr>
  </table>
</g:form>

</body>
</html>

