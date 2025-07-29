package com.sms.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sms.model.Student;
import com.sms.model.UndergraduateStudent;
import com.sms.model.PostgraduateStudent;
import com.sms.util.StudentManager;

/**
 * StudentServlet for handling student operations (Add, Update, Delete)
 */
@WebServlet("/student")
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("view".equals(action)) {
            // View all students
            List<Student> students = StudentManager.getAllStudents();
            request.setAttribute("students", students);
            request.getRequestDispatcher("viewStudents.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            // Edit student form
            String id = request.getParameter("id");
            if (id != null && !id.trim().isEmpty()) {
                Student student = StudentManager.findStudentById(id);
                if (student != null) {
                    request.setAttribute("student", student);
                    request.getRequestDispatcher("updateStudent.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Student not found!");
                    response.sendRedirect("student?action=view");
                }
            } else {
                response.sendRedirect("student?action=view");
            }
        } else {
            // Default: redirect to view students
            response.sendRedirect("student?action=view");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            handleAddStudent(request, response);
        } else if ("update".equals(action)) {
            handleUpdateStudent(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteStudent(request, response);
        } else {
            response.sendRedirect("dashboard.jsp");
        }
    }
    
    private void handleAddStudent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form parameters
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String course = request.getParameter("course");
        String gpaStr = request.getParameter("gpa");
        String studentType = request.getParameter("studentType");
        
        // Server-side validation
        if (!validateStudentData(request, id, name, email, course, gpaStr)) {
            request.getRequestDispatcher("addStudent.jsp").forward(request, response);
            return;
        }
        
        double gpa = Double.parseDouble(gpaStr);
        Student student = null;
        
        // Create appropriate student type
        if ("undergraduate".equals(studentType)) {
            String major = request.getParameter("major");
            String yearLevelStr = request.getParameter("yearLevel");
            
            if (major == null || major.trim().isEmpty()) {
                request.setAttribute("error", "Major is required for undergraduate students!");
                request.getRequestDispatcher("addStudent.jsp").forward(request, response);
                return;
            }
            
            int yearLevel = 1; // Default
            if (yearLevelStr != null && !yearLevelStr.trim().isEmpty()) {
                try {
                    yearLevel = Integer.parseInt(yearLevelStr);
                    if (yearLevel < 1 || yearLevel > 4) {
                        yearLevel = 1; // Default if invalid
                    }
                } catch (NumberFormatException e) {
                    yearLevel = 1; // Default if invalid
                }
            }
            
            student = new UndergraduateStudent(id, name, email, course, gpa, major, yearLevel);
        } else if ("postgraduate".equals(studentType)) {
            String researchArea = request.getParameter("researchArea");
            String supervisor = request.getParameter("supervisor");
            String degreeType = request.getParameter("degreeType");
            
            if (researchArea == null || researchArea.trim().isEmpty()) {
                request.setAttribute("error", "Research area is required for postgraduate students!");
                request.getRequestDispatcher("addStudent.jsp").forward(request, response);
                return;
            }
            
            if (supervisor == null) supervisor = "";
            if (degreeType == null || degreeType.trim().isEmpty()) {
                degreeType = "Masters";
            }
            
            student = new PostgraduateStudent(id, name, email, course, gpa, researchArea, supervisor, degreeType);
        } else {
            // Default to regular student
            student = new Student(id, name, email, course, gpa);
        }
        
        // Add student to system
        if (StudentManager.addStudent(student)) {
            request.setAttribute("success", "Student added successfully!");
            response.sendRedirect("student?action=view");
        } else {
            request.setAttribute("error", "Failed to add student. ID might already exist!");
            request.getRequestDispatcher("addStudent.jsp").forward(request, response);
        }
    }
    
    private void handleUpdateStudent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String originalId = request.getParameter("originalId");
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String course = request.getParameter("course");
        String gpaStr = request.getParameter("gpa");
        
        // Server-side validation
        if (!validateStudentData(request, id, name, email, course, gpaStr)) {
            request.getRequestDispatcher("updateStudent.jsp").forward(request, response);
            return;
        }
        
        double gpa = Double.parseDouble(gpaStr);
        
        // Find the original student to preserve type-specific data
        Student originalStudent = StudentManager.findStudentById(originalId);
        if (originalStudent == null) {
            request.setAttribute("error", "Student not found!");
            response.sendRedirect("student?action=view");
            return;
        }
        
        Student updatedStudent = null;
        
        // Create updated student with same type
        if (originalStudent instanceof UndergraduateStudent) {
            UndergraduateStudent ug = (UndergraduateStudent) originalStudent;
            updatedStudent = new UndergraduateStudent(id, name, email, course, gpa, 
                                                   ug.getMajor(), ug.getYearLevel());
        } else if (originalStudent instanceof PostgraduateStudent) {
            PostgraduateStudent pg = (PostgraduateStudent) originalStudent;
            updatedStudent = new PostgraduateStudent(id, name, email, course, gpa, 
                                                   pg.getResearchArea(), pg.getSupervisor(), pg.getDegreeType());
        } else {
            updatedStudent = new Student(id, name, email, course, gpa);
        }
        
        // Update student
        if (StudentManager.updateStudent(originalId, updatedStudent)) {
            request.setAttribute("success", "Student updated successfully!");
            response.sendRedirect("student?action=view");
        } else {
            request.setAttribute("error", "Failed to update student!");
            request.getRequestDispatcher("updateStudent.jsp").forward(request, response);
        }
    }
    
    private void handleDeleteStudent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        
        if (id == null || id.trim().isEmpty()) {
            request.setAttribute("error", "Student ID is required!");
            response.sendRedirect("student?action=view");
            return;
        }
        
        if (StudentManager.deleteStudent(id)) {
            request.setAttribute("success", "Student deleted successfully!");
        } else {
            request.setAttribute("error", "Student not found or could not be deleted!");
        }
        
        response.sendRedirect("student?action=view");
    }
    
    private boolean validateStudentData(HttpServletRequest request, String id, String name, 
                                      String email, String course, String gpaStr) {
        
        // Validate ID
        if (id == null || id.trim().isEmpty()) {
            request.setAttribute("error", "Student ID is required!");
            return false;
        }
        
        // Validate name
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "Student name is required!");
            return false;
        }
        
        // Validate email
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email is required!");
            return false;
        }
        
        // Basic email validation
        if (!email.contains("@")) {
            request.setAttribute("error", "Please enter a valid email address!");
            return false;
        }
        
        // Validate course
        if (course == null || course.trim().isEmpty()) {
            request.setAttribute("error", "Course is required!");
            return false;
        }
        
        // Validate GPA
        if (gpaStr == null || gpaStr.trim().isEmpty()) {
            request.setAttribute("error", "GPA is required!");
            return false;
        }
        
        try {
            double gpa = Double.parseDouble(gpaStr);
            if (gpa < 0.0 || gpa > 4.0) {
                request.setAttribute("error", "GPA must be between 0.0 and 4.0!");
                return false;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Please enter a valid GPA!");
            return false;
        }
        
        return true;
    }
} 