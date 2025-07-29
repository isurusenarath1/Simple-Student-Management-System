<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.sms.model.Student" %>
<%@ page import="com.sms.util.StudentManager" %>

<%
// Check if user is logged in
if (session == null || session.getAttribute("loggedIn") == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Get all students for dropdown
List<Student> students = StudentManager.getAllStudents();
String error = (String) request.getAttribute("error");
String success = (String) request.getAttribute("success");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Student - Student Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Delete Student</h1>
            <p>Remove a student from the system</p>
        </div>
        
        <% if (success != null) { %>
            <div class="alert alert-success">
                <%= success %>
            </div>
        <% } %>
        
        <% if (error != null) { %>
            <div class="alert alert-danger">
                <%= error %>
            </div>
        <% } %>
        
        <div class="card">
            <% if (students.isEmpty()) { %>
                <div style="text-align: center; padding: 40px;">
                    <p>No students found in the system.</p>
                    <a href="addStudent.jsp" class="btn btn-success">Add First Student</a>
                </div>
            <% } else { %>
                <h2>Select Student to Delete</h2>
                <p style="color: #e53e3e; margin-bottom: 20px;">
                    <strong>⚠️ Warning:</strong> This action cannot be undone. The selected student will be permanently removed from the system.
                </p>
                
                <form action="student" method="post" onsubmit="return confirm('Are you sure you want to delete this student? This action cannot be undone.');">
                    <input type="hidden" name="action" value="delete">
                    
                    <div class="form-group">
                        <label for="id">Select Student *</label>
                        <select id="id" name="id" class="form-control" required>
                            <option value="">-- Select a student to delete --</option>
                            <% for (Student student : students) { %>
                                <option value="<%= student.getId() %>">
                                    <%= student.getId() %> - <%= student.getName() %> 
                                    (<%= student.getEmail() %>) - GPA: <%= String.format("%.2f", student.getGpa()) %>
                                </option>
                            <% } %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn btn-danger">Delete Student</button>
                        <a href="student?action=view" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
                
                <!-- Student List for Reference -->
                <div style="margin-top: 30px;">
                    <h3>Current Students (<%= students.size() %> total)</h3>
                    <div class="table-container">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Course</th>
                                    <th>GPA</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Student student : students) { %>
                                    <tr>
                                        <td><strong><%= student.getId() %></strong></td>
                                        <td><%= student.getName() %></td>
                                        <td><%= student.getEmail() %></td>
                                        <td><%= student.getCourse() %></td>
                                        <td><%= String.format("%.2f", student.getGpa()) %></td>
                                        <td>
                                            <span class="status-badge 
                                                <% if (student.getGpa() >= 3.5) { %>status-excellent
                                                <% } else if (student.getGpa() >= 3.0) { %>status-good
                                                <% } else if (student.getGpa() >= 2.0) { %>status-satisfactory
                                                <% } else { %>status-needs-improvement<% } %>">
                                                <%= student.getStatus() %>
                                            </span>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            <% } %>
        </div>
        
        <div class="nav">
            <a href="dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
            <a href="student?action=view" class="btn btn-primary">View All Students</a>
        </div>
    </div>
</body>
</html> 