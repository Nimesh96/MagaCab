package com.magacab.dao;

import com.magacab.model.Driver;
import com.magacab.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriverDAO {

    // ✅ Get all drivers
    public static List<Driver> getAllDrivers() {
        List<Driver> drivers = new ArrayList<>();
        String sql = "SELECT * FROM drivers";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Driver driver = new Driver(
                        rs.getInt("driver_id"),
                        rs.getString("name"),
                        rs.getString("nic"),
                        rs.getString("phone"),
                        rs.getString("license_number"),
                        rs.getInt("vehicle_id")
                );
                drivers.add(driver);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return drivers;
    }

    // ✅ Insert a new driver
    public static boolean addDriver(String name, String nic, String phone, String licenseNumber, int vehicleId) {
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO drivers (name, nic, phone, license_number, vehicle_id) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, nic);
            stmt.setString(3, phone);
            stmt.setString(4, licenseNumber);
            stmt.setInt(5, vehicleId);

            int rowsInserted = stmt.executeUpdate();
            conn.close();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Update driver
public static boolean updateDriver(int driverId, String name, String nic, String phone, String licenseNumber, int vehicleId) {
    try {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE drivers SET name = ?, nic = ?, phone = ?, license_number = ?, vehicle_id = ? WHERE driver_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, nic);
        stmt.setString(3, phone);
        stmt.setString(4, licenseNumber);
        stmt.setInt(5, vehicleId);
        stmt.setInt(6, driverId);

        int rowsUpdated = stmt.executeUpdate();
        conn.close();
        return rowsUpdated > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

    // ✅ Delete a driver
    public static boolean deleteDriver(int driverId) {
        String sql = "DELETE FROM drivers WHERE driver_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, driverId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
     // ✅ Search for drivers by NIC or Name
    public static List<Driver> searchDrivers(String searchQuery) {
        List<Driver> drivers = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM drivers WHERE nic LIKE ? OR name LIKE ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + searchQuery + "%");
            stmt.setString(2, "%" + searchQuery + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                drivers.add(new Driver(
                    rs.getInt("driver_id"),
                    rs.getString("name"),
                    rs.getString("nic"),
                    rs.getString("phone"),
                    rs.getString("license_number"),
                    rs.getInt("vehicle_id")
                ));
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return drivers;
    }
    
    
    
    
}