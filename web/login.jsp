<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login - MagaCab</title>
    <link rel="stylesheet" type="text/css" href="css/auth.css">
</head>
<body>

    <div class="auth-container">
        <h2>🔑 Login to MagaCab</h2>

        
        <% if (request.getParameter("error") != null) { %>
            <p class="error-message">❌ Invalid Email or Password. Please try again.</p>
        <% } %>

        <form action="LoginServlet" method="post">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">Login</button>
        </form>

        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>

</body>
</html>