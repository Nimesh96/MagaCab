package com.magacab.servlets;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.http.HttpSession;
import com.magacab.model.User;
import com.magacab.dao.VehicleDAO;
import com.magacab.dao.RideDAO;
import com.magacab.model.Ride;

@WebServlet("/BookRideServlet")
public class BookRideServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int bookingNumber = Integer.parseInt(request.getParameter("bookingNumber"));
            String pickup = request.getParameter("pickup");
            String destination = request.getParameter("destination");
            int distance = Integer.parseInt(request.getParameter("distance"));
            int vehicleId = Integer.parseInt(request.getParameter("vehicle_id"));

            // Get vehicle price per KM from database
            BigDecimal pricePerKm = VehicleDAO.getPricePerKm(vehicleId);  // ✅ Now correctly returns BigDecimal
            BigDecimal totalAmount = pricePerKm.multiply(BigDecimal.valueOf(distance));  // ✅ Fix multiplication

            // Create Ride object
            Ride ride = new Ride(0, user.getCustomerId(), bookingNumber, pickup, destination, distance, vehicleId, totalAmount, "Pending");

            // Save ride to database
            boolean success = RideDAO.bookRide(ride);

            if (success) {
                response.sendRedirect("userDashboard.jsp?rideSuccess=true");
            } else {
                response.sendRedirect("newBooking.jsp?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("newBooking.jsp?error=true");
        }
    }
}
