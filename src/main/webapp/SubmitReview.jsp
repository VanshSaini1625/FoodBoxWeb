<%@ page import="java.sql.*" %>
<%
    String message = "";
    if(request.getMethod().equals("POST")) {
        String foodId = request.getParameter("foodId");
        String user = request.getParameter("user");
        String rating = request.getParameter("rating");
        String comment = request.getParameter("comment");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/foodbox", "root", "Ravi@2003");
            PreparedStatement ps = con.prepareStatement("INSERT INTO reviews (food_item_id, user_name, rating, comment) VALUES (?, ?, ?, ?)");
            ps.setInt(1, Integer.parseInt(foodId));
            ps.setString(2, user);
            ps.setInt(3, Integer.parseInt(rating));
            ps.setString(4, comment);
            ps.executeUpdate();
            message = "Review submitted successfully!";
        } catch(Exception e) {
            message = "Error: " + e.getMessage();
        }
    }
%>
<html>
<head><title>Submit Review</title></head>
<body>
<h2>Submit Review</h2>
<form method="post">
    Food Item ID: <input type="text" name="foodId" required><br>
    Name: <input type="text" name="user" required><br>
    Rating (1-5): 
    <select name="rating" required>
        <option value="">Select</option>
        <option value="1">1 Star</option>
        <option value="2">2 Stars</option>
        <option value="3">3 Stars</option>
        <option value="4">4 Stars</option>
        <option value="5">5 Stars</option>
    </select><br>
    Comment: <textarea name="comment"></textarea><br>
    <input type="submit" value="Submit Review">
</form>
<p><%= message %></p>
</body>
</html>
