<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Student Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Oops! Something went wrong</h1>
            <p>We encountered an error while processing your request</p>
        </div>
        
        <div class="card">
            <div style="text-align: center; padding: 40px;">
                <h2 style="color: #e53e3e; margin-bottom: 20px;">
                    Error <%= request.getAttribute("javax.servlet.error.status_code") %>
                </h2>
                
                <p style="margin-bottom: 20px;">
                    <%= request.getAttribute("javax.servlet.error.message") %>
                </p>
                
                <% if (exception != null) { %>
                    <div style="background: #f7fafc; padding: 15px; border-radius: 8px; margin: 20px 0; text-align: left;">
                        <h4>Error Details:</h4>
                        <pre style="color: #e53e3e; font-size: 12px; overflow-x: auto;"><%= exception.getMessage() %></pre>
                    </div>
                <% } %>
                
                <div style="margin-top: 30px;">
                    <a href="index.jsp" class="btn btn-primary">Go to Home</a>
                    <a href="login.jsp" class="btn btn-secondary">Login</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 