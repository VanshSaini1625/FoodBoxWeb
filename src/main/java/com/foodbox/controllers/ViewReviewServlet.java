package com.foodbox.controllers;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class ViewReviewServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String itemId = request.getParameter("itemId");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/foodbox", "root", "Ravi@2003");

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM ratings_reviews WHERE item_id = ? ORDER BY created_at DESC"
            );
            ps.setInt(1, Integer.parseInt(itemId));
            ResultSet rs = ps.executeQuery();

            request.setAttribute("reviews", rs);
            request.setAttribute("itemId", itemId);
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
        }

        RequestDispatcher rd = request.getRequestDispatcher("review.jsp");
        rd.forward(request, response);
    }
}
