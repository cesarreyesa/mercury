<%--
  Created by IntelliJ IDEA.
  User: cesarreyes
  Date: 25/11/10
  Time: 20:12
  To change this template use File | Settings | File Templates.
--%>

<!DOCTYPE html>
<html lang="en">
<head>
   <title>${message(code: 'application.name')}</title>
   <meta name="layout" content="public">
</head>

<body>

<div id="box">
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