<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"  %>  
    
<%

	//Insert record into DB2
	String name		= request.getParameter("txtName");
	String username	= request.getParameter("txtUsername");
	String userPass	= request.getParameter("txtPass1");
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "INSERT INTO MAKS202.SOCIAL_USERS( USERNAME, PASS, REAL_NAME ) VALUES ( ?, ?, ? )";
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
		pstmt.setString(3, name);
		
		pstmt.execute();
		con.close();
		
	} catch(Exception ex) {
		ex.printStackTrace();
		out.write("Error doing something in DB2... :( " );
	}

%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Congratulations!</title>
</head>
<body>

<h1>Your Account Has Been Created!</h1><br>
<a href="login.jsp">Proceed to Login</a>

</body>
</html>