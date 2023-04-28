<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Customer Representative</title>
</head>
<body>
<p>Login Successful</p>
<form action="createRepDb.jsp" method="post">
			<table style="with: 50%">
				<tr>
					<td>Username</td>
					<td><input type="text" name="username" /></td>
				</tr>
				<tr>
					<td>Name</td>
					<td><input type="text" name="name" /></td>
				</tr>
					<tr>
					<td>Password</td>
					<td><input type="password" name="password" /></td>
				</tr>
				<tr>
					<td>email</td>
					<td><input type="text" name="email" /></td>
				</tr></table>
			<input type="submit" value="Submit" />
</form>
<a href="logout.jsp">Logout</a>
</body>
</html>