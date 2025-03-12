<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Login - MagaCab</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Background Gradient */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ff6f61, #ff9671);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Login Card */
        .auth-container {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.15);
            text-align: center;
            width: 100%;
            max-width: 400px;
            animation: fadeIn 0.8s ease-in-out;
        }

        .auth-container h2 {
            color: #ff6f61;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
        }

        /* Fade-In Animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>

    <div class="auth-container">
        <h2>🚖 Driver Login</h2>

        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger text-center" role="alert">
                ❌ Invalid Name or NIC. Please try again.
            </div>
        <% } %>

        <form action="DriverLoginServlet" method="post">
            <div class="mb-3 text-start">
                <label for="name" class="form-label fw-bold">Name:</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>

            <div class="mb-3 text-start">
                <label for="nic" class="form-label fw-bold">NIC:</label>
                <input type="password" class="form-control" id="nic" name="nic" required>
            </div>

            <button type="submit" class="btn btn-danger w-100">Login</button>
        </form>
    </div>

    <!-- Bootstrap 5 JS (Optional, for better interactivity) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>