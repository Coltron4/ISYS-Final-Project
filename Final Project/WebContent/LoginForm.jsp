<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"  %> 
    
<%

	//Insert record into DB2
	String username	= request.getParameter("username");
	String userPass	= request.getParameter("password");
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int numberOfAccounts = 0;
	
	String sql = "SELECT COUNT(*) FROM MAKS202.SOCIAL_USERS WHERE USERNAME = ? AND PASS = ?";
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
		pstmt  = con.prepareStatement(sql);
		pstmt.setString(1, username);
		pstmt.setString(2, userPass);
		
		rs = pstmt.executeQuery();
		
		if ( rs != null ) {
			//loop through result set
			if (rs.next()) {
				numberOfAccounts = rs.getInt(1);
			}
		}
		
		con.close();
		
	} catch(Exception ex) {
		ex.printStackTrace();
		out.write("Error doing something in DB2... :( " );
	}
	
	// Perform validation

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Validation</title>
</head>
<body>
<%
	out.write("Number of accounts: " + numberOfAccounts);

	if(numberOfAccounts > 0) {
		session.setAttribute("username", username);
		out.println("<script>location.href = 'home.jsp';</script>");
%>
<br><br>
<a href="home.jsp">Home Page</a>
<% 	} else {
		out.write("<br><br>Login failed, try again.<br>");
		out.write("<a href='login.jsp'>Login Page</a>");
		out.println("<script>location.href = 'login.jsp';</script>");
	}
%>
</body>
</html>