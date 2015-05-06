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
	String post_text = request.getParameter("gab");

	//SQL code for saving to database
	Connection con = null;
	PreparedStatement pstmt = null;
	
	String insert_post_sql = "INSERT INTO MAKS202.SOCIAL_POSTS VALUES ( ?, ?, CURRENT_TIMESTAMP )";
	String db2user = "maks202";
	String db2pass = "axle088";
	String db2url = "jdbc:db2://130.184.26.148:446/ZUAF";
	
	try {
		Class.forName("com.ibm.db2.jcc.DB2Driver");
	} catch (Exception ex) {
		ex.printStackTrace();
		out.write("Error connecting to DB2... :( " );
	}
	
	try {
		con = DriverManager.getConnection(db2url, db2user, db2pass);
		
		// Insert new post
		pstmt  = con.prepareStatement(insert_post_sql);
		pstmt.setString(1, username);
		pstmt.setString(2, post_text);
		pstmt.executeUpdate();
		
		out.println("<p>Post inserted succesfully!</p>");
		
		con.close();
		
	} catch(Exception ex) {
		ex.printStackTrace();
		out.write("Error doing something in DB2... :( " );
	}
%>    
<script>
	location.href = 'home.jsp';
</script>