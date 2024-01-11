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
import java.sql.SQLException;

@WebServlet(name = "submitContactForm", value = "/submitContactForm")

public class submitContactForm extends HttpServlet {
    private static final long serialVersionUID = 1L;



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
        final String DB_URL = "jdbc:mysql://localhost:3306/supermarket";
        final String USER = "root";
        final String PASS = "";

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName(JDBC_DRIVER);

            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            String sql = "INSERT INTO contact_messages (name, email, message) VALUES (?, ?, ?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, message);

            pstmt.executeUpdate();

            pstmt.close();
            conn.close();

            response.sendRedirect("contact.jsp");

        } catch(SQLException se) {
            se.printStackTrace();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(pstmt != null) pstmt.close();
            } catch(SQLException se2) {
            }
            try {
                if(conn != null) conn.close();
            } catch(SQLException se) {
                se.printStackTrace();
            }
        }
    }
}
