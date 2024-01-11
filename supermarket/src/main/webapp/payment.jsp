<%@ page import="com.example.supermarket.DBConnect" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.supermarket.PaymentService" %>
<%@ page import="com.paypal.base.rest.PayPalRESTException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <link rel="stylesheet" href="css/home.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <title>GREEN Supermarket</title>
</head><style>
    .header-custom {
        background-color: #2e8b57; /* Dark Green header */
    }
    .btn-custom {
        background-color: #276749; /* Dark Green button */
        color: white;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    .btn-custom:hover {
        background-color: #1F4421;
    } .bg-dark-green {
          background-color: #276749;
      }
    .footer{
        margin-top: 100px;
    }
    .box{
        margin-top: 100px;
    }
</style>
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

<div class="container mx-auto mt-5 box">
    <div class="max-w-md mx-auto bg-white p-6 rounded shadow-md">
        <h1 class="text-xl font-semibold mb-4">Finalize Your Transaction</h1>
        <p class="mb-4">Click the button to proceed with payment via PayPal, ensuring a safe and secure transaction.</p>
        <%
            Cookie[] cookies = request.getCookies();
            String productId = null;
            String orderNumber = null;
            String price = null;

            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("productId".equals(cookie.getName())) {
                        productId = cookie.getValue();
                    } else if ("orderNumber".equals(cookie.getName())) {
                        orderNumber = cookie.getValue();
                    } else if ("price".equals(cookie.getName())) {
                        price = cookie.getValue();
                    }
                }
            };

            System.out.println(orderNumber);

            PaymentService paymentService = new PaymentService();
            String paypalApprovalLink = null;
            try {
                paypalApprovalLink = paymentService.createPayment(10.00);
            } catch (PayPalRESTException e) {
                throw new RuntimeException(e);
            }
        %>
        <a href="<%= paypalApprovalLink %>" class="btn-custom w-full py-2 px-4 rounded focus:outline-none focus:shadow-outline text-center">Proceed to PayPal</a>
    </div>
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






































