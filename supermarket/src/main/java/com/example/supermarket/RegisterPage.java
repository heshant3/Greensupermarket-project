package com.example.supermarket;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.Bucket;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.StorageClient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.*;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;

import static java.lang.System.out;

@WebServlet(name = "RegisterPage", value = "/RegisterPage")
@MultipartConfig
public class RegisterPage  extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/supermarket";
    private static final String USER = "root";
    private static final String PASS = "";
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


            String email = request.getParameter("email");
            String password = request.getParameter("password");

            String query = "INSERT INTO user (email, password) VALUES (?, ?)";

            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                 PreparedStatement pstmt = conn.prepareStatement(query)) {

                pstmt.setString(1, email);
                pstmt.setString(2, password);

                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("login.jsp");
                } else {
                    request.setAttribute("errorMessage", "Registration failed. Please try again.");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                }

            } catch (SQLException e) {
                e.printStackTrace();

                request.setAttribute("errorMessage", "Error while registering: " + e.getMessage());
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

}
}