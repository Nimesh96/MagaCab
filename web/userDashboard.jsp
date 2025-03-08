<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<%@ page import="com.magacab.model.User" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    User user = (userSession != null) ? (User) userSession.getAttribute("user") : null;

    if (user == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if not logged in
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard - MagaCab</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <style>
        /* Top Navigation Bar */
        .navbar {
            background-color: #007bff;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            color: white;
            font-size: 18px;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 5px;
            background-color: #dc3545;
        }

        .navbar a:hover {
            background-color: #c82333;
        }

        /* Main Content */
        .dashboard-container {
            width: 50%;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .dashboard-container h2 {
            margin-bottom: 10px;
        }

        .dashboard-container p {
            font-size: 16px;
            margin: 5px 0;
        }

        /* Button Styles */
        .button-container {
            margin-top: 20px;
        }

        .btn {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            color: white;
            display: inline-block;
            margin: 5px;
        }

        .btn-book {
            background-color: #28a745;
        }

        .btn-book:hover {
            background-color: #218838;
        }

        .btn-history {
            background-color: #17a2b8;
        }

        .btn-history:hover {
            background-color: #138496;
        }

        /* ✅ New Payment Button */
        .btn-payment {
            background-color: #ffc107;
            color: black;
        }

        .btn-payment:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>

    <!-- Top Navigation Bar -->
    <div class="navbar">
        <div>Welcome, <%= user.getName() %>!</div>
        <a href="LogoutServlet">Logout</a>
    </div>

    <!-- User Dashboard Content -->
    <div class="dashboard-container">
        <h2>User Details</h2>
        <p><strong>Email:</strong> <%= user.getEmail() %></p>
        <p><strong>Phone:</strong> <%= user.getPhone() %></p>
        <p><strong>NIC:</strong> <%= user.getNic() %></p>
        <p><strong>Address:</strong> <%= user.getAddress() %></p>

        <!-- Buttons -->
            <div class="d-flex justify-content-center gap-3 mt-3">
                <a href="newBooking.jsp" class="btn btn-success fw-bold px-4">
                    🚖 Book a Ride
                </a>
                <a href="bookingHistory.jsp" class="btn btn-info fw-bold px-4 text-white">
                    📜 View Booking History
                </a>
                <a href="payments.jsp" class="btn btn-warning fw-bold px-4">
                    💳 Go to Payment
                </a>
                    <a href="help.html" class="btn fw-bold px-4" style="background-color: #6610f2; color: white;">
                      ❓ Help
                    </a> <!-- ✅ Custom Purple Help Button -->
            </div>
    </div>

</body>
</html>