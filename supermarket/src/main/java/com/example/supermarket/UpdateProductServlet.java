package com.example.supermarket;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet(name = "updateProductServlet", value = "/updateProductServlet")

public class UpdateProductServlet  extends HttpServlet {



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");

        System.out.println(id +name +  description + price+quantity);
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");


             conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket", "root", "");


            String sql = "UPDATE products SET name = ?, description = ?, price = ?, quantity = ? WHERE id = ?";
               pstmt = conn.prepareStatement(sql);


            pstmt.setString(1, name);
            pstmt.setString(2, description);
            pstmt.setDouble(3, Double.parseDouble(price));
            pstmt.setInt(4, Integer.parseInt(quantity));
            pstmt.setInt(5, Integer.parseInt(id));


            int updated = pstmt.executeUpdate();
            if(updated > 0) {
                response.sendRedirect("manageProducts.jsp?updateSuccess=true");
            } else {
                response.sendRedirect("manageProducts.jsp?updateSuccess=false");
            }
        } catch(Exception e) {
            throw new ServletException("Updating product failed.", e);
        } finally {

            if(pstmt != null) {
                try { pstmt.close(); } catch (Exception e) {  }
            }
            if(conn != null) {
                try { conn.close(); } catch (Exception e) {  }
            }
        }
    }
}
