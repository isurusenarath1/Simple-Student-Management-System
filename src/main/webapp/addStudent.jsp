<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
// Check if user is logged in
HttpSession session = request.getSession(false);
if (session == null || session.getAttribute("loggedIn") == null) {
    response.sendRedirect("login.jsp");
    return;
}

// Get error message if any
String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student - Student Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <script>
        function toggleStudentType() {
            const studentType = document.getElementById('studentType').value;
            const undergraduateFields = document.getElementById('undergraduateFields');
            const postgraduateFields = document.getElementById('postgraduateFields');
            
            if (studentType === 'undergraduate') {
                undergraduateFields.style.display = 'block';
                postgraduateFields.style.display = 'none';
            } else if (studentType === 'postgraduate') {
                undergraduateFields.style.display = 'none';
                postgraduateFields.style.display = 'block';
            } else {
                undergraduateFields.style.display = 'none';
                postgraduateFields.style.display = 'none';
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Add New Student</h1>
            <p>Enter student information to add to the system</p>
        </div>
        
        <div class="card">
            <% if (error != null) { %>
                <div class="alert alert-danger">
                    <%= error %>
                </div>
            <% } %>
            
            <form action="student" method="post">
                <input type="hidden" name="action" value="add">
                
                <!-- Basic Information -->
                <h3>Basic Information</h3>
                <div class="form-group">
                    <label for="id">Student ID *</label>
                    <input type="text" id="id" name="id" class="form-control" 
                           placeholder="Enter student ID" required>
                </div>
                
                <div class="form-group">
                    <label for="name">Full Name *</label>
                    <input type="text" id="name" name="name" class="form-control" 
                           placeholder="Enter full name" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email *</label>
                    <input type="email" id="email" name="email" class="form-control" 
                           placeholder="Enter email address" required>
                </div>
                
                <div class="form-group">
                    <label for="course">Course *</label>
                    <input type="text" id="course" name="course" class="form-control" 
                           placeholder="Enter course name" required>
                </div>
                
                <div class="form-group">
                    <label for="gpa">GPA *</label>
                    <input type="number" id="gpa" name="gpa" class="form-control" 
                           step="0.01" min="0.0" max="4.0" placeholder="Enter GPA (0.0-4.0)" required>
                </div>
                
                <!-- Student Type -->
                <div class="form-group">
                    <label for="studentType">Student Type</label>
                    <select id="studentType" name="studentType" class="form-control" onchange="toggleStudentType()">
                        <option value="regular">Regular Student</option>
                        <option value="undergraduate">Undergraduate Student</option>
                        <option value="postgraduate">Postgraduate Student</option>
                    </select>
                </div>
                
                <!-- Undergraduate Fields -->
                <div id="undergraduateFields" style="display: none;">
                    <h3>Undergraduate Information</h3>
                    <div class="form-group">
                        <label for="major">Major *</label>
                        <input type="text" id="major" name="major" class="form-control" 
                               placeholder="Enter major">
                    </div>
                    
                    <div class="form-group">
                        <label for="yearLevel">Year Level</label>
                        <select id="yearLevel" name="yearLevel" class="form-control">
                            <option value="1">1st Year (Freshman)</option>
                            <option value="2">2nd Year (Sophomore)</option>
                            <option value="3">3rd Year (Junior)</option>
                            <option value="4">4th Year (Senior)</option>
                        </select>
                    </div>
                </div>
                
                <!-- Postgraduate Fields -->
                <div id="postgraduateFields" style="display: none;">
                    <h3>Postgraduate Information</h3>
                    <div class="form-group">
                        <label for="researchArea">Research Area *</label>
                        <input type="text" id="researchArea" name="researchArea" class="form-control" 
                               placeholder="Enter research area">
                    </div>
                    
                    <div class="form-group">
                        <label for="supervisor">Supervisor</label>
                        <input type="text" id="supervisor" name="supervisor" class="form-control" 
                               placeholder="Enter supervisor name">
                    </div>
                    
                    <div class="form-group">
                        <label for="degreeType">Degree Type</label>
                        <select id="degreeType" name="degreeType" class="form-control">
                            <option value="Masters">Masters</option>
                            <option value="PhD">PhD</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn btn-success">Add Student</button>
                    <a href="dashboard.jsp" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
        
        <div class="nav">
            <a href="dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
            <a href="student?action=view" class="btn btn-primary">View Students</a>
        </div>
    </div>
</body>
</html> 