
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
<%@ page import="com.example.supermarket.DBConnect" %>
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

<div class="container mt-5">
    <h2 class="mb-4">Manage Products</h2>
    <table class="table table-bordered">
        <thead class="thead-light">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%

            try {
                Connection  conn = DBConnect.getConnection();
                Statement stmt = conn.createStatement();
                String sql = "SELECT * FROM products";
                ResultSet   rs = stmt.executeQuery(sql);

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getDouble("price") %></td>
            <td><%= rs.getInt("quantity") %></td>
            <td>
                <a href="editProduct.jsp?id=<%= rs.getInt("id") %>" class="btn btn-primary">Edit</a>
                <a href="DeleteProductServlet?id=<%= rs.getInt("id") %>" class="btn btn-danger">Delete</a>
            </td>
        </tr>
        <%
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>















