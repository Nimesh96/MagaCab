<%@ page import="com.magacab.model.User" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    User user = (userSession != null) ? (User) userSession.getAttribute("user") : null;

    if (user == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if user is not logged in
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard - MagaCab</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>

    <div class="dashboard-container">
        <h2>Welcome, <%= user.getName() %>!</h2>
        <p>Email: <%= user.getEmail() %></p>
        <p>Phone: <%= user.getPhone() %></p>
        <p>NIC: <%= user.getNic() %></p>
        <p>Address: <%= user.getAddress() %></p>
        
        <a href="LogoutServlet">Logout</a>
    </div>

</body>
</html>
