
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
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
    <div class="container mt-5">
        <%
            String success = (String) session.getAttribute("success");
            if ("true".equals(success)) {
        %>
        <div class="alert alert-success" role="alert">
            Product added successfully!
        </div>
        <%
            }
        %>
    </div>


    <div class="form-custom mx-auto mt-5">
        <h2 class="text-center mb-4">Add Product</h2>
       <div class="container">
           <form action="addProduct" method="post" enctype="multipart/form-data">
               <div class="form-group mb-4">
                   <label for="category">Product Category:</label>
                   <select class="form-control" id="category" name="category" required>
                       <option value="Groceries">Groceries</option>
                       <option value="Fresh Produce">Fresh Produce</option>
                       <option value="Beverages and Dairy">Beverages and Dairy</option>
                   </select>
               </div>
               <div class="form-group mb-4">
                   <label for="name">Product Name:</label>
                   <input type="text" class="form-control" id="name" name="name" required>
               </div>
               <div class="form-group mb-4">
                   <label for="description">Description:</label>
                   <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
               </div>
               <div class="form-group mb-4">
                   <label for="quantity">Quantity:</label>
                   <input type="number" class="form-control" id="quantity" name="quantity" required>
               </div>
               <div class="form-group mb-4">
                   <label for="price">Price:</label>
                   <input type="number" class="form-control" id="price" name="price" step="0.01" required>
               </div>

               <div class="form-group mb-4">
                   <label for="image">Image:</label>
                   <input type="file" class="form-control-file" name="image" required>
               </div>

               <button type="submit" class="btn btn-custom w-100">Submit</button>
           </form>

       </div>
    </div>
</div>



</body>
</html>
