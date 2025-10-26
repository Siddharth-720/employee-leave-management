package com.example.leave.dao;

import com.example.leave.model.Leave;
import com.example.leave.util.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
//add

public class LeaveDao {

    public void applyLeave(Leave leave) {
        try (Connection connection = DbUtil.getConnection()) {
            String sql = "INSERT INTO leaves (employee_id, leave_type, from_date, to_date, reason) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, leave.getEmployeeId());
            statement.setString(2, leave.getLeaveType());
            statement.setDate(3, leave.getFromDate());
            statement.setDate(4, leave.getToDate());
            statement.setString(5, leave.getReason());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Leave> getLeaveHistory(int employeeId) {
        List<Leave> leaves = new ArrayList<>();
        try (Connection connection = DbUtil.getConnection()) {
            String sql = "SELECT * FROM leaves WHERE employee_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, employeeId);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Leave leave = new Leave();
                leave.setId(resultSet.getInt("id"));
                leave.setLeaveType(resultSet.getString("leave_type"));
                leave.setFromDate(resultSet.getDate("from_date"));
                leave.setToDate(resultSet.getDate("to_date"));
                leave.setReason(resultSet.getString("reason"));
                leave.setStatus(resultSet.getString("status"));
                leaves.add(leave);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return leaves;
    }

    public List<Leave> getAllLeaveRequests() {
        List<Leave> leaves = new ArrayList<>();
        try (Connection connection = DbUtil.getConnection()) {
            String sql = "SELECT l.*, u.name FROM leaves l JOIN users u ON l.employee_id = u.id";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Leave leave = new Leave();
                leave.setId(resultSet.getInt("id"));
                leave.setEmployeeId(resultSet.getInt("employee_id"));
                leave.setLeaveType(resultSet.getString("leave_type"));
                leave.setFromDate(resultSet.getDate("from_date"));
                leave.setToDate(resultSet.getDate("to_date"));
                leave.setReason(resultSet.getString("reason"));
                leave.setStatus(resultSet.getString("status"));
                // If you need employee name in the leave object, you need to add it to the model
                // leave.setEmployeeName(resultSet.getString("name"));
                leaves.add(leave);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return leaves;
    }

    public void updateLeaveStatus(int leaveId, String status) {
        try (Connection connection = DbUtil.getConnection()) {
            // First, update the status
            String sql = "UPDATE leaves SET status = ? WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, leaveId);
            statement.executeUpdate();

            // If approved, deduct from balance
            if ("Approved".equals(status)) {
                // Get leave details to calculate duration and type
                String selectSql = "SELECT employee_id, leave_type, from_date, to_date FROM leaves WHERE id = ?";
                PreparedStatement selectStatement = connection.prepareStatement(selectSql);
                selectStatement.setInt(1, leaveId);
                ResultSet rs = selectStatement.executeQuery();

                if (rs.next()) {
                    int employeeId = rs.getInt("employee_id");
                    String leaveType = rs.getString("leave_type");
                    Date fromDate = rs.getDate("from_date");
                    Date toDate = rs.getDate("to_date");

                    long diff = toDate.getTime() - fromDate.getTime();
                    int days = (int) (diff / (1000 * 60 * 60 * 24)) + 1;

                    UserDao userDao = new UserDao();
                    userDao.updateLeaveBalance(employeeId, leaveType, days);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
