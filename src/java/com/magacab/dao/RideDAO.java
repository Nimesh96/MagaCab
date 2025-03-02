package com.magacab.dao;

import com.magacab.model.Ride;
import com.magacab.utils.DBConnection;
import java.sql.*;

public class RideDAO {

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
}
