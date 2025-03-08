<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="com.magacab.model.User" %>
<%@ page import="com.magacab.dao.RideDAO" %>
<%@ page import="com.magacab.model.Ride" %>
<%@ page import="java.util.List" %>

<%
    HttpSession userSession = request.getSession(false);
    User user = (userSession != null) ? (User) userSession.getAttribute("user") : null;

    if (user == null) {
        response.sendRedirect("login.jsp");
    }

    List<Ride> rides = RideDAO.getUserBookings(user.getCustomerId());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking History - MagaCab</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div>Welcome, <%= user.getName() %>!</div>
        <a href="LogoutServlet">Logout</a>
    </div>

    <div class="dashboard-container">
        <h2>🚖 Your Booking History</h2>

        <table border="1">
            <tr>
                <th>Booking No</th>
                <th>Pickup</th>
                <th>Destination</th>
                <th>Distance (KM)</th>
                <th>Vehicle Type</th>
                <th>Total Price</th>
                <th>Status</th>
            </tr>

            <% if (rides.isEmpty()) { %>
                <tr>
                    <td colspan="7">No bookings found.</td>
                </tr>
            <% } else { %>
                <% for (Ride ride : rides) { %>
                    <tr>
                        <td><%= ride.getBookingNumber() %></td>
                        <td><%= ride.getPickupLocation() %></td>
                        <td><%= ride.getDestination() %></td>
                        <td><%= ride.getDistance() %></td>
                        <td><%= ride.getVehicleId() %></td>
                        <td>LKR <%= ride.getAmount() %></td>
                        <td><%= ride.getStatus() %></td>
                    </tr>
                <% } %>
            <% } %>
        </table>
    </div>

</body>
</html>
