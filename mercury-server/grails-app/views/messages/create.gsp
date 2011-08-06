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
   <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/skins/simple', file: 'style.css')}" />
   <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/sets/default', file: 'style.css')}" />
   <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.markitup.js')}"></script>
   <script type="text/javascript" src="${resource(dir: 'js/sets/default', file: 'set.js')}"></script>
</head>

<body>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'messages']"/>
</content>

<div id="main">
   <div class="block" id="block-text">
      <div class="content">
         <g:if test="${message.id}">
            <h2 class="title">Editar mensaje</h2>
         </g:if>
         <g:else>
            <h2 class="title">Nuevo mensaje</h2>
         </g:else>

         <div class="inner">
            <g:form action="${message.id ? 'update' : 'save'}" name="issueForm" class="form">
               <g:hiddenField name="id" value="${message.id}"/>
               <g:hiddenField name="project.id" value="${project.id}"/>
               <g:hasErrors bean="${message}">
                  <div class="errors">
                     <g:renderErrors bean="${message}" as="list"/>
                  </div>
               </g:hasErrors>
               <div class="group">
                 <label for="title" class="label">T&iacute;tulo:</label>
                 <g:textField name="title" value="${message.title}" class="text_field"/>
               </div>
               <div class="group">
                 <label class="label">Mensaje:</label>
                 <g:textArea name="body" value="${message.body}" style="height:100px;" class="text_area"/>
               </div>

               <div class="group">
                  <label class="label">Visible a:</label>
                  <g:select name="followerRoles" from="${roles}" optionKey="id" optionValue="authority" noSelection="['':'Seleccione...']"/>
               </div>

               <div class="group navform wat-cf">
                 <button class="button" type="submit">
                   <img src="${resource(dir:'images/icons', file:'tick.png')}" alt="Guardar" /> Guardar
                 </button>
                 <g:link action="index" class="button"><img src="${resource(dir:'images/icons', file:'cross.png')}" alt="Cancel"/> Cancelar</g:link>
               </div>
            </g:form>
         </div>
      </div>
   </div>
</div>

<script type="text/javascript">
   $(function(){
      $('#body').markItUp(mySettings);
      $('#title').focus();
   });
</script>
</body>
</html>