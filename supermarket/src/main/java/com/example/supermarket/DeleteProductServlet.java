package com.example.supermarket;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet(name = "DeleteProductServlet", value = "/DeleteProductServlet")

public class DeleteProductServlet   extends HttpServlet {



    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("id");

        if (productId == null || productId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing.");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket", "root", "");
            String sql = "DELETE FROM products WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(productId.trim()));
            int deleted = pstmt.executeUpdate();
            if(deleted > 0) {
                response.sendRedirect("manageProducts.jsp?deleteSuccess=true");
            } else {
                response.sendRedirect("manageProducts.jsp?deleteSuccess=false");
            }
        } catch(Exception e) {
            throw new ServletException("Deleting product failed.", e);
        } finally {
            if(pstmt != null) {
                try { pstmt.close(); } catch (Exception e) { /* ignored */ }
            }
            if(conn != null) {
                try { conn.close(); } catch (Exception e) { /* ignored */ }
            }
        }
    }
}
