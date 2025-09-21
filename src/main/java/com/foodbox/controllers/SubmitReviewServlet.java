package com.foodbox.controllers;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class SubmitReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String itemId = request.getParameter("itemId");
        String email = request.getParameter("email");
        String rating = request.getParameter("rating");
        String review = request.getParameter("review");

        String message = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/foodbox", "root", "Ravi@2003");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO ratings_reviews (item_id, user_email, rating, review) VALUES (?, ?, ?, ?)"
            );
            ps.setInt(1, Integer.parseInt(itemId));
            ps.setString(2, email);
            ps.setInt(3, Integer.parseInt(rating));
            ps.setString(4, review);
            ps.executeUpdate();

            message = "Review submitted successfully!";
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }

        request.setAttribute("message", message);
        RequestDispatcher rd = request.getRequestDispatcher("submit.jsp");
        rd.forward(request, response);
    }
}
