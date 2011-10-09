<%--
  Created by IntelliJ IDEA.
  User: cesarreyes
  Date: 09/10/11
  Time: 17:42
  To change this template use File | Settings | File Templates.
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
      <h1>${filter.name}</h1>
      <a href="../../" data-icon="home" data-iconpos="notext" data-direction="reverse" class="ui-btn-right jqm-home">Home</a>
   </div><!-- /header -->

   <div data-role="content">
      <div class="content-primary">
         <ul data-role="listview">
            <g:each in="${issues}" var="issue">
               <li><g:link controller="mobile" action="issue">${issue.summary}</g:link></li>
            </g:each>
         </ul>
      </div><!--/content-primary -->

   </div><!-- /content -->

</div><!-- /page -->

</body>
</html>