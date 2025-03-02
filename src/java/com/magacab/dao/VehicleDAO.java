package com.magacab.dao;

import com.magacab.model.Vehicle;
import com.magacab.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;  // ✅ Import BigDecimal

public class VehicleDAO {

    public static List<Vehicle> getAllVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        String sql = "SELECT * FROM vehicles";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                vehicles.add(new Vehicle(
                    rs.getInt("vehicle_id"),
                    rs.getString("model"),
                    rs.getString("plate_number"),
                    rs.getInt("capacity"),
                    rs.getBigDecimal("price_per_km")  // ✅ Correct retrieval
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicles;
    }

    public static BigDecimal getPricePerKm(int vehicleId) {
        String sql = "SELECT price_per_km FROM vehicles WHERE vehicle_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, vehicleId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getBigDecimal("price_per_km");  // ✅ Ensure BigDecimal is returned
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;  // ✅ Return default value if not found
    }
}
