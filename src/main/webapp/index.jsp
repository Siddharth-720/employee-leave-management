<!DOCTYPE html>
<html>
<head>
    <title>Employee Leave Management System</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <form action="login" method="post">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <button type="submit">Login</button>
        </form>
        <% if (request.getParameter("error") != null) { %>
            <p class="error">Invalid email or password.</p>
        <% } %>
    </div>
</body>
</html>
