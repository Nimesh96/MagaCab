<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.magacab.model.Ride" %>
<%@ page import="com.magacab.model.Driver" %>
<%@ page import="com.magacab.dao.RideDAO" %>

<%
    // Get session and driver details
    HttpSession sessionObj = request.getSession(false);
    Driver driver = (sessionObj != null) ? (Driver) sessionObj.getAttribute("driver") : null;

    // Redirect if not logged in
    if (driver == null) {
        response.sendRedirect("driverLogin.jsp");
        return;
    }

    int driverId = driver.getDriverId();
    List<Ride> assignedRides = RideDAO.getAssignedRides(driverId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Dashboard - MagaCab</title>

    <!-- ✅ Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <style>
        /* General Styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
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

        /* ✅ Container */
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
        .ride-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
        }

        .ride-table th, .ride-table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
            font-size: 16px;
        }

        .ride-table th {
            background-color: #007bff;
            color: white;
        }

        .ride-table tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .ride-table tr:hover {
            background-color: #e9ecef;
        }

        /* ✅ Status Colors */
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

        /* ✅ Responsive */
        @media (max-width: 768px) {
            .ride-table {
                font-size: 14px;
            }

            .ride-table th, .ride-table td {
                padding: 8px;
            }
        }
    </style>
</head>
<body>

    <!-- ✅ Navbar -->
    <div class="navbar">
        <div>Welcome, <%= driver.getName() %>!</div>
        <a href="LogoutServlet">Logout</a>
    </div>

    <!-- ✅ Dashboard Container -->
    <div class="container">
        <h2>🚖 Your Assigned Rides</h2>

        <table class="ride-table">
            <thead>
                <tr>
                    <th>Booking No</th>
                    <th>Pickup</th>
                    <th>Destination</th>
                    <th>Distance (KM)</th>
                    <th>Amount</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% if (assignedRides.isEmpty()) { %>
                    <tr>
                        <td colspan="6" class="text-center text-muted">No assigned rides yet.</td>
                    </tr>
                <% } else { %>
                    <% for (Ride ride : assignedRides) { %>
                        <tr>
                            <td><%= ride.getBookingNumber() %></td>
                            <td><%= ride.getPickupLocation() %></td>
                            <td><%= ride.getDestination() %></td>
                            <td><%= ride.getDistance() %> km</td>
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

    <!-- ✅ Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>