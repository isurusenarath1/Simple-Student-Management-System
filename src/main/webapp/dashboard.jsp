<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.sms.util.StudentManager" %>

<%
// Check if user is logged in
HttpSession session = request.getSession(false);
if (session == null || session.getAttribute("loggedIn") == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Get session data
String username = (String) session.getAttribute("username");
Long loginTime = (Long) session.getAttribute("loginTime");

// Calculate session duration
long currentTime = System.currentTimeMillis();
long sessionDuration = (currentTime - loginTime) / 1000; // in seconds

// Get statistics using StudentManager
int totalStudents = StudentManager.getStudentCount();
double averageGPA = StudentManager.getAverageGPA();
List<com.sms.model.Student> highGPAStudents = StudentManager.getHighGPAStudents();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Student Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Student Management System</h1>
            <p>Welcome back, <%= username %>! | Session Duration: <%= sessionDuration %> seconds</p>
        </div>
        
        <!-- Statistics Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <h3><%= totalStudents %></h3>
                <p>Total Students</p>
            </div>
            <div class="stat-card">
                <h3><%= String.format("%.2f", averageGPA) %></h3>
                <p>Average GPA</p>
            </div>
            <div class="stat-card">
                <h3><%= highGPAStudents.size() %></h3>
                <p>High GPA Students (≥3.5)</p>
            </div>
            <div class="stat-card">
                <h3><%= StudentManager.getUndergraduateStudents().size() %></h3>
                <p>Undergraduate Students</p>
            </div>
        </div>
        
        <!-- Navigation -->
        <div class="nav">
            <a href="addStudent.jsp" class="btn btn-success">Add Student</a>
            <a href="student?action=view" class="btn btn-primary">View Students</a>
            <a href="updateStudent.jsp" class="btn btn-warning">Update Student</a>
            <a href="deleteStudent.jsp" class="btn btn-danger">Delete Student</a>
            <a href="logout" class="btn btn-secondary">Logout</a>
        </div>
        
        <!-- Recent Activity -->
        <div class="card">
            <h2>Recent Activity</h2>
            <p>You have been logged in for <%= sessionDuration %> seconds.</p>
            <p>Last login time: <%= new Date(loginTime) %></p>
            
            <% if (totalStudents > 0) { %>
                <p>System contains <%= totalStudents %> student records.</p>
                <% if (highGPAStudents.size() > 0) { %>
                    <p><%= highGPAStudents.size() %> students have excellent academic performance.</p>
                <% } %>
            <% } else { %>
                <p>No students in the system yet. Add some students to get started!</p>
            <% } %>
        </div>
        
        <!-- Quick Actions -->
        <div class="card">
            <h2>Quick Actions</h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                <a href="addStudent.jsp" class="btn btn-success" style="text-decoration: none;">
                    ➕ Add New Student
                </a>
                <a href="student?action=view" class="btn btn-primary" style="text-decoration: none;">
                    👥 View All Students
                </a>
                <a href="updateStudent.jsp" class="btn btn-warning" style="text-decoration: none;">
                    ✏️ Edit Student
                </a>
                <a href="deleteStudent.jsp" class="btn btn-danger" style="text-decoration: none;">
                    🗑️ Remove Student
                </a>
            </div>
        </div>
    </div>
</body>
</html> 