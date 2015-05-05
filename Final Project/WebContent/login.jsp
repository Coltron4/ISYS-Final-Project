<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Login Page</title>

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
	
	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <!-- Include our own Stylesheet -->
    <link href="style/signin.css" rel="stylesheet" type="text/css">
  </head>

  <body>
  
	<div class="container">

      <form action="LoginForm.jsp" method="post" class="form-signin">
    	<h2 class="form-signin-heading">Please sign in</h2>
		<label for="username">Username: </label>
		<input type="text" name="username" class="form-control"/>
		<label for="password">Password: </label>
		<input type="password" name="password" class="form-control"/>
		<button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
	    <p>Don't have an account? Register <a href="signup.jsp">here</a>.</p>
	  </form>

    </div> <!-- /container -->
	
  </body>
</html>
