<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="project_pkg.ApplicationDB"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login to your account</title>
</head>
<body>
<%
String username = request.getParameter("username");
//HttpSession session = request.getSession();
session.setAttribute("username", username);
String password = request.getParameter("password");
//Class.forName("com.mysql.jdbc.Driver");
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("select userID,username,password from end_user where username='" + username + "' and password='" + password + "';");

if(rs.next()){
	int userID = rs.getInt("userID");
	session.setAttribute("userID", userID);
	%>
		<jsp:forward page="home.jsp">
		<jsp:param name="username" value="<%=userID%>"/>
		</jsp:forward>
	<%
	 } else{
	%>
		<jsp:forward page="login.jsp">
		<jsp:param name="login_error" value="Incorrect username or password."/> 
		</jsp:forward>
	<%
	 }
%>
</body>
</html>