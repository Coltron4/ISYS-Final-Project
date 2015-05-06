<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%
	//All this page does is reset username in post and redirect to login

	//Reset post variable
	session.setAttribute("username", null);
	%><script>location.replace("login.jsp");</script><%
%>