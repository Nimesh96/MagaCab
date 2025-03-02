package com.magacab.dao;

import com.magacab.model.User;
import com.magacab.utils.DBConnection;
import java.sql.*;

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
}
