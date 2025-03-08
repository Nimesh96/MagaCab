<%@ page import="com.magacab.dao.RideDAO, com.magacab.model.Ride" %>
<%@ page import="java.util.List" %>

<%
    int userId = (Integer) session.getAttribute("userId");
    List<Ride> unpaidBookings = RideDAO.getUnpaidBookings(userId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payments - MagaCab</title>
</head>
<body>
    <h2>? Pending Payments</h2>
    <table border="1">
        <tr>
            <th>Booking No</th>
            <th>Amount</th>
            <th>Action</th>
        </tr>

        <% for (Ride ride : unpaidBookings) { %>
            <tr>
                <td><%= ride.getBookingNumber() %></td>
                <td>LKR <%= ride.getAmount() %></td>
                <td>
                    <form action="MakePaymentServlet" method="post">
                        <input type="hidden" name="bookingNumber" value="<%= ride.getBookingNumber() %>">
                        <button type="submit">Pay Now</button>
                    </form>
                </td>
            </tr>
        <% } %>
    </table>
</body>
</html>