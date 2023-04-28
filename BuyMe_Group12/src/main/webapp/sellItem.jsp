<%@page import="project_pkg.Category"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="project_pkg.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,com.google.gson.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Start an Auction</title>
</head>
<body>
<div>
<% String jsonCat = "d"; %>
	<h3>Create auction</h3>
	<form name="add_item" action="addAuction.jsp" method="post">
		<table>
			<tr><td> Item name: </td><td> <input type="text" name="item_name" /></td>
			
			<%
			try {
					//Get the database connection
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();

					//Create a SQL statement
					Statement stmt = con.createStatement();
					//String entity = request.getParameter("")
					String str = "SELECT c.categoryID cid, c.categoryName cname, sc.sub_categoryID scid, sc.sub_categoryName scname FROM CATEGORY c INNER JOIN SUB_CATEGORY sc ON c.categoryID=sc.categoryID;";
					ResultSet result = stmt.executeQuery(str);
					
					HashMap<Integer, Category> categories = new HashMap<>();
					
					while (result.next()) {
						int cid = result.getInt("cid");
						String cname = result.getString("cname");
						int scid = result.getInt("scid");
						String scname = result.getString("scname");
						
						if (!categories.containsKey(cid)) {
							Category cat = new Category(cid, cname);
							categories.put(cid, cat);
						}
						
						Category cat = categories.get(cid);
						SubCategory scat = new SubCategory(scid, scname);
						
						cat.subCategories.add(scat);
						Gson gson = new Gson();
						jsonCat = gson.toJson(categories);
					}
				} catch (Exception e) {
					out.print(e);
				}
			%>
			
			<tr><td> Categories: </td>
			<td> <select name="categories" id="categories">
				<option value="" selected="selected">Select category</option>
			</select></td>
			</tr>
			<tr><td> Sub Categories: </td>
			<td> <select name="sub-categories" id="sub-categories">
				  <option value="" selected="selected">Select sub category</option>
			</select> </td>
			</tr>

			
			<tr><td> Minimum price ($): </td><td> <input type="number" step="0.5" name="minimum_price"/></td></tr>
			<tr><td> Increment ($): </td><td> <input type="number" step="0.05" name="increment"/></td></tr>
			<tr><td> Condition: </td><td> 
			<select name="condition" id="condition">
				<option value="new">New</option>
				<option value="likeNew">Like New</option>
				<option value="used">Used</option>
				<option value="old">Old</option>
			</select>
			</td></tr>
			<tr><td> Closing time: </td><td> <input type="datetime-local" name="closing_datetime"/><td></tr>
			<!--  <tr><td> Closing time: </td><td> <input type="time" name="closing_time"/></td></tr> -->
			<tr><td> <input type="submit" value="Auction Item">
		</table>
	</form>
</div>
</body>
	<script>
		var catListJs = JSON.stringify(<%= jsonCat %>);
		var catList = JSON.parse(catListJs);
		console.log("catList: " + catListJs);
		
		window.onload = function() {
			var categorySelect = document.getElementById("categories");
			var subCatSelect = document.getElementById("sub-categories");
			for (var x in catList) {
				categorySelect.appendChild(new Option(catList[x].categoryName, x));
			}
			categorySelect.onchange = function() {
				subCatSelect.length = 1;
				console.log("here:  " + this.value);
				
				for (var y in catList[this.value].subCategories) {
					subCatSelect.appendChild(new Option(catList[this.value].subCategories[y].sub_categoryName, catList[this.value].subCategories[y].sub_categoryID));
				}
			}
		}
	
	</script> 
</html>