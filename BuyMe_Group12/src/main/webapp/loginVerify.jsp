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
String userid = request.getParameter("username");
//HttpSession session = request.getSession();
session.setAttribute("username", userid);
String password = request.getParameter("password");
//Class.forName("com.mysql.jdbc.Driver");
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("select userID,password from end_user where userID='" + userid + "' and password='" + password + "';");

if(rs.next()){
	session.setAttribute("username", userid);
	%>
		<jsp:forward page="home.jsp">
		<jsp:param name="username" value="<%=userid%>"/>
		</jsp:forward>
	<%
	 }else{
		 %>
			<jsp:forward page="login.jsp">
			<jsp:param name="login_error" value="Incorrect username or password."/> 
			</jsp:forward>
			<%
	 }

	
%>
</body>
</html>