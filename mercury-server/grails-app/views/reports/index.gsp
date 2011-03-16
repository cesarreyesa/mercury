<%--
  User: cesarreyes
  Date: 13/03/11
  Time: 22:48
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <title>Reportes</title>
   <meta content="main" name="layout"/>
</head>
<body>
<content tag="navbar">
   <g:render template="/shared/menu" model="[selected:'reports']"/>
</content>

<div id="main">
   <div class="block" id="block-tables">
      <div class="content">
         <h2 class="title">Reportes</h2>
         <div class="inner">
            <ul>
               <li><g:link action="issues">Incidencias</g:link></li>
            </ul>
         </div>
      </div>
   </div>
</div>
</body>
</html>