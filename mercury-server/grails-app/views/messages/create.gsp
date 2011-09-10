<%--
  User: cesarreyes
  Date: 04/07/11
  Time: 22:54
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <title>Nuevo mensaje</title>
   <meta content="main" name="layout">
   <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/skins/simple', file: 'style.css')}"/>
   <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/sets/default', file: 'style.css')}"/>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.markitup.js')}"></script>
   <script type="text/javascript" src="${resource(dir: 'js/sets/default', file: 'set.js')}"></script>
</head>

<body>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'messages']"/>
</content>

<div class="content">
   <g:if test="${message.id}">
      <h2 class="title">Editar mensaje</h2>
   </g:if>
   <g:else>
      <h2 class="title">Nuevo mensaje</h2>
   </g:else>

   <g:form action="${message.id ? 'update' : 'save'}" name="issueForm" class="form-stacked">
      <g:hiddenField name="id" value="${message.id}"/>
      <g:hiddenField name="project.id" value="${project.id}"/>
      <g:hasErrors bean="${message}">
         <div class="errors">
            <g:renderErrors bean="${message}" as="list"/>
         </div>
      </g:hasErrors>
      <div class="clearfix">
         <label for="title">T&iacute;tulo:</label>
         <div class="input"><g:textField name="title" value="${message.title}"/></div>
      </div>

      <div class="clearfix">
         <label for="body">Mensaje:</label>
         <div class="input"><g:textArea name="body" value="${message.body}" style="height:100px;"/></div>
      </div>

      <div class="clearfix">
         <label for="followerRoles">Visible a:</label>
         <div class="input"><g:select name="followerRoles" from="${roles}" optionKey="id" optionValue="authority"
                   noSelection="['':'Seleccione...']"/></div>
      </div>

      <div class="actions">
         <button class="btn" type="submit">Guardar</button>
         <g:link action="index">cancelar</g:link>
      </div>
   </g:form>
</div>

<script type="text/javascript">
   $(function() {
      $('#body').markItUp(mySettings);
      $('#title').focus();
   });
</script>
</body>
</html>