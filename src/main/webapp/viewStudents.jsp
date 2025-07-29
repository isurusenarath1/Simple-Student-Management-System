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

// Get students list from request attribute
List<Student> students = (List<Student>) request.getAttribute("students");
String success = (String) request.getAttribute("success");
String error = (String) request.getAttribute("error");

// If students list is null, redirect to servlet to get data
if (students == null) {
    response.sendRedirect("student?action=view");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Students - Student Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Student Records</h1>
            <p>View and manage all student information</p>
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
            <h2>Student List (<%= students.size() %> students)</h2>
            
            <% if (students.isEmpty()) { %>
                <div style="text-align: center; padding: 40px;">
                    <p>No students found in the system.</p>
                    <a href="addStudent.jsp" class="btn btn-success">Add First Student</a>
                </div>
            <% } else { %>
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
                                <th>Type</th>
                                <th>Additional Info</th>
                                <th>Actions</th>
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
                                    <td>
                                        <% if (student instanceof UndergraduateStudent) { %>
                                            <span style="color: #667eea;">Undergraduate</span>
                                        <% } else if (student instanceof PostgraduateStudent) { %>
                                            <span style="color: #ed8936;">Postgraduate</span>
                                        <% } else { %>
                                            <span style="color: #718096;">Regular</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <% if (student instanceof UndergraduateStudent) { %>
                                            <% UndergraduateStudent ug = (UndergraduateStudent) student; %>
                                            <strong>Major:</strong> <%= ug.getMajor() %><br>
                                            <strong>Year:</strong> <%= ug.getYearDescription() %>
                                        <% } else if (student instanceof PostgraduateStudent) { %>
                                            <% PostgraduateStudent pg = (PostgraduateStudent) student; %>
                                            <strong>Research:</strong> <%= pg.getResearchArea() %><br>
                                            <strong>Degree:</strong> <%= pg.getDegreeType() %>
                                            <% if (!pg.getSupervisor().isEmpty()) { %>
                                                <br><strong>Supervisor:</strong> <%= pg.getSupervisor() %>
                                            <% } %>
                                        <% } else { %>
                                            <span style="color: #718096;">No additional info</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 5px; flex-wrap: wrap;">
                                            <a href="student?action=edit&id=<%= student.getId() %>" 
                                               class="btn btn-warning" style="font-size: 12px; padding: 5px 10px;">
                                                Edit
                                            </a>
                                            <form action="student" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="<%= student.getId() %>">
                                                <button type="submit" class="btn btn-danger" 
                                                        style="font-size: 12px; padding: 5px 10px;"
                                                        onclick="return confirm('Are you sure you want to delete this student?')">
                                                    Delete
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                
                <!-- Summary Statistics -->
                <div style="margin-top: 30px; padding: 20px; background: rgba(102, 126, 234, 0.1); border-radius: 10px;">
                    <h3>Summary Statistics</h3>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px;">
                        <div>
                            <strong>Total Students:</strong> <%= students.size() %>
                        </div>
                        <div>
                            <strong>Undergraduate:</strong> 
                            <%= students.stream().filter(s -> s instanceof UndergraduateStudent).count() %>
                        </div>
                        <div>
                            <strong>Postgraduate:</strong> 
                            <%= students.stream().filter(s -> s instanceof PostgraduateStudent).count() %>
                        </div>
                        <div>
                            <strong>High GPA (≥3.5):</strong> 
                            <%= students.stream().filter(s -> s.getGpa() >= 3.5).count() %>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
        
        <div class="nav">
            <a href="dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
            <a href="addStudent.jsp" class="btn btn-success">Add New Student</a>
        </div>
    </div>
</body>
</html> 