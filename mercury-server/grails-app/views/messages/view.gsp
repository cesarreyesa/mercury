<%--
  User: cesarreyes
  Date: 10/07/11
  Time: 13:15
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <title>${message.title}</title>
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

<div class="content">

   <h2><strong>${message.title}</strong> <g:link action="edit" id="${message.id}" style="font-size: small;font-weight: normal;text-decoration: underline;">editar</g:link></h2>
   <div class="inner">
      <span><g:formatDate date="${message.dateCreated}" format="E, dd MMM"/></span> :: <span>Created by ${message.user.fullName}</span>
      <hr/>
      <g:markdownToHtml>${message.body}</g:markdownToHtml>
      <g:render template="/shared/comments" model="[conversation: message.conversation, controller:'messages']"/>
   </div>

</div>

<script type="text/javascript">
</script>

</body>
</html>