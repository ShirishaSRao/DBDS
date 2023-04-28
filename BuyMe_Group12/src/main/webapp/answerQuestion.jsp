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
	// Get the form data
	int questionID = Integer.parseInt(request.getParameter("questionID"));
	String answerText = request.getParameter("answerText");
	String username = request.getParameter("username");
	
	// Set up database connection
	ApplicationDB db = new ApplicationDB();  
	Connection con = db.getConnection();
	int userid = -1; // Initialize to a default value in case no results are found
	String q1 = "SELECT userID FROM END_USER WHERE username = ?";
	PreparedStatement query1 = con.prepareStatement(q1);
	query1.setString(1, username);
	ResultSet rs = query1.executeQuery();
	if (rs.next()) {
	    userid = rs.getInt("userID");
	}
	// Insert the answer into the database
	String q2 = "INSERT INTO ANSWERS (questionID, customerRepID, answerText, createdAt) VALUES (?, ?, ?, NOW())";
	PreparedStatement query2 = con.prepareStatement(q2);
	query2.setInt(1, questionID);
	query2.setInt(2, userid);
	query2.setString(3, answerText);
	query2.executeUpdate();
	String q3 = "UPDATE questions SET answered = true WHERE questionID = ?";
	PreparedStatement query3 = con.prepareStatement(q3);
	query3.setInt(1, questionID);
	int rowsAffected = query3.executeUpdate();
	if (rowsAffected > 0) {
		out.println("Successfully answered the question! ");
	} else {
		out.println("Failed to answer the question! ");
	}
%>
<a href="customerRepHome.jsp">Go back to customer rep home</a>	
</body>
</html>