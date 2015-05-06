<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"  %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="edu.uark.isys.Post" %>

<%
	//Check to see if logged in
	String username = (String)session.getAttribute("username");
	if(username == null || username == "") {
		%><script>location.replace("login.jsp");</script><%
	}
	String userQuery = request.getParameter("userQuery");
	Boolean queryDatabase = true;
	if(userQuery == null || username == "") {
		queryDatabase = false;
	}
%>
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

    <title>User Search</title>

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
    <link href="style/style.css" rel="stylesheet" type="text/css">
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Gabber</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <form class="navbar-form navbar-right" action="logout.jsp">
            <div class="form-group">
              <label class="label label-default" for="logout">Logged in as <%=username %></label>
            </div>
            <button name="logout" type="submit" class="btn btn-success">Logout</button>
          </form>
        </div><!--/.navbar-collapse -->
      </div>
    </nav>

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron">
      <div class="container">
        <h1>User Search</h1>
        <p>This page provides a search bar for users. Simply type in a username to find in the
         search bar below, and any that match will be returned. From there you can click on the
         'follow' button to start following that user. Afterwards you'll see their posts on your
         home page. When you're finished, click the button below to be returned to your home
         page.</p>
         <!-- TODO: Adjust button below so that it redirects to findUsers.jsp -->
        <p><a class="btn btn-primary btn-lg" href="home.jsp" role="button">Return Home &raquo;</a></p>
      </div>
    </div>
    
    <div class="container">
	  <p>Find a User!</p>
	  <!-- TODO: Have form submit message to database -->
	  <form action="" method="post" role="form">
	    <div class="form-group">
	      <input type="text" class="form-control" id="userQuery" name="userQuery" <%if(queryDatabase == true) { out.println("value='"+userQuery+"'"); }%>>
	      <button class="btn btn-success" type="submit">Search</button>
	    </div>
	  </form>
	</div>

	<!-- Get users -->
	<%

	//If query was valid then perform
	//NOTICE: Still need to replace post query with username query
	if(queryDatabase == true) {
	
	//Retrieve posts from DB2
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String search_result = null;
	ArrayList<String> following_users = null;
	
	String search_sql = "SELECT * FROM MAKS202.SOCIAL_USERS WHERE USERNAME = ?";
	String following_sql = "SELECT * FROM MAKS202.SOCIAL_FOLLOWINGS WHERE USERNAME = ?";
	String user = "maks202";
	String password = "axle088";
	String url = "jdbc:db2://130.184.26.148:446/ZUAF";
	
	try {
		Class.forName("com.ibm.db2.jcc.DB2Driver");
	} catch (Exception ex) {
		ex.printStackTrace();
		out.write("Error connecting to DB2... :( " );
	}
	
	try {
		con = DriverManager.getConnection(url, user, password);
		
		// Get user searched for
		pstmt  = con.prepareStatement(search_sql);
		pstmt.setString(1, userQuery);		
		rs = pstmt.executeQuery();
		
		if ( rs != null ) {
			if (rs.next()) {
				search_result = rs.getString(1);
			}
		}
		
		out.println("<p>User found: " + search_result + "</p>");
		
		// Retrieve  people followed
		following_users = new ArrayList<String>();
		
		pstmt  = con.prepareStatement(following_sql);
		pstmt.setString(1, username);
		rs = pstmt.executeQuery();
		
		if ( rs != null ) {
			if (rs.next()) {
				following_users.add(rs.getString(2));
			}
		}
		
		out.println("<p>Following Users size: " + following_users.size() + "</p>");
		
		con.close();
		
	} catch(Exception ex) {
		ex.printStackTrace();
		out.write("Error doing something in DB2... :( " );
	}
%>

    <div class="container">
    <div class="row">
        <div class="col-md-8 blog-main">
   		<%
   		if(search_result != null && !search_result.equals(username)) {
			out.println("<div class=\"blog-post\">");
			out.println("<p class=\"blog-post-meta\">");
			out.println(search_result + "</p>");
			
			//Follow button or not
			if(following_users.contains(search_result)) {
				//Label shows user is already followed
				out.println("<p><span class='label label-success'>Following <span class='glyphicon glyphicon-ok'></span></span></p>");
			} else {
				//Button allows user to be followed
				out.println("<form action='followUser.jsp' method='post' role='form'><div class='form-group'><input type='hidden' name='followName' value='"+userQuery+"'/><button class='btn btn-lg btn-primary' type='submit'>Follow <span class='glyphicon glyphicon-user'></span></button></div></form>");
			}
   		} else {
   			out.println("<p>No results found. Try a different search query.");
   		}
 
   		out.println("<p>User Query is: " + userQuery + "</p>");
	} else {
		//If a query wasn't present, then don't display users (cuz there aren't any!)
		out.println("<p>No search query present. Type in a username to find a user!</p>");
	}
   	
   		%>
   		</div>
   	</div>
      <!-- Example row of columns
      <div class="row">
        <div class="col-md-8 blog-main">

          <div class="blog-post">
            <p class="blog-post-meta">May 1, 2015 by <a href="#">You</a></p>

            <p>Gah I just want to start my job already!</p>
          </div><!-- /.blog-post - ->

          <div class="blog-post">
            <p class="blog-post-meta">April 28, 2015 by <a href="#">johnDeere</a></p>

            <p>Imma mow you real good...</p>
          </div><!-- /.blog-post - ->

        </div><!-- /.blog-main - ->
	  </div><!-- /row - ->
	</div><!-- /container -->
    <hr>

    <footer class="blog-footer">
      <p>&copy; Colton & Jarrett Inc. 2015</p>
    </footer>


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    
    <!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  </body>
</html>
