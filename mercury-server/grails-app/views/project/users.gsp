<%--
  User: cesarreyes
  Date: 29/11/10
  Time: 21:55
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Usuarios del proyecto</title>
  <meta content="main" name="layout"/>
</head>
<body>

<content tag="navbar">
  <g:render template="/shared/menu" model="[selected:'main']"/>
</content>

<div id="main">
  <div class="block" id="block-tables">
    <div class="secondary-navigation">
      <ul class="wat-cf">
        <li class="first"><g:link>General</g:link></li>
        <li><g:link action="categories">Categorias</g:link></li>
        <li class="active"><g:link action="users">Usuarios</g:link></li>
      </ul>
    </div>
    <div class="content">
      <div class="inner" style="padding-top:20px;">
        <table class="table">
          <tr>
            <td colspan="3" style="text-align:right;"><g:link elementId="addLink" url="#">Agregar</g:link></td>
          </tr>
          <tr id="addUserTr" style="display:none;">
            <td style="text-align:right;" colspan="3">
              <g:form action="addUser" id="${project.id}">
                <g:select name="user.id" from="${usersNotInProject.sort{ it.fullName }}" optionKey="id" optionValue="fullName"
                        value="" noSelection="['': 'Seleccione...']"/>
                <g:submitButton name="add" value="Agregar usuario" />
              </g:form>
            </td>
          </tr>
          <tr>
            <th>Usuario</th>
            <th>Nombre</th>
            <th>&nbsp;</th>
          </tr>
          <g:each in="${project.users}" var="user">
            <tr>
              <td>${user.username}</td>
              <td>${user.fullName}</td>
              <td class="last"><a href="#" onclick="if(confirm('Esta seguro que desea eliminar al usuario del proyecto?')){ $('#userId').val('${user.id}'); $('#deleteUserForm').trigger('submit'); } return false;">eliminar</a></td>
            </tr>
          </g:each>
        </table>
      </div>
    </div>
  </div>
</div>

<g:form action="deleteUser" name="deleteUserForm" id="${project.id}">
  <g:hiddenField name="userId" />
</g:form>

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