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

<content tag="navbar">
   <g:render template="/shared/menu"/>
</content>

<body>

<div class="content">
   <g:if test="${workspaces}">
      <h2>Seleccione un workspace</h2>
      <g:form action="changeWorkspace" class="form">
         <table>
            <tr>
               <td><g:select from="${workspaces}" name="workspace" optionKey="id" optionValue="name" noSelection="${['':'Seleccione...']}"/></td>
            </tr>
         </table>
         <div class="actions">
            <g:submitButton class="btn btn-primary" name="changeWorkspace" value="Aceptar"/>
         </div>
      </g:form>
   </g:if>
   <g:else>
      <div class="alert">
         No perteneces a ningun workspace, puedes crear uno <a href="#" id="noWorkspacesCreateLink">aqu&iacute;</a>
      </div>
   </g:else>
</div>

<script type="text/javascript">
   $('#noWorkspacesCreateLink').click(function (e) {
      e.preventDefault();
      $("#newWorkspaceDialog").modal('show');
   });

</script>
</body>
</html>

