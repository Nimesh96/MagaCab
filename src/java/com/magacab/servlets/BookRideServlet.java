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
            
            System.out.println("=== RECEIVED BOOKING DATA ===");
            System.out.println("Booking Number: " + request.getParameter("bookingNumber"));
            System.out.println("Pickup Location: " + request.getParameter("pickup"));
            System.out.println("Destination: " + request.getParameter("destination"));
            System.out.println("Distance: " + request.getParameter("distance"));
            System.out.println("Vehicle ID: " + request.getParameter("vehicle_id"));

            
            HttpSession userSession = request.getSession(false);
            if (userSession == null || userSession.getAttribute("user") == null) {
                System.out.println("🚨 Error: User session not found.");
                response.sendRedirect("newBooking.jsp?error=true");
                return;
            }

            com.magacab.model.User user = (com.magacab.model.User) userSession.getAttribute("user");
            int customerId = user.getCustomerId(); 

            
            int bookingNumber = Integer.parseInt(request.getParameter("bookingNumber"));
            String pickup = request.getParameter("pickup");
            String destination = request.getParameter("destination");
            int distance = Integer.parseInt(request.getParameter("distance"));
            int vehicleId = Integer.parseInt(request.getParameter("vehicle_id"));

            
            BigDecimal totalAmount = new BigDecimal(distance * 50);

            
            Ride ride = new Ride(
                0,            
                customerId,   
                bookingNumber,
                pickup,
                destination,
                distance,
                vehicleId,
                0,  
                totalAmount,
                "Pending",
                "Unpaid"
            );

            
            System.out.println("✅ Created Ride Object: " + ride);

            
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