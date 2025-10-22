<%@ page import="com.example.leave.model.User" %>
<%@ page import="com.example.leave.dao.LeaveDao" %>
<%@ page import="com.example.leave.model.Leave" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css">
</head>
<body>
    <div class="container">
        <% User user = (User) session.getAttribute("user"); %>
        <h2>Welcome, <%= user.getName() %></h2>
        <a href="../logout">Logout</a>

        <h3>Your Leave Balances</h3>
        <p>
            Vacation: <%= user.getVacationBalance() %> days | 
            Sick Leave: <%= user.getSickBalance() %> days | 
            Personal Leave: <%= user.getPersonalBalance() %> days
        </p>

        <hr/>

        <h3>Apply for Leave</h3>
        <% 
            String error = request.getParameter("error");
            if ("balance".equals(error)) { %>
                <p style="color:red;">You do not have enough leave balance for this request.</p>
            <% }

            String message = request.getParameter("message");
            if ("success".equals(message)) { %>
                <p style="color:green;">Leave application submitted successfully.</p>
            <% } 
        %>
        <form action="../applyLeave" method="post">
            <label for="leaveType">Leave Type:</label>
            <select id="leaveType" name="leaveType">
                <option value="Vacation">Vacation</option>
                <option value="Sick Leave">Sick Leave</option>
                <option value="Personal Leave">Personal Leave</option>
            </select>
            <label for="fromDate">From:</label>
            <input type="date" id="fromDate" name="fromDate" required>
            <label for="toDate">To:</label>
            <input type="date" id="toDate" name="toDate" required>
            <label for="reason">Reason:</label>
            <textarea id="reason" name="reason"></textarea>
            <button type="submit">Apply</button>
        </form>

        <h3>Leave History</h3>
        <% 
            LeaveDao leaveDao = new LeaveDao();
            List<Leave> leaves = leaveDao.getLeaveHistory(user.getId());
        %>
        <table>
            <tr>
                <th>Leave Type</th>
                <th>From</th>
                <th>To</th>
                <th>Reason</th>
                <th>Status</th>
            </tr>
            <% for (Leave leave : leaves) { %>
                <tr>
                    <td><%= leave.getLeaveType() %></td>
                    <td><%= leave.getFromDate() %></td>
                    <td><%= leave.getToDate() %></td>
                    <td><%= leave.getReason() %></td>
                    <td><%= leave.getStatus() %></td>
                </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
