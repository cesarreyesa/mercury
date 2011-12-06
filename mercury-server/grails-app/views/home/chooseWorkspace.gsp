<%--
  User: cesarreyesa
  Date: 28-feb-2010
  Time: 21:33:01
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/shared/taglibs.jsp" %>
<html>
<head>
   <title>Escoge un proyecto</title>
   <meta name="layout" content="${layout ?: 'main'}"/>
</head>

<body>
<content tag="navbar">
   <g:render template="/shared/menu"/>
</content>

<div class="content">
   <h2 class="title">Seleccione un workspace</h2>

   <div class="inner">
      <g:form action="changeWorkspace" class="form">
         <table>
            <tr>
               <td><g:select from="${workspaces}" name="workspace" optionKey="id" optionValue="name" noSelection="${['':'Seleccione...']}"/></td>
            </tr>
         </table>
         <div class="actions">
            <g:submitButton class="btn primary" name="changeWorkspace" value="Aceptar"/>
         </div>
      </g:form>
   </div>
</div>

</body>
</html>

