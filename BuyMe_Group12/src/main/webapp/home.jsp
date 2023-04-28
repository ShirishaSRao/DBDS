<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome to user home page</title>
</head>
<body>
<%
String username = request.getParameter("username");
%>
<input type="button" value="Sell Item" onclick="window.location='sellItem.jsp'"/>
<input type="button" value="Bid Item" onclick="window.location='bidItems.jsp'"/>
<br>
<h1>Ask a Question</h1>
    <form action="submitQuestion.jsp" method="post">
        <input type="hidden" name="username" value="<%=username%>">
        <label for="question">Question:</label>
        <textarea name="question" rows="5" required></textarea><br>        
        <input type="submit" value="Submit">
    </form>
<a href="logout.jsp">Logout</a>
</body>
</html>