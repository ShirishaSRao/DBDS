<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="project_pkg.Category"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="project_pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% String query = ""; %>
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//get parameters
		// out.println("hellooooooooo");
		
		int userID = (int) session.getAttribute("userID");
		String itemName = request.getParameter("item_name");
		
		String category = request.getParameter("categories");
		int subCategoryID = Integer.valueOf(request.getParameter("sub-categories"));
		
		/* String getSubCatId = "SELECT sub_categoryID FROM SUB_CATEGORY WHERE sub_categoryName=" + subCategory + ";";
		out.println("sub cat query:   " + getSubCatId);
		
		
		ResultSet rs1 = stmt.executeQuery(getSubCatId);
		int sub_categoryID = 0;
		if (rs1.next()) {
			sub_categoryID = rs1.getInt("sub_categoryID");
		} */
		
		float minPrice = Float.valueOf(request.getParameter("minimum_price"));
		String condition = request.getParameter("condition");
		String closingDateTime = request.getParameter("closing_datetime");
		
		String getSellerID = "SELECT sellerID FROM SELLER WHERE sellerID=" + userID + ";";
		ResultSet rs2 = stmt.executeQuery(getSellerID);
		if (!rs2.next()) {
			String createSeller = "INSERT INTO SELLER(sellerID, items_sold) VALUES(" + userID + ", 0);";
			//stmt.executeUpdate(createSeller);
		}
		
		//insertItem = "INSERT INTO ITEM(sellerID, sub_categoryID, item_name, item_condition, minimum_price)"
		//		+ "VALUES(?,?,?,?,?);";
		String insertItem = "INSERT INTO ITEM(sellerID, sub_categoryID, item_name, item_condition, minimum_price)"
						+ "VALUES(?,?,?,?,?); ";
		
		PreparedStatement ps = con.prepareStatement(insertItem);
		ps.setInt(1, userID);
		ps.setInt(2, subCategoryID);
		ps.setString(3, itemName);
		ps.setString(4, condition);
		ps.setFloat(5, minPrice);
		ps.executeUpdate(); 
		
		/* CallableStatement cs = con.prepareCall(insertItem);
		cs.setInt(2, userID);
		cs.setInt(3, sub_categoryID);
		cs.setString(4, itemName);
		cs.setString(5, condition);
		cs.setFloat(6, minPrice);
		cs.registerOutParameter(7, java.sql.Types.INTEGER);
		cs.execute(); */
		
		String getItemID = "SELECT MAX(itemID) FROM ITEM;";
		ResultSet rs3 = stmt.executeQuery(getItemID);
		int itemID = 0;
		if (rs3.next()) {
			itemID = rs3.getInt(1);
		}
		
		float increment = Float.valueOf(request.getParameter("increment"));
		
		String createAuction = "INSERT INTO AUCTION(sellerID, itemID, initial_price, increment, start_datetime, closing_datetime)"
				+ "VALUES(?,?,?,?,?,?);";
		
		PreparedStatement pstmt = con.prepareStatement(createAuction);
		pstmt.setInt(1, userID);
		pstmt.setInt(2, itemID);
		pstmt.setFloat(3, minPrice);
		pstmt.setFloat(4, increment);
		pstmt.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
		//out.println("closing date time before: " + closingDateTime);
		closingDateTime = closingDateTime.replace("T", " ");
		//DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		
		

		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		java.util.Date date = (java.util.Date)formatter.parse(closingDateTime); 
		java.sql.Timestamp sqlDate = new java.sql.Timestamp(date.getTime());
		
		/* out.println("closing dateeeee: " + date.getTime());
		out.println("sql date: " + sqlDate); */

		//Date date = (Date)formatter.parse(closingDateTime);
		
		pstmt.setTimestamp(6, sqlDate);
		pstmt.executeUpdate();
		// TO DO: update items_sold in seller table 
		
 
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
	}
%>
</body>
<script type="text/javascript">
	console.log(<%= query%>);
</script>


</html>