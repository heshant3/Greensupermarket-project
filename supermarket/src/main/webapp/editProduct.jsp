
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

<div class="container mt-5">
<h2>Edit Product</h2>
<%

    String productId = request.getParameter("id");
    if(productId == null || productId.isEmpty()) {
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket", "root", "");
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE id = ?");
            ps.setInt(1, Integer.parseInt(productId));
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
%>
<form action="updateProductServlet" method="post" >
    <input type="hidden" name="id" value="<%= productId %>">

    <div class="form-group">
        <label for="name">Name:</label>
        <input type="text" class="form-control" name="name" id="name" value="<%= rs.getString("name") %>" required>
    </div>

    <div class="form-group">
        <label for="description">Description:</label>
        <textarea class="form-control" name="description" id="description" required><%= rs.getString("description") %></textarea>
    </div>

    <div class="form-group">
        <label for="price">Price:</label>
        <input type="number" class="form-control" name="price" id="price" value="<%= rs.getDouble("price") %>" step="0.01" required>
    </div>

    <div class="form-group">
        <label for="quantity">Quantity:</label>
        <input type="number" class="form-control" name="quantity" id="quantity" value="<%= rs.getInt("quantity") %>" required>
    </div>



    <button type="submit" class="btn btn-primary">Update</button>
</form>
<%
            } else {
            }
            rs.close();
            ps.close();
            conn.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
%>
</div>

</body>
</html>




