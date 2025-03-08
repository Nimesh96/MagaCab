package com.magacab.servlets;

import com.magacab.dao.UserDAO;


import com.magacab.model.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        if (name == null || email == null || phone == null || password == null || 
            name.isEmpty() || email.isEmpty() || phone.isEmpty() || password.isEmpty()) {
            response.sendRedirect("register.jsp?error=missing_fields");
            return;
        }

        User newUser = new User(0, name, "default address", "default nic", phone, email, password);
        boolean success = UserDAO.registerUser(newUser);

        if (success) {
            response.sendRedirect("login.jsp?success=registered");
        } else {
            response.sendRedirect("register.jsp?error=failed");
        }
    }
}