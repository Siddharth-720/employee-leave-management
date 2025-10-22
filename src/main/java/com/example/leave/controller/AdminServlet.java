package com.example.leave.controller;

import com.example.leave.dao.LeaveDao;
import com.example.leave.dao.UserDao;
import com.example.leave.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private UserDao userDao = new UserDao();
    private LeaveDao leaveDao = new LeaveDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addUser".equals(action)) {
            User user = new User();
            user.setName(request.getParameter("name"));
            user.setEmail(request.getParameter("email"));
            user.setPassword(request.getParameter("password"));
            user.setRole("employee");
            userDao.addUser(user);
        } else if ("updateUser".equals(action)) {
            User user = new User();
            user.setId(Integer.parseInt(request.getParameter("id")));
            user.setName(request.getParameter("name"));
            user.setEmail(request.getParameter("email"));
            userDao.updateUser(user);
        } else if ("deleteUser".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            userDao.deleteUser(id);
        } else if ("approveLeave".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            leaveDao.updateLeaveStatus(id, "Approved");
        } else if ("rejectLeave".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            leaveDao.updateLeaveStatus(id, "Rejected");
        }

        response.sendRedirect("admin/dashboard.jsp");
    }
}
