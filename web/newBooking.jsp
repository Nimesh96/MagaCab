<%@ page import="com.magacab.model.User" %>
<%@ page import="com.magacab.dao.VehicleDAO" %>
<%@ page import="com.magacab.model.Vehicle" %>
<%@ page import="java.util.List" %>

<%
    HttpSession userSession = request.getSession(false);
    User user = (userSession != null) ? (User) userSession.getAttribute("user") : null;

    if (user == null) {
        response.sendRedirect("login.jsp");
    }

    // Fetch available vehicles from database
    List<Vehicle> vehicles = VehicleDAO.getAllVehicles();

    // Generate a random booking number
    int bookingNumber = (int) (Math.random() * 900000) + 100000; // 6-digit random number
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>New Booking - MagaCab</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div>Welcome, <%= user.getName() %>!</div>
        <a href="LogoutServlet">Logout</a>
    </div>

    <div class="booking-container">
        <h2>? Book a Ride</h2>

        <form action="BookRideServlet" method="post">
            <label>Booking Number:</label>
            <input type="text" name="bookingNumber" value="<%= bookingNumber %>" readonly>

            <label>Customer Name:</label>
            <input type="text" name="name" value="<%= user.getName() %>" readonly>

            <label>Address:</label>
            <input type="text" name="address" value="<%= user.getAddress() %>" readonly>

            <label>Phone:</label>
            <input type="text" name="phone" value="<%= user.getPhone() %>" readonly>

            <label>Pickup Location:</label>
            <input type="text" name="pickup" required>

            <label>Destination:</label>
            <input type="text" name="destination" required>

            <label>Distance (KM):</label>
            <input type="number" name="distance" required>

            <label>Select Vehicle Type:</label>
            <select name="vehicle_id" required>
                <% for (Vehicle vehicle : vehicles) { %>
                    <option value="<%= vehicle.getVehicleId() %>">
                        <%= vehicle.getModel() %> - LKR <%= vehicle.getPricePerKm() %>/KM
                    </option>
                <% } %>
            </select>

            <button type="submit">Submit Booking</button>
        </form>
    </div>

</body>
</html>
