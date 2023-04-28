<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="project_pkg.ApplicationDB"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<%
String username = request.getParameter("username");
session.setAttribute("userid", username);
String name = request.getParameter("name");
String password = request.getParameter("password");
String email = request.getParameter("email");
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
String q1 = "INSERT INTO END_USER(username, password, name, email, userType) VALUES (?, ?, ?, ?, 'customerRep')";
PreparedStatement pstmt = con.prepareStatement(q1);
pstmt.setString(1, username);
pstmt.setString(2, password);
pstmt.setString(3, name);
pstmt.setString(4, email);
int rowsAffected = pstmt.executeUpdate();
if (rowsAffected > 0) {
	session.setAttribute("username", username);
  	out.println("Successfully created the customer representative! ");
} else {
 	out.println("Customer representative creation failed.");
}
%>
<a href="adminHome.jsp">Go back to admin home</a>	
</body>
</html>