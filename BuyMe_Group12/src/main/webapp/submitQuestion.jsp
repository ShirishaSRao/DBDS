<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="project_pkg.ApplicationDB"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Submit Question</title>
</head>
<body>
<%
// Retrieve form data
String username = request.getParameter("username");
String question = request.getParameter("question");

// Set up database connection
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();

//Get userID from username
int userid = -1; // Initialize to a default value in case no results are found
String q1 = "SELECT userID FROM END_USER WHERE username = ?";
PreparedStatement query1 = con.prepareStatement(q1);
query1.setString(1, username);
ResultSet rs = query1.executeQuery();
if (rs.next()) {
    userid = rs.getInt("userID");
}
//Insert question into database
String q2 = "INSERT INTO QUESTIONS(userID, questionText, answered, createdAt) " +
          "VALUES (?, ?, FALSE, NOW())";
PreparedStatement query2 = con.prepareStatement(q2);
query2.setInt(1, userid); // Replace 1 with the actual user ID
query2.setString(2, question);
int rowsInserted = query2.executeUpdate();
if (rowsInserted > 0) {
 out.println("<p>Question submitted successfully!</p>");
} else {
 out.println("<p>Error submitting question.</p>");
}

//Close database connection
con.close();
%>
</body>
</html>