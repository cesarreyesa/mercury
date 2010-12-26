<%--
  Created by IntelliJ IDEA.
  User: cesarreyes
  Date: 25/12/10
  Time: 22:16
  To change this template use File | Settings | File Templates.
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
        <li class="first"><g:link controller="project">General</g:link></li>
        <li class="active"><g:link action="categories">Categorias</g:link></li>
        <li><g:link controller="project" action="users">Usuarios</g:link></li>
      </ul>
    </div>
    <div class="content">
      <div class="inner" style="padding-top:20px;">
        <table class="table">
          <tr>
            <td colspan="3" style="text-align:right;"><g:link elementId="addLink" url="#">Agregar</g:link></td>
          </tr>
          <tr id="addCategoryTr" style="display:none;">
            <td style="text-align:right;" colspan="3">
              <g:form action="addCategory" id="${project.id}">
                <g:textField name="name" />
                <g:submitButton name="save" value="Agregar categoria" />
              </g:form>
            </td>
          </tr>
          <tr>
            <th>Nombre</th>
            <th>&nbsp;</th>
          </tr>
          <g:each in="${categories}" var="category">
            <tr>
              <td>${category.name}</td>
              <td class="last"><a href="#">eliminar</a></td>
            </tr>
          </g:each>
        </table>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  $(function(){
    $('#addLink').click(function(){
      $('#addCategoryTr').toggle();
      return false;
    });
  });
</script>

</body>

</html>