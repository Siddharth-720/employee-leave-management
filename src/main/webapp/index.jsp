<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Employee Leave Management</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="main-container">
        <div class="login-card">
            <h1>Employee Leave Management System</h1>
            <p>Your one-step solution for managing leaves efficiently.</p>
            <h2>Login to Your Account</h2>
            <form action="login" method="post">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="btn-primary">Login</button>
            </form>
            <% if (request.getParameter("error") != null) { %>
                <p class="error-message">Invalid email or password.</p>
            <% } %>
            <p class="register-link">Don't have an account? <a href="#">Register Here</a></p>
        </div>
    </div>
</body>
</html>
