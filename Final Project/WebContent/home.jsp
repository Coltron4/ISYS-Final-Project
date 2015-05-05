<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"  %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="edu.uark.isys.Post" %>

<%
	String username = (String)session.getAttribute("username");
	if(username == null || username == "") {
		%><script>location.replace("login.jsp");</script><%
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

    <title>Home Page</title>

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
          <!-- TODO: Have form go to logout.jsp that resets session variables -->
          <form class="navbar-form navbar-right" action="login.jsp">
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
        <h1>Hello, <%=username %>!</h1>
        <p>This is your home page to Gabber&trade;, a social networking site where you
         and many others can chat about any kind of nonsense you care to.</p>
        <p>On this page you can browse all of the gabs made by yourself and the users you follow.
         Click the button below to find more users to follow, or use the message box to keep
         gabbing!</p>
         <!-- TODO: Adjust button below so that it redirects to findUsers.jsp -->
        <p><a class="btn btn-primary btn-lg" href="#" role="button">Find Users &raquo;</a></p>
      </div>
    </div>
    
    <div class="container">
	  <p>Make your own gab!</p>
	  <!-- TODO: Have form submit message to database -->
	  <form role="form">
	    <div class="form-group">
	      <label for="comment">Your thoughts:</label>
	      <textarea class="form-control" rows="4" id="comment" maxlength="140"></textarea>
	    </div>
	  </form>
	</div>

	<!-- Get posts -->
	<%

	//Retrieve posts from DB2
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	ArrayList<String> following_set = null;
	ArrayList<Post> posts = null;
	
	String following_sql = "SELECT * FROM MAKS202.SOCIAL_FOLLOWINGS WHERE USERNAME = ?";
	String posts_sql = "SELECT * FROM MAKS202.SOCIAL_POSTS WHERE POSTER_USERNAME = ?";
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
		
		// Build list of people followed
		following_set = new ArrayList<String>();
		following_set.add(username);
		
		pstmt  = con.prepareStatement(following_sql);
		pstmt.setString(1, username);		
		rs = pstmt.executeQuery();
		
		if ( rs != null ) {
			if (rs.next()) {
				following_set.add(rs.getString(2));
			}
		}
		
		out.println("<p>Following_set size: " + following_set.size() + "</p>");
		
		// Retrieve posts from people followed
		posts = new ArrayList<Post>();
		
		// Retrieve posts from each user
		for(String following_user : following_set) {
			pstmt = con.prepareStatement(posts_sql);
			pstmt.setString(1, following_user);
			
			rs = pstmt.executeQuery();
			
			// Add all posts from user to list
			while(rs.next()) {
				Post post = new Post();
				post.setUsername(rs.getString(1));
				post.setPost_text(rs.getString(2));
				post.setPost_date(rs.getDate(3));
				
				posts.add(post);
			}
		}
		
		out.println("<p>Posts size: " + posts.size() + "</p>");
		
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
   		if(posts != null) {
   			Collections.sort(posts);
   			Collections.reverse(posts);
   			
   			// Output each post
   			for(Post post : posts) {
   				out.println("<div class=\"blog-post\">");
   				out.println("<p class=\"blog-post-meta\">");
   				out.println(post.getPost_date() + " by ");
   				out.println("<a href=\"#\">" + post.getUsername() + "</a></p>");
   				out.println("<p>" + post.getPost_text() + "</p></div>");
   			}
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
