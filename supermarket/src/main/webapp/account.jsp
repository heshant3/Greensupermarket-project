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
                <a href="user_logout.jsp" class="nav-link">Logout</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-4">
    <%
        String loggedUserEmail = (String) session.getAttribute("userEmail");
        if(loggedUserEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/supermarket", "root", "");

            String sql = "SELECT * FROM orders WHERE emailaddress = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, loggedUserEmail);

            resultSet = preparedStatement.executeQuery();
    %>
    <div class="header-custom">
        <h2 class="text-center">Your Order History</h2>
    </div>
    <div class="table-responsive table-custom mt-3">
        <table class="table table-hover">
            <thead class="thead-dark">
            <tr>
                <th>Products</th>
                <th>Date</th>
                <th>Status</th>
                <th>Payment</th>
            </tr>
            </thead>
            <tbody>
            <%
                while(resultSet.next()) {
            %>
            <tr>
                <td><%= resultSet.getString("product_data") %></td>
                <td><%= resultSet.getString("ordered_time") %></td>
                <td><%= resultSet.getString("delivery") %></td>
                <td><%= resultSet.getString("status") %></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { /* Ignored */ }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { /* Ignored */ }
            if (connection != null) try { connection.close(); } catch (SQLException e) { /* Ignored */ }
        }
    %>
</div>



</body>
</html>
