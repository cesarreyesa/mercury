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
</head>

<body>

<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'messages']"/>
</content>
<div id="main">
   <div class="block" id="block-text">
      <div class="content">
         <h2 class="title">
            Mensajes
            <span style="padding-right:20px;float:right;font-size:small;font-weight:normal;">
               <g:link action="create">[+] nuevo mensaje</g:link>
            </span>
         </h2>
         <div class="inner">
            <g:each in="${messages}" var="message">
               <br/>
               <span><g:formatDate date="${message.dateCreated}" format="E, dd MMM"/></span>
               <hr/>
               <h3><strong>${message.title}</strong></h3>
               <p>${message.body}</p>
               <p>Created by ${message.user.fullName}</p>
               <br/>
            </g:each>
          </div>
       </div>
    </div>
 </div>

<div id="sidebar">
   <div class="block">
      <h3>Categorias</h3>
      <ul class="navigation">
      </ul>
   </div>
</div>

</body>
</html>