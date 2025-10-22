# Employee Leave Management System

This is a simple Java web application for managing employee leaves.

## Features

*   Employee login
*   Apply for leave
*   View leave status
*   Admin login
*   Approve/Reject leave applications
*   View all leave applications

## Technologies Used

*   Java
*   Servlets
*   JSP
*   JSTL
*   MySQL
*   Maven

## Setup and Installation

1.  **Database Setup:**
    *   Create a MySQL database named `leave_management_system`.
    *   Execute the `database.sql` script to create the necessary tables.

2.  **Build the project:**
    *   Run `mvn clean install` to build the project and create the `employee-leave-management.war` file.

3.  **Deploy the application:**
    *   Deploy the `employee-leave-management.war` file to a servlet container like Apache Tomcat.

## Database Schema

The database consists of two tables:

*   `users`: Stores user information (id, name, email, password, role).
*   `leaves`: Stores leave application information (id, employee_id, leave_type, from_date, to_date, reason, status).

## Leave Balance

To add leave balance columns to the `users` table, execute the following SQL script:

```sql
USE leave_management_system;
ALTER TABLE users
ADD COLUMN vacation_balance INT NOT NULL DEFAULT 20,
ADD COLUMN sick_balance INT NOT NULL DEFAULT 10,
ADD COLUMN personal_balance INT NOT NULL DEFAULT 5;
```