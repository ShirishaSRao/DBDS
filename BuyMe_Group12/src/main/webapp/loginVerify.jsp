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
PreparedStatement ps = con.prepareStatement("SELECT userID, username, password, userType FROM end_user WHERE username=? AND password=?");
ps.setString(1, username);
ps.setString(2, password);
ResultSet rs = ps.executeQuery();
if(rs.next()){
	int userID = rs.getInt("userID");
 	session.setAttribute("userID", userID);
	session.setAttribute("username", username);
	String userType = rs.getString("userType");
	if (userType.equals("user")){
		%>
			<jsp:forward page="home.jsp">
			<jsp:param name="username" value="<%=username%>"/>
			</jsp:forward>
		<%
		}else if(userType.equals("admin")){
			%>
			<jsp:forward page="adminHome.jsp">
			<jsp:param name="username" value="<%=username%>"/>
			</jsp:forward>
		<%
		}
		else if(userType.equals("customerRep")){
			%>
			<jsp:forward page="customerRepHome.jsp">
			<jsp:param name="username" value="<%=username%>"/>
			</jsp:forward>
		<%
		}
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