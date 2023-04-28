<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="project_pkg.ApplicationDB"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome to customer representative home</title>
</head>
<body>
<h1>Welcome to customer representative home</h1>
<p>Unanswered Questions</p>
<%
    // Set up database connection
    String username = request.getParameter("username");
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
    // Retrieve list of unanswered questions
    String q1 = "SELECT * FROM questions WHERE answered = false";
    Statement query1 = con.createStatement();
    ResultSet result = query1.executeQuery(q1);
    while (result.next()) { %>
    <p><%= result.getString("questionText") %></p>
    <form action="answerQuestion.jsp" method="post">
    	<input type="hidden" name="username" value="<%=username%>">
        <input type="hidden" name="questionID" value="<%= result.getInt("questionID") %>">
        <textarea name="answerText" rows="5" required></textarea><br>
        
        <input type="submit" value="Answer">
    </form>
<% } %>
</body>
</html>
