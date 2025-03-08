package com.magacab.servlets;

import com.magacab.dao.UserDAO;
import com.magacab.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User(0, name, address, nic, phone, email, password);  // ✅ Now using customerId

        boolean success = UserDAO.registerUser(user);

        if (success) {
            response.sendRedirect("login.jsp?registerSuccess=true");
        } else {
            response.sendRedirect("register.jsp?error=true");
        }
    }
}
