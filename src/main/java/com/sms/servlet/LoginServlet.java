package com.sms.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * LoginServlet for handling user authentication
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Hardcoded credentials as required
    private static final String VALID_USERNAME = "admin";
    private static final String VALID_PASSWORD = "password";
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect to login page
        response.sendRedirect("login.jsp");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get parameters from the form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Server-side validation
        if (username == null || password == null || 
            username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        // Validate credentials (hardcoded as required)
        if (VALID_USERNAME.equals(username) && VALID_PASSWORD.equals(password)) {
            // Create session and set attributes
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("loggedIn", true);
            session.setAttribute("loginTime", System.currentTimeMillis());
            
            // Redirect to dashboard
            response.sendRedirect("dashboard.jsp");
        } else {
            // Invalid credentials
            request.setAttribute("error", "Invalid username or password!");
            request.setAttribute("username", username); // Preserve username for user convenience
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
} 