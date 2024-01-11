
<%
    Cookie[] cookies = request.getCookies();
    boolean isAuthenticated = false;

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("user".equals(cookie.getName())) {
                isAuthenticated = true;
                break;
            }
        }
    }

    if (!isAuthenticated) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>


<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product - GREEN Supermarket</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar-custom {
            background-color: #28a745; /* A green shade for the navbar */
        }
        .btn-custom {
            background-color: #198754; /* Bootstrap green variant */
            color: white;
        }
        .btn-custom:hover {
            background-color: #14532d; /* Darker green on hover */
        }
        .form-custom {
            background-color: white;
            border-radius: 0.5rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
    </style>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <a href="index.jsp" class="navbar-brand">GREEN Supermarket</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="add_product.jsp">Add Product</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manageProducts.jsp">Manage Product</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="order.jsp">Orders</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="view_message.jsp">View Messages</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="logout.jsp">Logout</a>
            </li>
        </ul>
    </div>
</nav>

<%


    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String JDBC_URL = "jdbc:mysql://localhost:3306/supermarket";
        String JDBC_USER = "root";
        String JDBC_PASS = "";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);

        String sql = "SELECT * FROM contact_messages ORDER BY submitted_at DESC";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
%>

<div class="container mt-5">
    <h2 class="text-xl font-bold mb-4">Customer Messages</h2>
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Message</th>
                <th>Submitted At</th>
            </tr>
            </thead>
            <tbody>
            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("message") %></td>
                <td><%= rs.getTimestamp("submitted_at") %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<%
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace(); }
    }
%>



</body>
</html>
