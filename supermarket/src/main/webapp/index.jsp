<%@ page import="com.example.supermarket.DBConnect" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <link rel="stylesheet" href="css/home.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <title>GREEN Supermarket</title>
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
                <a href="index.jsp" class="nav-link">Home</a>
            </li>
            <li class="nav-item">
                <a href="register.jsp" class="nav-link">Register</a>
            </li>
            <li class="nav-item">
                <a href="login.jsp" class="nav-link">Login</a>
            </li>
            <li class="nav-item">
                <a href="contact.jsp" class="nav-link">Contact</a>
            </li>
            <!-- Cart Icon -->
            <li class="nav-item">
                <a href="cart.jsp" class="nav-link">
                    <i class="fas fa-shopping-cart"></i> Cart
                </a>
            </li>
        </ul>
    </div>
</nav>



<section class="py-5">
    <div class="container">
        <h2 class="text-center mb-4">Fresh Produce</h2>
        <div class="row">
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DBConnect.getConnection();
                    stmt = conn.createStatement();
                    String sql = "SELECT * FROM products where category ='Fresh Produce'";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
            %>
            <div class="col-md-3 mb-4">
                <div class="card">
                    <img src="<%= rs.getString("image_url") %>" class="card-img-top" alt="Product Image">
                    <div class="card-body">
                        <h5 class="card-title"><%= rs.getString("name") %></h5>
                        <p class="card-text"><%= rs.getString("description") %></p>
                        <p>Price: $<%= rs.getDouble("price") %></p>
                        <a href="AddToCartServlet?id=<%= rs.getString("id") %>" class="btn btn-custom">Add to cart</a>
                    </div>
                </div>
            </div>

            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </div>
    </div>
</section>

<section class="py-5">
    <div class="container">
        <h2 class="text-center mb-4">Groceries</h2>
        <div class="row">
            <%

                try {
                    conn = DBConnect.getConnection();
                    stmt = conn.createStatement();
                    String sql = "SELECT * FROM products where category ='Groceries'";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
            %>
            <div class="col-md-3 mb-4">
                <div class="card">
                    <img src="<%= rs.getString("image_url") %>" class="card-img-top" alt="Product Image">
                    <div class="card-body">
                        <h5 class="card-title"><%= rs.getString("name") %></h5>
                        <p class="card-text"><%= rs.getString("description") %></p>
                        <p>Price: $<%= rs.getDouble("price") %></p>
                        <a href="AddToCartServlet?id=<%= rs.getString("id") %>" class="btn btn-custom">Add to cart</a>
                    </div>
                </div>
            </div>

            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </div>
    </div>
</section>

<section class="py-5">
    <div class="container">
        <h2 class="text-center mb-4">Beverages and Dairy</h2>
        <div class="row">
            <%

                try {
                    conn = DBConnect.getConnection();
                    stmt = conn.createStatement();
                    String sql = "SELECT * FROM products where category ='Beverages and Dairy'";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
            %>
            <div class="col-md-3 mb-4">
                <div class="card">
                    <img src="<%= rs.getString("image_url") %>" class="card-img-top" alt="Product Image">
                    <div class="card-body">
                        <h5 class="card-title"><%= rs.getString("name") %></h5>
                        <p class="card-text"><%= rs.getString("description") %></p>
                        <p>Price: $<%= rs.getDouble("price") %></p>
                        <a href="AddToCartServlet?id=<%= rs.getString("id") %>" class="btn btn-custom">Add to cart</a>
                    </div>
                </div>
            </div>

            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </div>
    </div>
</section>

<footer class="text-center text-lg-start bg-light text-muted">
    <section class="d-flex justify-content-center justify-content-lg-between p-4 border-bottom">

    </section>
    <section class="">
        <div class="container text-center text-md-start mt-5">

            <div class="row mt-3">

                <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">

                    <h6 class="text-uppercase fw-bold mb-4">
                        <i class="fas fa-gem me-3"></i>GREEN Supermarket
                    </h6>
                    <p>
                        Your trusted source for quality products in Sri Lanka.
                    </p>
                </div>

                <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">

                    <h6 class="text-uppercase fw-bold mb-4">
                        Products
                    </h6>

                </div>

                <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">

                    <h6 class="text-uppercase fw-bold mb-4">
                        Useful links
                    </h6>

                </div>

                <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">

                    <h6 class="text-uppercase fw-bold mb-4">
                        Contact
                    </h6>
                    <p><i class="fas fa-home me-3"></i> Colombo, Sri Lanka</p>
                    <p>
                        <i class="fas fa-envelope me-3"></i>
                        contact@greensupermarket.lk
                    </p>
                    <p><i class="fas fa-phone me-3"></i> +94 12 345 6789</p>
                </div>

            </div>

        </div>
    </section>
    <div class="text-center p-4" style="background-color: rgba(0, 0, 0, 0.05);">
        &copy; 2023 GREEN Supermarket. All rights reserved.
    </div>
</footer>

</body>
</html>
