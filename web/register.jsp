<%-- 
    Document   : register
    Created on : Mar 2, 2025, 2:32:12 AM
    Author     : nimeshbuddika
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - MagaCab</title>
     <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>

    <div class="register-container">
        <h2>Register for MagaCab</h2>

        <%-- Display error message if registration fails --%>
        <% if (request.getParameter("error") != null) { %>
            <p class="error-message">Registration Failed! Try again.</p>
        <% } %>

        <%-- Display success message if registration is successful --%>
        <% if (request.getParameter("success") != null) { %>
            <p class="success-message">Registration Successful! <a href="login.jsp">Login here</a></p>
        <% } %>

        <form action="RegisterServlet" method="post">
            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>

            <label for="nic">NIC:</label>
            <input type="text" id="nic" name="nic" required>

            <label for="phone">Phone Number:</label>
            <input type="text" id="phone" name="phone" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">Register</button>
        </form>

        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>

</body>
</html>

