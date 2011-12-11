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
      <table class="table">
         <tr>
            <td colspan="3" style="text-align:right;"><g:link elementId="addLink" url="#">Agregar</g:link></td>
         </tr>
         <tr id="addUserTr" style="display:none;">
            <td style="text-align:right;" colspan="3">
               <g:form action="addUser" id="${workspace.id}">
                  <g:textField name="userEmail" placeholder="email"/>
                  <g:submitButton name="add" class="btn" value="Agregar usuario"/>
               </g:form>
            </td>
         </tr>
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

<script type="text/javascript">
   $(function(){
      $('#addLink').click(function(){
         $('#addUserTr').toggle();
         return false;
      });
   });
</script>

</body>
</html>