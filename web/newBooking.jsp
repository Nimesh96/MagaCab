<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.magacab.model.User" %>
<%@ page import="com.magacab.dao.VehicleDAO" %>
<%@ page import="com.magacab.model.Vehicle" %>
<%@ page import="java.util.List" %>

<%
    // Get user session
    HttpSession userSession = request.getSession(false);
    User user = (userSession != null) ? (User) userSession.getAttribute("user") : null;

    if (user == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if not logged in
        return;
    }

    // Fetch available vehicles from database
    List<Vehicle> vehicles = VehicleDAO.getAllVehicles();

    // Generate a random booking number (6-digit)
    int bookingNumber = (int) (Math.random() * 900000) + 100000;

    // Check booking response messages
    String rideSuccess = request.getParameter("rideSuccess");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>New Booking - MagaCab</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    
    <script>
        function calculatePrice() {
            let distance = document.getElementById("distance").value;
            let vehicleDropdown = document.getElementById("vehicle_id");
            let selectedOption = vehicleDropdown.options[vehicleDropdown.selectedIndex];
            let pricePerKm = selectedOption.getAttribute("data-price");

            if (distance && pricePerKm) {
                let totalPrice = parseFloat(distance) * parseFloat(pricePerKm);
                document.getElementById("totalPrice").innerText = "LKR " + totalPrice.toFixed(2);
                document.getElementById("totalAmount").value = totalPrice.toFixed(2); // Store total in hidden input
            } else {
                document.getElementById("totalPrice").innerText = "LKR 0.00";
                document.getElementById("totalAmount").value = "0.00";
            }
        }
    </script>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div>Welcome, <%= user.getName() %>!</div>
        <a href="LogoutServlet">Logout</a>
    </div>

    <div class="booking-container">
        <h2>🚖 Book a Ride</h2>

        <!-- Success Message -->
        <% if ("true".equals(rideSuccess)) { %>
            <p class="success-message">🎉 Booking Successful!</p>
        <% } %>

        <!-- Error Message -->
        <% if ("true".equals(error)) { %>
            <p class="error-message">⚠️ Booking Failed. Try Again.</p>
        <% } %>

        <!-- Booking Form -->
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
            <input type="number" id="distance" name="distance" required oninput="calculatePrice()">

            <label>Select Vehicle Type:</label>
            <select id="vehicle_id" name="vehicle_id" required onchange="calculatePrice()">
                <% for (Vehicle vehicle : vehicles) { %>
                    <option value="<%= vehicle.getVehicleId() %>" data-price="<%= vehicle.getPricePerKm() %>">
                        <%= vehicle.getModel() %> - LKR <%= vehicle.getPricePerKm() %>/KM
                    </option>
                <% } %>
            </select>

            <!-- Hidden field for total amount -->
            <input type="hidden" id="totalAmount" name="totalAmount" value="0.00">

            <h3>Total Price: <span id="totalPrice">LKR 0.00</span></h3>

            <button type="submit">Submit Booking</button>
        </form>
    </div>

</body>
</html>