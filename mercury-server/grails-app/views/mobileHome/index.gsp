<%--
  User: cesarreyes
  Date: 08/10/11
  Time: 13:34
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
   <meta name="layout" content="iphone"/>
   <title>Nectar</title>
</head>

<body>
<div data-role="page" class="type-interior">
   <div data-role="header" data-theme="f">
      <h1>Proyectos</h1>
      <a href="../../" data-icon="home" data-iconpos="notext" data-direction="reverse" class="ui-btn-right jqm-home">Home</a>
   </div><!-- /header -->

   <div data-role="content">
      <div class="content-primary">
         <ul data-role="listview">
            <g:each in="${projects}" var="project">
               <li><g:link>${project.name}</g:link></li>
            </g:each>
         </ul>
      </div><!--/content-primary -->

   </div><!-- /content -->

</div><!-- /page -->

</body>
</html>