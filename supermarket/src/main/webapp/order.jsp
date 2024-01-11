

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
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket", "root", "");
        stmt = conn.createStatement();
        String sql = "SELECT * FROM orders where status = 'success'";
        rs = stmt.executeQuery(sql);
%>

<div class="container mt-8">
    <div class="header-custom">
        <h2>All Orders</h2>
    </div>
    <form action="updateStatusServlet" method="post">
        <div class="table-responsive">
            <table class="table table-custom table-hover">
                <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Products</th>
                    <th>Customer Name</th>
                    <th>Address</th>
                    <th>Phone Number</th>
                    <th>Order ID</th>
                    <th>Ordered Time</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <% while(rs.next()) { %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("product_data") %></td>


                    <td><%= rs.getString("customer_name") %></td>
                    <td><%= rs.getString("address") %></td>
                    <td><%= rs.getString("phone_number") %></td>
                    <td><%= rs.getInt("order_id") %></td>
                    <td><%= rs.getTimestamp("ordered_time") %></td>

                    <td>
                        <select name="status_<%= rs.getInt("id") %>" class="form-control">
                            <option <%= "Processing".equals(rs.getString("status")) ? "selected" : "" %> value="Processing">Processing</option>
                            <option <%= "Shipped".equals(rs.getString("status")) ? "selected" : "" %> value="Shipped">Shipped</option>
                            <option <%= "Delivered".equals(rs.getString("status")) ? "selected" : "" %> value="Delivered">Delivered</option>
                        </select>
                    </td>
                    <td><button type="submit" class="btn btn-custom" name="updateStatus" value="<%= rs.getInt("id") %>">Update Status</button></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </form>
</div>

<%
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if(rs != null) rs.close();
        if(stmt != null) stmt.close();
        if(conn != null) conn.close();
    }
%>



</body>
</html>
