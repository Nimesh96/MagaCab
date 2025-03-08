package com.magacab.dao;

import com.magacab.model.Ride;
import com.magacab.utils.DBConnection;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class RideDAO {

    // ✅ Book a Ride
    public static boolean bookRide(Ride ride) {
        String sql = "INSERT INTO bookings (customer_id, booking_number, pickup_location, destination, distance, vehicle_id, amount, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, ride.getCustomerId());
            stmt.setInt(2, ride.getBookingNumber());
            stmt.setString(3, ride.getPickupLocation());
            stmt.setString(4, ride.getDestination());
            stmt.setInt(5, ride.getDistance());
            stmt.setInt(6, ride.getVehicleId());
            stmt.setBigDecimal(7, ride.getAmount());
            stmt.setString(8, "Pending"); // Default booking status

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // ✅ Fetch User Bookings (For Customers)
    public static List<Ride> getUserBookings(int customerId) {
        List<Ride> rides = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE customer_id = ? ORDER BY booking_number DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, customerId);
            System.out.println("Executing query with customerId: " + customerId); // Debugging

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                rides.add(new Ride(
                    rs.getInt("customer_id"),
                    rs.getInt("booking_number"),
                    rs.getString("pickup_location"),
                    rs.getString("destination"),
                    rs.getInt("distance"),
                    rs.getInt("vehicle_id"),
                    rs.getBigDecimal("amount"),
                    rs.getString("status")
                ));
            }
            System.out.println("Total rides fetched: " + rides.size()); // Debugging
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rides;
    }

    // ✅ Fetch All Bookings (For Admin)
    public static List<Ride> getAllBookings() {
        List<Ride> rides = new ArrayList<>();
        String sql = "SELECT * FROM bookings ORDER BY booking_number DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                rides.add(new Ride(
                    rs.getInt("customer_id"),
                    rs.getInt("booking_number"),
                    rs.getString("pickup_location"),
                    rs.getString("destination"),
                    rs.getInt("distance"),
                    rs.getInt("vehicle_id"),
                    rs.getBigDecimal("amount"),
                    rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rides;
    }

    // ✅ Update Booking Status (For Admin)
    public static boolean updateBookingStatus(int bookingNumber, String status) {
        String sql = "UPDATE bookings SET status = ? WHERE booking_number = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, bookingNumber);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
        
    }
        
        
        
public static List<Ride> getBookingsByStatus(String status) {
    List<Ride> rides = new ArrayList<>();
    String sql = "SELECT * FROM bookings WHERE status = ? ORDER BY booking_number DESC";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, status);  // Set the selected status filter
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            rides.add(new Ride(
                rs.getInt("customer_id"),
                rs.getInt("booking_number"),
                rs.getString("pickup_location"),
                rs.getString("destination"),
                rs.getInt("distance"),
                rs.getInt("vehicle_id"),
                rs.getBigDecimal("amount"),
                rs.getString("status")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return rides;
}

        
        
    }

