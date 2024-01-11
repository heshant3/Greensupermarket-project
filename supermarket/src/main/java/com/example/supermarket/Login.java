package com.example.supermarket;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "loginPage", value = "/loginPage")

public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if ("admin".equals(username) && "admin".equals(password)) {
            Cookie loginCookie = new Cookie("user", username);
            loginCookie.setMaxAge(30 * 60);
            response.addCookie(loginCookie);
            response.sendRedirect("add_product.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin_login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
