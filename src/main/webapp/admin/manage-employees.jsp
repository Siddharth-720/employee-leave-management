<%@ page import="com.example.leave.dao.UserDao" %>
<%@ page import="com.example.leave.model.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Employees</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h2>Manage Employees</h2>
        <a href="dashboard.jsp">Back to Dashboard</a>

        <h3>Add Employee</h3>
        <form action="../admin" method="post">
            <input type="hidden" name="action" value="addUser">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <button type="submit">Add Employee</button>
        </form>

        <h3>All Employees</h3>
        <% 
            UserDao userDao = new UserDao();
            List<User> users = userDao.getAllEmployees();
        %>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Vacation</th>
                <th>Sick</th>
                <th>Personal</th>
                <th>Action</th>
            </tr>
            <% for (User u : users) { %>
                <tr>
                    <td><%= u.getId() %></td>
                    <td><%= u.getName() %></td>
                    <td><%= u.getEmail() %></td>
                    <td><%= u.getVacationBalance() %></td>
                    <td><%= u.getSickBalance() %></td>
                    <td><%= u.getPersonalBalance() %></td>
                    <td>
                        <form action="../admin" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="deleteUser">
                            <input type="hidden" name="id" value="<%= u.getId() %>">
                            <button type="submit">Delete</button>
                        </form>
                        <%-- Update form can be added here --%>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
