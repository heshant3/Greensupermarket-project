package com.example.supermarket;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.http.HttpResponse;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;

import java.io.IOException;
import java.sql.*;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "thankyou", value = "/thankyou")
public class thankyouServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/supermarket";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Cookie[] cookies = request.getCookies();
        String orderNumber = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("orderNumber".equals(cookie.getName())) {
                    orderNumber = cookie.getValue();
                    break;
                }
            }
        }

        System.out.println("order number is "+orderNumber);


        String productId = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("productId".equals(cookie.getName())) {
                    productId = cookie.getValue();
                    break;
                }
            }
        }

        int quantity = 0;

        if (orderNumber != null) {
            String query = "UPDATE orders SET status = 'success' WHERE order_id = ?";

            try (Connection conn = java.sql.DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
                PreparedStatement preparedStatement = conn.prepareStatement(query);
                preparedStatement.setString(1, orderNumber);
                preparedStatement.executeUpdate();

                String quantityQuery = "SELECT quantity FROM products WHERE id = ?"; // Prepare the query


                try (Connection con = java.sql.DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                     PreparedStatement quantityStatement = con.prepareStatement(quantityQuery)) {

                    quantityStatement.setString(1, productId);
                    ResultSet quantityRs = quantityStatement.executeQuery();

                    if (quantityRs.next()) {
                        quantity = quantityRs.getInt("quantity");
                    }

                    int newQuantity = quantity - 1;
                    String updateQuery = "UPDATE products SET quantity = ? WHERE id = ?";
                    String emailQuery = "SELECT emailaddress FROM orders WHERE order_id = ?";



                    try (Connection co = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                         PreparedStatement emailStmt = conn.prepareStatement(emailQuery)) {

                        emailStmt.setString(1, orderNumber);
                        ResultSet emailRs = emailStmt.executeQuery();

                        if (emailRs.next()) {
                            String customerEmail = emailRs.getString("emailaddress");

                            String recipient = customerEmail;
                            String subject = "Thank You for Your Purchase at GREEN Supermarket!";
                            String message = "Thank you for shopping with us at GREEN Supermarket! We're excited to let you know that your order has been processed successfully";

                            CloseableHttpClient client = HttpClients.createDefault();
                            HttpPost post = new HttpPost("http://supermarketweb.online/index.php");

                            List<BasicNameValuePair> urlParameters = new ArrayList<>();
                            urlParameters.add(new BasicNameValuePair("recipient", recipient));
                            urlParameters.add(new BasicNameValuePair("subject", subject));
                            urlParameters.add(new BasicNameValuePair("message", message));

                            post.setEntity(new UrlEncodedFormEntity(urlParameters));
                            HttpResponse responses = client.execute(post);


                            if (responses.getStatusLine().getStatusCode() == 200) {

                            } else {

                            }
                            request.getRequestDispatcher("done.jsp").forward(request, response);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();

                        response.sendRedirect("error.jsp");
                    }




                    try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                         PreparedStatement updateStatement = connection.prepareStatement(updateQuery)) {

                        updateStatement.setInt(1, newQuantity);
                        updateStatement.setString(2, productId);
                        updateStatement.executeUpdate();





                    } catch (SQLException e) {
                        e.printStackTrace();

                    }


                } catch (SQLException e) {
                    e.printStackTrace();

                }


            } catch (SQLException e) {
                throw new ServletException(e);
            }

            request.getRequestDispatcher("done.jsp").forward(request, response);
        } else {

            response.sendRedirect("error.jsp");
        }
    }
}