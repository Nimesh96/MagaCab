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

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Background Gradient */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #007bff, #6610f2);
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* Navigation Bar */
        .navbar {
            width: 100%;
            background-color: rgba(0, 123, 255, 0.9);
            box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.1);
        }

        /* Dashboard Container */
        .dashboard-container {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.15);
            text-align: center;
            width: 100%;
            max-width: 600px;
            margin-top: 80px;
            animation: fadeIn 0.8s ease-in-out;
        }

        /* Fade-in Animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>

    
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <span class="navbar-brand fw-bold">Welcome, <%= user.getName() %>!</span>
            <a href="LogoutServlet" class="btn btn-danger">Logout</a>
        </div>
    </nav>

    
    <div class="container d-flex justify-content-center">
        <div class="dashboard-container">
            <h2 class="text-primary fw-bold">User Details</h2>
            <p><strong>Email:</strong> <%= user.getEmail() %></p>
            <p><strong>Phone:</strong> <%= user.getPhone() %></p>
            <p><strong>NIC:</strong> <%= user.getNic() %></p>
            <p><strong>Address:</strong> <%= user.getAddress() %></p>

            
            <div class="d-flex justify-content-center flex-wrap gap-3 mt-3">
                <a href="newBooking.jsp" class="btn btn-success fw-bold px-4">
                    🚖 Book a Ride
                </a>
                <a href="bookingHistory.jsp" class="btn btn-info fw-bold px-4 text-white">
                    📜 View Booking History
                </a>
                <a href="payments.jsp" class="btn btn-warning fw-bold px-4">
                    💳 Go to Payment
                </a>
                <a href="help.html" class="btn fw-bold px-4 text-white" style="background-color: #6610f2;">
                    ❓ Help
                </a> 
            </div>
        </div>
    </div>

    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>