package com.example.supermarket;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.sql.DriverManager;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "updateStatusServlet", value = "/updateStatusServlet")

public class UpdateStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String jdbcURL = "jdbc:mysql://localhost:3306/supermarket";
        String jdbcUsername = "root";
        String jdbcPassword = "";

        String updateSql = "UPDATE orders SET delivery = ? WHERE id = ?";


        String orderId = request.getParameter("updateStatus");
        String newStatus = request.getParameter("status_" + orderId);


        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement pstmt = conn.prepareStatement(updateSql)) {


            pstmt.setString(1, newStatus);
            pstmt.setInt(2, Integer.parseInt(orderId));


            pstmt.executeUpdate();


            response.sendRedirect("order.jsp");
        } catch (SQLException e) {

            e.printStackTrace();
        }
    }
}
