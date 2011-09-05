<%--
  User: cesarreyes
  Date: 04/07/11
  Time: 22:49
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <title>Mensajes</title>
   <meta content="main" name="layout">
   <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/skins/simple', file: 'style.css')}"/>
   <link rel="stylesheet" type="text/css" href="${resource(dir: 'js/sets/default', file: 'style.css')}"/>
   <script type="text/javascript" src="${resource(dir: 'js', file: 'jquery.markitup.js')}"></script>
   <script type="text/javascript" src="${resource(dir: 'js/sets/default', file: 'set.js')}"></script>
</head>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'messages']"/>
</content>

<body>

<div class="row">
   <div class="span12 columns">
      <h2 class="title">
         Mensajes
         <span style="padding-right:20px;float:right;font-size:small;font-weight:normal;">
            <g:link action="create">[+] nuevo mensaje</g:link>
         </span>
      </h2>

      <div class="inner">
         <g:each in="${messages}" var="message">
            <br/>

            <h3><strong><g:link action="view" id="${message.id}">${message.title}</g:link></strong></h3>
            <span><g:formatDate date="${message.dateCreated}"
                                format="E, dd MMM"/></span> :: <span>Created by ${message.user.fullName}</span>
            <hr/>

            <p><g:markdownToHtml>${message.body}</g:markdownToHtml></p>

            <g:render template="/shared/comments" model="[conversation: message.conversation, controller:'messages']"/>
         </g:each>
      </div>
   </div>

   <div class="span4 columns">
      <div class="block">
         <h3>Categorias</h3>
         <ul class="navigation">
         </ul>
      </div>
   </div>
</div>

</body>
</html>