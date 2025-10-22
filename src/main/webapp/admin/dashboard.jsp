<%@ page import="com.example.leave.model.User" %>
<%@ page import="com.example.leave.dao.UserDao" %>
<%@ page import="com.example.leave.dao.LeaveDao" %>
<%@ page import="com.example.leave.model.Leave" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
    <div class="container">
        <% User user = (User) session.getAttribute("user"); %>
        <h2>Welcome, <%= user.getName() %> (Admin)</h2>
        <a href="../logout">Logout</a>

        <h3>Manage Employees</h3>
        <a href="manage-employees.jsp">Add, Update, or Delete Employees</a>

        <h3>All Leave Requests</h3>
        <% 
            LeaveDao leaveDao = new LeaveDao();
            List<Leave> leaves = leaveDao.getAllLeaveRequests();
        %>
        <table>
            <tr>
                <th>Employee</th>
                <th>Leave Type</th>
                <th>From</th>
                <th>To</th>
                <th>Reason</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <% for (Leave leave : leaves) { %>
                <tr>
                    <td>
                        <%-- This requires a method in UserDao to get user by ID, or a join in LeaveDao --%>
                        <%-- For simplicity, we'll just show the ID. A better implementation would show the name. --%>
                        Employee ID: <%= leave.getEmployeeId() %>
                    </td>
                    <td><%= leave.getLeaveType() %></td>
                    <td><%= leave.getFromDate() %></td>
                    <td><%= leave.getToDate() %></td>
                    <td><%= leave.getReason() %></td>
                    <td><%= leave.getStatus() %></td>
                    <td>
                        <% if ("Pending".equals(leave.getStatus())) { %>
                            <form action="../admin" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="approveLeave">
                                <input type="hidden" name="id" value="<%= leave.getId() %>">
                                <button type="submit">Approve</button>
                            </form>
                            <form action="../admin" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="rejectLeave">
                                <input type="hidden" name="id" value="<%= leave.getId() %>">
                                <button type="submit">Reject</button>
                            </form>
                        <% } %>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
