<%--
  User: cesarreyes
  Date: 01/12/10
  Time: 22:24
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <title>Editar permisos</title>
   <meta content="main" name="layout"/>
</head>

<body>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'main']"/>
</content>

<ul class="nav nav-tabs">
   <li><g:link action="editUser" id="${user.id}">Editar</g:link></li>
   <li class="active"><g:link action="editRoles" id="${user.id}">Permisos</g:link></li>
</ul>

<div class="content">
   <h2 class="title">Permisos</h2>

   <div class="inner">
      <table class="table" style="width:300px;">
         <tr>
            <td colspan="2" style="text-align:right;"><g:link elementId="addLink" url="#">Agregar</g:link></td>
         </tr>
         <tr id="addRoleTr" style="display:none;">
            <td style="text-align:right;" colspan="3">
               <g:form action="addRole" id="${user.id}">
                  <g:select name="roleId" from="${roles}" optionKey="authority" optionValue="authority"
                            noSelection="['': 'Seleccione...']"/>
                  <g:submitButton name="add" value="Agregar permiso"/>
               </g:form>
            </td>
         </tr>

         <g:each in="${user.authorities}" var="authority">
            <tr>
               <td>${authority.authority}</td>
               <td class="last"><a href="#" onclick="if (confirm('Esta seguro que desea eliminar el permiso?')) {
                  $('#role').val('${authority.authority}');
                  $('#deleteRoleForm').trigger('submit');
               }
               return false;">eliminar</a></td>
            </tr>
         </g:each>
      </table>
   </div>
</div>

<g:form action="deleteRole" name="deleteRoleForm" id="${user.id}">
   <g:hiddenField name="role"/>
</g:form>

<script type="text/javascript">
   $(function() {
      $('#addLink').click(function() {
         $('#addRoleTr').toggle();
         return false;
      });
   });
</script>

</body>
</html>