<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
			<h1>Login Form</h1>
			<form action="loginVerify.jsp" method="post">
				<table>
					<tr> <td> User Name: </td><td> <input type="text" name="username"></td></tr>
					<tr> <td> Password: </td><td> <input type="password" name="password"></td></tr> 
					<tr> <td> <input type="submit" value="Log in"></td></tr>
					<% if (request.getParameter("login_error") != null) { %>
			<tr>
				<td><p style="text-align: center; color: red"><%=request.getParameter("login_error")%></p></td>
			</tr>
		<% } %>
				</table>
			</form> 
			 
	</div>	
</body>
</html>