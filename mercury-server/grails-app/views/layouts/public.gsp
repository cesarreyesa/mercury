<%--
  User: cesarreyes
  Date: 18/12/11
  Time: 10:42
--%>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="utf-8">
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   <title><g:layoutTitle default="${message(code:'application.name')}"/> :: ${message(code:'application.name')}</title>

   <link rel="Shortcut Icon" href="${resource(dir: 'images', file: 'favicon.ico')}">

   <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css"/>
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}" type="text/css" media="screen"/>

   <script type="text/javascript" src="${resource(dir: 'js', file: 'global.js')}"></script>

   <g:layoutHead/>
</head>

<body>

<div class="navbar navbar-fixed-top">
   <div class="navbar-inner">
      <div class="container">
         <g:link controller="home" class="brand">${message(code: 'application.name')}</g:link>
      </div>
   </div>
</div>

<div class="container" style="margin-top: 50px;">
   <g:layoutBody/>
</div>

<div class="container">
   <div class="footer" style="margin-top: 30px;">
      <hr/>
      <p>
         <a href="https://github.com/cesarreyesa/mercury"
            target="_blank">${message(code:'application.name')}</a> version 1.1.0
      </p>
   </div>
</div>

</body>
</html>

