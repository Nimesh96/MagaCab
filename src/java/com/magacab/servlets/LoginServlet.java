package com.magacab.servlets;

import com.magacab.dao.UserDAO;
import com.magacab.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate user from database
        User user = UserDAO.validateUser(email, password);

        if (user != null) {
            // Create session and store user details
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("userDashboard.jsp"); // Redirect to user dashboard
        } else {
            response.sendRedirect("login.jsp?error=true"); // Show error message
        }
    }
}
