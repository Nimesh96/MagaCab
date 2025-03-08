<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - MagaCab</title>
    <link rel="stylesheet" type="text/css" href="css/auth.css">
</head>
<body>

    <div class="auth-container">
        <h2>📝 Register for MagaCab</h2>

        <%-- Show error message if registration fails --%>
        <% if (request.getParameter("error") != null) { %>
            <p class="error-message">❌ Registration Failed. Try again.</p>
        <% } %>

        <form action="RegisterServlet" method="post">
            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">Register</button>
        </form>

        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>

</body>
</html>