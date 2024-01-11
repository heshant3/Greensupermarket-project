package com.example.supermarket;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.sql.DriverManager;
import java.util.List;
import java.util.Random;

@WebServlet(name = "processPurchase", value = "/processPurchase")
public class ProcessOrder extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/supermarket";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        HttpSession session = request.getSession();
        List<String> cart = (List<String>) session.getAttribute("cart");
        StringBuilder productNames = new StringBuilder();

        if (cart != null && !cart.isEmpty()) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket", "root", "");

                for (String idStr : cart) {
                    int id = Integer.parseInt(idStr);
                    String query = "SELECT name FROM products WHERE id = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setInt(1, id);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        if (productNames.length() > 0) {
                            productNames.append(", ");
                        }
                        productNames.append(rs.getString("name"));
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }

        // Now you can use productNames.toString() to get the concatenated string
        String allProductNames = productNames.toString();














        String customerName = request.getParameter("name");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phone");
         session = request.getSession();
        String email = (String) session.getAttribute("userEmail");

        double price = 0;
        String query = "SELECT price FROM products WHERE id = ?";

        Random rand = new Random();
        int min = 99999;
        int max = 999999;
        int randomNum = rand.nextInt((max - min) + 1) + min;
         query = "INSERT INTO orders ( customer_name, address, phone_number, payment, order_id, ordered_time, emailaddress, product_data) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            PreparedStatement preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, customerName);
            preparedStatement.setString(2, address);
            preparedStatement.setString(3, phoneNumber);
            preparedStatement.setDouble(4, price);
            preparedStatement.setDouble(5, randomNum);
            preparedStatement.setTimestamp(6, new Timestamp(System.currentTimeMillis())); // set the current time
            preparedStatement.setString(7, email);
            preparedStatement.setString(8, allProductNames);


            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException(e);
        }
        String name = customerName.replace(" ", "_");

        Cookie productIdCookie = new Cookie("productId", "productId");
        Cookie orderNumber = new Cookie("orderNumber", Integer.toString(randomNum));
        Cookie priceCookie = new Cookie("price", String.valueOf(price));
        Cookie emailAddress = new Cookie("email", String.valueOf(email));
        Cookie clientNameCookie = new Cookie("clientName", name);


        productIdCookie.setMaxAge(1800);
        priceCookie.setMaxAge(1800);
        orderNumber.setMaxAge(1800);
        clientNameCookie.setMaxAge(1800);


        response.addCookie(productIdCookie);
        response.addCookie(priceCookie);
        response.addCookie(orderNumber);
        response.addCookie(emailAddress);
        response.addCookie(clientNameCookie);


        response.sendRedirect("payment.jsp");
    }
}