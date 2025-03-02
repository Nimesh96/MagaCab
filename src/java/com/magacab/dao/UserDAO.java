package com.magacab.dao;

import com.magacab.model.User;
import com.magacab.utils.DBConnection;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class UserDAO {

    // **Register a new user**
    public static boolean registerUser(User user) {
        String sql = "INSERT INTO users (name, address, nic, phone, email, password) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getAddress());
            stmt.setString(3, user.getNic());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getEmail());
            stmt.setString(6, user.getPassword());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // **Login user by checking email and password**
    public static User getUserByEmailAndPassword(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                    rs.getInt("customerId"),  
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("nic"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("password")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
    public static List<User> getAllCustomers() {
    List<User> customers = new ArrayList<>();
    String sql = "SELECT * FROM users ORDER BY customer_id DESC";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            User user = new User(
                rs.getInt("customer_id"),
                rs.getString("name"),
                rs.getString("address"),
                rs.getString("nic"),
                rs.getString("phone"),
                rs.getString("email"),
                rs.getString("password")
            );
            customers.add(user);

            // Debugging line
            System.out.println("✅ Fetched Customer: " + user.getCustomerId() + " - " + user.getName());
        }

        System.out.println("✅ Total Customers Loaded: " + customers.size());

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return customers;
}
    

    // ✅ Fetch customers by NIC
    public static List<User> getCustomersByNIC(String nic) {
        List<User> customers = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE nic LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + nic + "%"); // Search using wildcard
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                customers.add(new User(
                        rs.getInt("customer_id"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("nic"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("password")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // ✅ Delete a customer by ID
    public static boolean deleteCustomer(int customerId) {
        String sql = "DELETE FROM users WHERE customer_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, customerId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
    
    
    
}
