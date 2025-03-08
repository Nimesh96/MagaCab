<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="com.magacab.dao.RideDAO" %>
<%@ page import="com.magacab.model.Ride" %>
<%@ page import="com.magacab.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    User user = (userSession != null) ? (User) userSession.getAttribute("user") : null;

    if (user == null) {
        response.sendRedirect("login.jsp"); 
        return;
    }

    // Fetch completed bookings for this user
    List<Ride> bookings = RideDAO.getBookingsByStatusAndUser("Completed", user.getCustomerId());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment - MagaCab</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        .container {
            width: 90%;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .btn {
            padding: 10px 15px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            color: white;
            display: inline-block;
        }
        .btn-pay {
            background-color: #28a745;
        }
        .btn-pay:hover {
            background-color: #218838;
        }
        .btn-download {
            background-color: #17a2b8;
        }
        .btn-download:hover {
            background-color: #138496;
        }
        .btn-apply {
            background-color: #ffc107;
            color: black;
        }
        .btn-apply:hover {
            background-color: #e0a800;
        }
        input[type="text"] {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-align: center;
        }
    </style>
    <script>
        function applyCoupon(bookingId) {
            let couponCode = document.getElementById("coupon_" + bookingId).value;
            let totalAmount = parseFloat(document.getElementById("amount_" + bookingId).innerText.replace("LKR ", ""));
            let discount = 0;

            if (couponCode === "DISCOUNT10") {
                discount = totalAmount * 0.10;
            } else if (couponCode === "DISCOUNT20") {
                discount = totalAmount * 0.20;
            }

            let tax = (totalAmount - discount) * 0.12;
            let finalAmount = totalAmount - discount + tax;

            document.getElementById("discount_" + bookingId).innerText = "Discount: LKR " + discount.toFixed(2);
            document.getElementById("tax_" + bookingId).innerText = "Tax (12%): LKR " + tax.toFixed(2);
            document.getElementById("final_" + bookingId).innerText = "Final Payable Amount: LKR " + finalAmount.toFixed(2);
        }

        function makePayment(bookingId) {
            console.log("Sending Booking ID: ", bookingId); // Debugging

            if (!bookingId || bookingId.trim() === "") {
                alert("Error: Booking ID is missing!");
                return;
            }

            fetch("PaymentServlet", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "bookingId=" + encodeURIComponent(bookingId)
            })
            .then(response => response.text())
            .then(data => {
                console.log("Response from server:", data); // Debugging
                if (data.trim() === "success") {
                    alert("✅ Payment Successful!");
                    location.reload();
                } else {
                    alert("❌ Payment Failed. Try Again!");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("❌ Error processing payment.");
            });
        }

        function downloadInvoice(bookingId) {
            window.open("InvoiceServlet?bookingId=" + bookingId, "_blank");
        }
    </script>
</head>
<body>

    <div class="container">
        <h2>💳 Payment Page</h2>

        <% if (bookings.isEmpty()) { %>
            <p>No completed bookings available for payment.</p>
        <% } else { %>
            <table>
                <tr>
                    <th>Booking ID</th>
                    <th>Booking No</th>
                    <th>Pickup</th>
                    <th>Destination</th>
                    <th>Total Price</th>
                    <th>Payment Status</th>
                    <th>Coupon</th>
                    <th>Final Amount</th>
                    <th>Actions</th>
                </tr>
                <% for (Ride ride : bookings) { %>
                    <tr>
                        <td><%= ride.getBookingId() %></td>
                        <td><%= ride.getBookingNumber() %></td>
                        <td><%= ride.getPickupLocation() %></td>
                        <td><%= ride.getDestination() %></td>
                        <td id="amount_<%= ride.getBookingId() %>">LKR <%= ride.getAmount() %></td>
                        <td><%= ride.getPaymentStatus() %></td>
                        <td>
                            <input type="text" id="coupon_<%= ride.getBookingId() %>" placeholder="Enter Coupon">
                            <button class="btn btn-apply" onclick="applyCoupon('<%= ride.getBookingId() %>')">Apply</button>
                        </td>
                        <td>
                            <span id="discount_<%= ride.getBookingId() %>">Discount: LKR 0.00</span><br>
                            <span id="tax_<%= ride.getBookingId() %>">Tax (12%): LKR 0.00</span><br>
                            <span id="final_<%= ride.getBookingId() %>">Final Payable Amount: LKR <%= ride.getAmount() %></span>
                        </td>
                        <td>
                            <% if (!ride.getPaymentStatus().equals("Paid")) { %>
                                <button class="btn btn-pay" onclick="makePayment('<%= ride.getBookingId() %>')">Pay Now</button>
                            <% } %>
                            <button class="btn btn-download" onclick="downloadInvoice('<%= ride.getBookingId() %>')">Download Invoice</button>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } %>
    </div>

</body>
</html>