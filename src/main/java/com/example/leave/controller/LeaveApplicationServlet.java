package com.example.leave.controller;

import com.example.leave.dao.LeaveDao;
import com.example.leave.model.Leave;
import com.example.leave.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/applyLeave")
public class LeaveApplicationServlet extends HttpServlet {
    private LeaveDao leaveDao = new LeaveDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String leaveType = request.getParameter("leaveType");
        Date fromDate = Date.valueOf(request.getParameter("fromDate"));
        Date toDate = Date.valueOf(request.getParameter("toDate"));
        String reason = request.getParameter("reason");

        long diff = toDate.getTime() - fromDate.getTime();
        int days = (int) (diff / (1000 * 60 * 60 * 24)) + 1;

        boolean hasEnoughBalance = false;
        switch (leaveType) {
            case "Vacation":
                if (user.getVacationBalance() >= days) hasEnoughBalance = true;
                break;
            case "Sick Leave":
                if (user.getSickBalance() >= days) hasEnoughBalance = true;
                break;
            case "Personal Leave":
                if (user.getPersonalBalance() >= days) hasEnoughBalance = true;
                break;
        }

        if (hasEnoughBalance) {
            Leave leave = new Leave();
            leave.setEmployeeId(user.getId());
            leave.setLeaveType(leaveType);
            leave.setFromDate(fromDate);
            leave.setToDate(toDate);
            leave.setReason(reason);

            leaveDao.applyLeave(leave);
            response.sendRedirect("employee/dashboard.jsp?message=success");
        } else {
            response.sendRedirect("employee/dashboard.jsp?error=balance");
        }
    }
}
