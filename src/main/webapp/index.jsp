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
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Student Management System</h1>
            <p>Welcome to the comprehensive student management platform</p>
        </div>
        
        <div class="card">
            <div style="text-align: center;">
                <h2>Welcome to SMS</h2>
                <p>Please login to access the student management features.</p>
                <br>
                <a href="login.jsp" class="btn btn-primary">Login</a>
            </div>
        </div>
    </div>
</body>
</html> 