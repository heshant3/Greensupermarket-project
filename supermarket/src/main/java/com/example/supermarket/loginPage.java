package com.example.supermarket;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;


@WebServlet(name = "userlogin", value = "/userlogin")

public class loginPage extends HttpServlet {
    private final String JDBC_URL = "jdbc:mysql://localhost:3306/supermarket";
    private final String DB_USER = "root";
    private final String DB_PASSWORD = "";


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean isValidUser = validateUser(email, password);

        if (isValidUser) {
            request.getSession().setAttribute("userEmail", email);
            response.sendRedirect("account.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }
    private boolean validateUser(String email, String password) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, email);
                    statement.setString(2, password);

                    try (ResultSet resultSet = statement.executeQuery()) {
                        return resultSet.next();
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();

            return false;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
