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
        return;
    }

    List<Ride> rides = RideDAO.getUserBookings(user.getCustomerId());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking History - MagaCab</title>

    <!-- ✅ Custom CSS -->
    <style>
        /* General Page Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        /* ✅ Navbar */
        .navbar {
            background-color: #007bff;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 18px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            background-color: #dc3545;
            border-radius: 5px;
        }

        .navbar a:hover {
            background-color: #c82333;
        }

        /* ✅ Booking History Container */
        .container {
            max-width: 900px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
        }

        /* ✅ Table Styling */
        .history-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
        }

        .history-table th, .history-table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
            font-size: 16px;
        }

        .history-table th {
            background-color: #007bff;
            color: white;
        }

        .history-table tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .history-table tr:hover {
            background-color: #e9ecef;
        }

        /* ✅ Status Color Styling */
        .status-completed {
            background-color: #28a745;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
        }

        .status-pending {
            background-color: #ffc107;
            color: black;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
        }

        .status-cancelled {
            background-color: #dc3545;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
        }

        /* ✅ Responsive Table */
        @media (max-width: 768px) {
            .history-table {
                font-size: 14px;
            }

            .history-table th, .history-table td {
                padding: 8px;
            }
        }

    </style>
</head>
<body>

    <!-- ✅ Navbar -->
    <div class="navbar">
        <div>Welcome, <%= user.getName() %>!</div>
        <a href="LogoutServlet">Logout</a>
    </div>

    <!-- ✅ Booking History Container -->
    <div class="container">
        <h2>🚖 Your Booking History</h2>

        <table class="history-table">
            <thead>
                <tr>
                    <th>Booking No</th>
                    <th>Pickup</th>
                    <th>Destination</th>
                    <th>Distance (KM)</th>
                    <th>Vehicle Type</th>
                    <th>Total Price</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% if (rides.isEmpty()) { %>
                    <tr>
                        <td colspan="7" class="text-center text-muted">No bookings found.</td>
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
                            <td>
                                <% if (ride.getStatus().equals("Completed")) { %>
                                    <span class="status-completed">Completed</span>
                                <% } else if (ride.getStatus().equals("Pending")) { %>
                                    <span class="status-pending">Pending</span>
                                <% } else if (ride.getStatus().equals("Cancelled")) { %>
                                    <span class="status-cancelled">Cancelled</span>
                                <% } else { %>
                                    <span class="text-muted"><%= ride.getStatus() %></span>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                <% } %>
            </tbody>
        </table>
    </div>

</body>
</html>