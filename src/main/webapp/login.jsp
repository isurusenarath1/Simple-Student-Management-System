<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
// Check if user is already logged in
HttpSession session = request.getSession(false);
if (session != null && session.getAttribute("loggedIn") != null) {
    response.sendRedirect("dashboard.jsp");
    return;
}

// Get error message if any
String error = (String) request.getAttribute("error");
String username = (String) request.getAttribute("username");
if (username == null) {
    username = "";
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Student Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="login-container">
            <div class="login-form">
                <h2>Login to SMS</h2>
                
                <% if (error != null) { %>
                    <div class="alert alert-danger">
                        <%= error %>
                    </div>
                <% } %>
                
                <form action="login" method="post">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" 
                               class="form-control" value="<%= username %>" 
                               placeholder="Enter username" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" 
                               class="form-control" placeholder="Enter password" required>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary" style="width: 100%;">
                            Login
                        </button>
                    </div>
                </form>
                
                <div style="text-align: center; margin-top: 20px;">
                    <p style="color: #718096; font-size: 14px;">
                        <strong>Demo Credentials:</strong><br>
                        Username: <code>admin</code><br>
                        Password: <code>password</code>
                    </p>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 