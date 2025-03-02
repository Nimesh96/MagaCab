package com.magacab.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.magacab.dao.RideDAO;

@WebServlet("/UpdateBookingServlet")
public class UpdateBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingNumber = Integer.parseInt(request.getParameter("bookingNumber"));
        String status = request.getParameter("status");

        boolean updated = RideDAO.updateBookingStatus(bookingNumber, status);

        if (updated) {
            response.sendRedirect("manageBookings.jsp?success=true");
        } else {
            response.sendRedirect("manageBookings.jsp?error=true");
        }
    }
}
