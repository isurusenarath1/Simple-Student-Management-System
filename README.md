# Simple Student Management System

A Java-based web application using JSP, Servlets, and core Java with OOP principles for managing student records.

## Features

### Core Features
1. **Login System** - Hardcoded username/password validation
2. **Student Dashboard** - Welcome message with navigation
3. **Add Student** - Form to enter student details (Name, ID, Email, Course, GPA)
4. **View Students** - Display student list in a JSP table
5. **Update Student** - Select student by ID and update fields
6. **Delete Student** - Remove student from the list
7. **Logout** - End session and redirect to login

### Technical Implementation
- **Java Basics**: Variables, conditionals, loops, arrays/ArrayLists
- **OOP Concepts**: 
  - Student class with encapsulation (getters/setters)
  - Constructors and method overloading
  - Inheritance (UndergraduateStudent, PostgraduateStudent subclasses)
- **Servlets**: Login validation, form management, session handling
- **JSP**: UI pages with expression/declaration tags and implicit objects
- **Validation**: Server-side validation for student data

## Project Structure
```
src/
├── main/
│   ├── java/
│   │   ├── com/
│   │   │   └── sms/
│   │   │       ├── model/
│   │   │       │   ├── Student.java
│   │   │       │   ├── UndergraduateStudent.java
│   │   │       │   └── PostgraduateStudent.java
│   │   │       ├── servlet/
│   │   │       │   ├── LoginServlet.java
│   │   │       │   ├── StudentServlet.java
│   │   │       │   └── LogoutServlet.java
│   │   │       └── util/
│   │   │           └── StudentManager.java
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   └── web.xml
│   │       ├── css/
│   │       │   └── style.css
│   │       ├── index.jsp
│   │       ├── login.jsp
│   │       ├── dashboard.jsp
│   │       ├── addStudent.jsp
│   │       ├── viewStudents.jsp
│   │       ├── updateStudent.jsp
│   │       └── deleteStudent.jsp
```

## Setup Instructions
1. Ensure you have Java JDK 8+ and Apache Tomcat installed
2. Deploy the application to Tomcat
3. Access the application at `http://localhost:8080/sms/`
4. Login with username: `admin` and password: `password`

## Usage
- Login with the provided credentials
- Navigate through the dashboard to manage students
- Add, view, update, and delete student records
- All data is stored in-memory (resets on server restart)