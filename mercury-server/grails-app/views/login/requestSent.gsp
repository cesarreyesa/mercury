<%--
  Created by IntelliJ IDEA.
  User: cesarreyes
  Date: 25/11/10
  Time: 20:12
  To change this template use File | Settings | File Templates.
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Mercury</title>
  <link rel="stylesheet" href="${resource(dir:'css', file:'base.css')}" type="text/css" media="screen" />
  <link rel="stylesheet" href="${resource(dir:'css/themes/drastic-dark', file:'styles.css')}" type="text/css" media="screen" />

  <script type="text/javascript" src="${resource(dir: 'js', file: 'global.js')}"></script>
</head>
<body>

<div id="box">
  <h1>Mercury</h1>
  <p>Bug tracking, issue tracking and project management software.</p>
  <div class="block" id="block-login">
    <h2>Recuperar contrase&ntilde;a</h2>
    <div class="content login">
      <p>We've sent an email to ${flash.email} containing a temporary url that will allow you to reset your password for the next 24 hours. Please check your spam folder if the email doesn't appear within a few minutes.</p>
    </div>
  </div>
</div>

<script type="text/javascript">
  document.getElementById("email").focus();
</script>

</body>
</html>