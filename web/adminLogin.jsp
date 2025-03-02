<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login - MagaCab</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>

    <div class="login-container">
        <h2>Admin Login</h2>
        <form action="AdminLoginServlet" method="post">
            <label>Username:</label>
            <input type="text" name="username" required>

            <label>Password:</label>
            <input type="password" name="password" required>

            <button type="submit">Login</button>
        </form>
    </div>

</body>
</html>
