<%@ page import="com.example.supermarket.DBConnect" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
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

            <li class="nav-item">
                <a href="cart.jsp" class="nav-link">
                    <i class="fas fa-shopping-cart"></i> Cart
                </a>
            </li>
        </ul>
    </div>
</nav>

<%

    double totalPrice = 0.0;


    session = request.getSession();
    List<String> cart = (List<String>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<div class="container mt-5">
    <h2>Items in Your Cart</h2>
    <% if (cart.isEmpty()) { %>
    <p>Your cart is empty.</p>
    <% } else { %>
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket", "root", "");

                for (String idStr : cart) {
                    int id = Integer.parseInt(idStr);
                    String query = "SELECT * FROM products WHERE id = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setInt(1, id);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        String name = rs.getString("name");
                        String description = rs.getString("description");
                        double price = rs.getDouble("price");
                        int quantity = 1;

                        totalPrice += price * quantity;
        %>
        <tr>
            <td><%= id %></td>
            <td><%= name %></td>
            <td><%= description %></td>
            <td>$<%= price %></td>
            <td><%= quantity %></td>
            <td>$<%= price * quantity %></td>
        </tr>
        <%
                    }
                }
            } catch (Exception e) {
                out.println("Database connection problem: " + e.getMessage());
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        </tbody>
    </table>
    <h3>Total Price: $<%= totalPrice %></h3>
    <a href="buy.jsp" class="btn btn-primary">Proceed to Payment</a>
    <a href="clear.jsp" class="btn btn-primary">Clear cart</a>

    <% } %>
</div>
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













