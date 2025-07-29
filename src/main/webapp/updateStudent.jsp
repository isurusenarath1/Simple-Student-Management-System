<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.sms.model.Student" %>
<%@ page import="com.sms.model.UndergraduateStudent" %>
<%@ page import="com.sms.model.PostgraduateStudent" %>

<%
// Check if user is logged in
if (session == null || session.getAttribute("loggedIn") == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Get student data from request attribute
Student student = (Student) request.getAttribute("student");
String error = (String) request.getAttribute("error");

// If no student data, redirect to view students
if (student == null) {
    response.sendRedirect("student?action=view");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Student - Student Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Update Student Information</h1>
            <p>Edit student details for: <%= student.getName() %></p>
        </div>
        
        <div class="card">
            <% if (error != null) { %>
                <div class="alert alert-danger">
                    <%= error %>
                </div>
            <% } %>
            
            <form action="student" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="originalId" value="<%= student.getId() %>">
                
                <!-- Basic Information -->
                <h3>Basic Information</h3>
                <div class="form-group">
                    <label for="id">Student ID *</label>
                    <input type="text" id="id" name="id" class="form-control" 
                           value="<%= student.getId() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="name">Full Name *</label>
                    <input type="text" id="name" name="name" class="form-control" 
                           value="<%= student.getName() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email *</label>
                    <input type="email" id="email" name="email" class="form-control" 
                           value="<%= student.getEmail() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="course">Course *</label>
                    <input type="text" id="course" name="course" class="form-control" 
                           value="<%= student.getCourse() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="gpa">GPA *</label>
                    <input type="number" id="gpa" name="gpa" class="form-control" 
                           step="0.01" min="0.0" max="4.0" 
                           value="<%= student.getGpa() %>" required>
                </div>
                
                <!-- Student Type Information (Read-only) -->
                <div class="form-group">
                    <label>Student Type</label>
                    <div style="padding: 10px; background: #f7fafc; border-radius: 5px; border: 1px solid #e2e8f0;">
                        <% if (student instanceof UndergraduateStudent) { %>
                            <strong>Undergraduate Student</strong><br>
                            <small>Major: <%= ((UndergraduateStudent) student).getMajor() %> | 
                                   Year: <%= ((UndergraduateStudent) student).getYearDescription() %></small>
                        <% } else if (student instanceof PostgraduateStudent) { %>
                            <strong>Postgraduate Student</strong><br>
                            <small>Research Area: <%= ((PostgraduateStudent) student).getResearchArea() %> | 
                                   Degree: <%= ((PostgraduateStudent) student).getDegreeType() %></small>
                        <% } else { %>
                            <strong>Regular Student</strong>
                        <% } %>
                    </div>
                </div>
                
                <!-- Additional Information Display -->
                <% if (student instanceof UndergraduateStudent) { %>
                    <div class="form-group">
                        <label>Undergraduate Information</label>
                        <div style="padding: 15px; background: rgba(102, 126, 234, 0.1); border-radius: 8px;">
                            <p><strong>Major:</strong> <%= ((UndergraduateStudent) student).getMajor() %></p>
                            <p><strong>Year Level:</strong> <%= ((UndergraduateStudent) student).getYearDescription() %></p>
                        </div>
                    </div>
                <% } else if (student instanceof PostgraduateStudent) { %>
                    <div class="form-group">
                        <label>Postgraduate Information</label>
                        <div style="padding: 15px; background: rgba(237, 137, 54, 0.1); border-radius: 8px;">
                            <p><strong>Research Area:</strong> <%= ((PostgraduateStudent) student).getResearchArea() %></p>
                            <p><strong>Degree Type:</strong> <%= ((PostgraduateStudent) student).getDegreeType() %></p>
                            <% if (!((PostgraduateStudent) student).getSupervisor().isEmpty()) { %>
                                <p><strong>Supervisor:</strong> <%= ((PostgraduateStudent) student).getSupervisor() %></p>
                            <% } %>
                        </div>
                    </div>
                <% } %>
                
                <!-- Current Status -->
                <div class="form-group">
                    <label>Current Academic Status</label>
                    <div style="padding: 10px; background: #f7fafc; border-radius: 5px; border: 1px solid #e2e8f0;">
                        <span class="status-badge 
                            <% if (student.getGpa() >= 3.5) { %>status-excellent
                            <% } else if (student.getGpa() >= 3.0) { %>status-good
                            <% } else if (student.getGpa() >= 2.0) { %>status-satisfactory
                            <% } else { %>status-needs-improvement<% } %>">
                            <%= student.getStatus() %>
                        </span>
                        <span style="margin-left: 10px; color: #718096;">
                            (GPA: <%= String.format("%.2f", student.getGpa()) %>)
                        </span>
                    </div>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn btn-warning">Update Student</button>
                    <a href="student?action=view" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
        
        <div class="nav">
            <a href="dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
            <a href="student?action=view" class="btn btn-primary">View All Students</a>
        </div>
    </div>
</body>
</html> 