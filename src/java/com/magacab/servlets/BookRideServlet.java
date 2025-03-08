package com.magacab.servlets;

import com.magacab.dao.RideDAO;
import com.magacab.model.Ride;
import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/BookRideServlet")
public class BookRideServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Debugging: Print all incoming request parameters
            System.out.println("=== RECEIVED BOOKING DATA ===");
            System.out.println("Booking Number: " + request.getParameter("bookingNumber"));
            System.out.println("Pickup Location: " + request.getParameter("pickup"));
            System.out.println("Destination: " + request.getParameter("destination"));
            System.out.println("Distance: " + request.getParameter("distance"));
            System.out.println("Vehicle ID: " + request.getParameter("vehicle_id"));

            // Retrieve session user details
            HttpSession userSession = request.getSession(false);
            if (userSession == null || userSession.getAttribute("user") == null) {
                System.out.println("🚨 Error: User session not found.");
                response.sendRedirect("newBooking.jsp?error=true");
                return;
            }

            com.magacab.model.User user = (com.magacab.model.User) userSession.getAttribute("user");
            int customerId = user.getCustomerId(); // Assuming this is stored in the session

            // Parse form values
            int bookingNumber = Integer.parseInt(request.getParameter("bookingNumber"));
            String pickup = request.getParameter("pickup");
            String destination = request.getParameter("destination");
            int distance = Integer.parseInt(request.getParameter("distance"));
            int vehicleId = Integer.parseInt(request.getParameter("vehicle_id"));

            // Calculate total price (example: 50 per KM)
            BigDecimal totalAmount = new BigDecimal(distance * 50);

            // ✅ Create Ride object with bookingId as 0 (Auto-incremented in DB)
            Ride ride = new Ride(
                0,            // ✅ Auto-increment bookingId
                customerId,   // ✅ Correct order
                bookingNumber,
                pickup,
                destination,
                distance,
                vehicleId,
                0,  // Default driver ID (if not assigned yet)
                totalAmount,
                "Pending",
                "Unpaid"
            );

            // Debugging: Print ride object details
            System.out.println("✅ Created Ride Object: " + ride);

            // Insert into database
            boolean success = RideDAO.bookRide(ride);

            if (success) {
                System.out.println("✅ Booking Successfully Inserted!");
                response.sendRedirect("newBooking.jsp?rideSuccess=true");
            } else {
                System.out.println("❌ Booking Insertion Failed.");
                response.sendRedirect("newBooking.jsp?error=true");
            }

        } catch (NumberFormatException e) {
            System.out.println("🚨 Number Format Exception: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("newBooking.jsp?error=invalidNumber");
        } catch (Exception e) {
            System.out.println("🚨 General Exception in BookRideServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("newBooking.jsp?error=true");
        }
    }
}