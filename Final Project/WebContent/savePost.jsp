<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"  %>  
    
<%
	//Check to see if logged in
	String username = (String)session.getAttribute("username");
	if(username == null || username == "") {
		%><script>location.replace("login.jsp");</script><%
	}
%>    
<%

	//Insert record into DB2
	String post		= request.getParameter("gab");

	//***Insert SQL code for saving to database here
	//***After saving the post works, uncomment the javascript below, this will
	//***redirect the page immediately after saving. Also feel free
	//***to remove the html stuff below, I only have it in here for
	//***making sure the post value was passed properly. Just remove
	//***everything after the '</script>' tag.
%>    
<script>
	//location.href = 'home.jsp';
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Post Testing</title>
</head>
<body>

<h1>Your gab has been saved:</h1><br>
<p><%=post %></p>
<a href="home.jsp">Back to home.</a>

</body>
</html>