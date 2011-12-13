<%--
  User: cesarreyes
  Date: 10/12/11
  Time: 23:40
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <meta content="main" name="layout">
   <title>Usuarios</title>
</head>

<body>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'main']"/>
</content>

<ul class="tabs">
   <li><g:link>General</g:link></li>
   <li class="active"><g:link action="users">Usuarios</g:link></li>
</ul>

<div class="content">
   <div class="inner" style="padding-top:20px;">
      <g:link elementId="addLink" url="#">Agregar</g:link>
      <table class="table">
         <tr>
            <th>Usuario</th>
            <th>Nombre</th>
            <th>&nbsp;</th>
         </tr>
         <g:each in="${workspace.users}" var="user">
            <tr>
               <td>${user.username}</td>
               <td>${user.fullName}</td>
               <td class="last"><a href="#"
                                   onclick="if (confirm('Esta seguro que desea eliminar al usuario del workspace?')) {
                                      $('#userId').val('${user.id}');
                                      $('#deleteUserForm').trigger('submit');
                                   }
                                   return false;">eliminar</a></td>
            </tr>
         </g:each>
      </table>
   </div>
</div>

<div id="addUserDialog" style="display:none;" class="modal">
   <g:form action="addUser" id="${workspace.id}">
      <div class="modal-header">
         <h2>Invitar usuario</h2>
      </div>
      <div class="modal-body">
         <g:textField name="userEmail" placeholder="email"/>
      </div>
      <div class="modal-footer">
         <g:submitButton name="add" class="btn primary" value="Agregar usuario"/>
      </div>
   </g:form>
</div>

<script type="text/javascript">
   $(function(){
      $("#addUserDialog").modal({ keyboard: true, backdrop: true });

      $('#addLink').click(function(){
         $("#addUserDialog").modal('show');
      });
   });
</script>

</body>
</html>