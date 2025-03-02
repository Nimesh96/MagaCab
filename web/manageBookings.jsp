<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="com.magacab.dao.RideDAO" %>
<%@ page import="com.magacab.model.Ride" %>
<%@ page import="java.util.List" %>

<%
    // Get filter parameter from the request (default to "All")
    String selectedStatus = request.getParameter("status");
    if (selectedStatus == null || selectedStatus.equals("All")) {
        selectedStatus = "All";
    }

    // Fetch bookings based on selected status
    List<Ride> bookings;
    if (selectedStatus.equals("All")) {
        bookings = RideDAO.getAllBookings();  // Fetch all bookings
    } else {
        bookings = RideDAO.getBookingsByStatus(selectedStatus);  // Fetch filtered bookings
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Bookings - MagaCab</title>
    <link rel="stylesheet" type="text/css" href="css/adminStyles.css">
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div class="navbar-left">
            <h2>🚖 MagaCab - Admin Panel</h2>
        </div>
        <div class="navbar-right">
            <a href="AdminLogoutServlet" class="logout-btn">Logout</a>
        </div>
    </div>

    <!-- Sidebar + Content -->
    <div class="admin-container">

        <!-- Sidebar -->
        <div class="sidebar">
            <ul>
                <li><a href="manageBookings.jsp">📑 Manage Bookings</a></li>
                <li><a href="manageCustomers.jsp">👥 Manage Customers</a></li>
                <li><a href="manageVehicles.jsp">🚗 Manage Vehicles</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="content">
            <h2>📑 Manage Bookings</h2>

            <!-- Booking Status Filter -->
            <form method="GET" action="manageBookings.jsp">
                <label for="statusFilter">Filter by Status:</label>
                <select name="status" id="statusFilter" onchange="this.form.submit()">
                    <option value="All" <%= selectedStatus.equals("All") ? "selected" : "" %>>All</option>
                    <option value="Pending" <%= selectedStatus.equals("Pending") ? "selected" : "" %>>Pending</option>
                    <option value="Completed" <%= selectedStatus.equals("Completed") ? "selected" : "" %>>Completed</option>
                    <option value="Cancelled" <%= selectedStatus.equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                </select>
            </form>

            <br>

            <!-- Booking Table -->
            <table border="1">
                <tr>
                    <th>Booking No</th>
                    <th>Customer ID</th>
                    <th>Pickup</th>
                    <th>Destination</th>
                    <th>Distance (KM)</th>
                    <th>Vehicle Type</th>
                    <th>Total Price</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>

                <% if (bookings.isEmpty()) { %>
                    <tr>
                        <td colspan="9">No bookings found.</td>
                    </tr>
                <% } else { %>
                    <% for (Ride ride : bookings) { %>
                        <tr>
                            <td><%= ride.getBookingNumber() %></td>
                            <td><%= ride.getCustomerId() %></td>
                            <td><%= ride.getPickupLocation() %></td>
                            <td><%= ride.getDestination() %></td>
                            <td><%= ride.getDistance() %></td>
                            <td><%= ride.getVehicleId() %></td>
                            <td>LKR <%= ride.getAmount() %></td>
                            <td>
                                <form action="UpdateBookingServlet" method="post">
                                    <input type="hidden" name="bookingNumber" value="<%= ride.getBookingNumber() %>">
                                    <select name="status">
                                        <option value="Pending" <%= ride.getStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
                                        <option value="Completed" <%= ride.getStatus().equals("Completed") ? "selected" : "" %>>Completed</option>
                                        <option value="Cancelled" <%= ride.getStatus().equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                                    </select>
                            </td>

                            <td>
                                    <button type="submit">Update</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                <% } %>
            </table>

        </div>

    </div>

</body>
</html>
