package com.sms.model;

/**
 * Base Student class with encapsulation and OOP principles
 */
public class Student {
    // Private fields for encapsulation
    private String id;
    private String name;
    private String email;
    private String course;
    private double gpa;
    
    // Default constructor
    public Student() {
        this.id = "";
        this.name = "";
        this.email = "";
        this.course = "";
        this.gpa = 0.0;
    }
    
    // Constructor with parameters (method overloading)
    public Student(String id, String name, String email, String course, double gpa) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.course = course;
        this.gpa = gpa;
    }
    
    // Constructor with name and id only (method overloading)
    public Student(String id, String name) {
        this.id = id;
        this.name = name;
        this.email = "";
        this.course = "";
        this.gpa = 0.0;
    }
    
    // Getters and Setters for encapsulation
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getCourse() {
        return course;
    }
    
    public void setCourse(String course) {
        this.course = course;
    }
    
    public double getGpa() {
        return gpa;
    }
    
    public void setGpa(double gpa) {
        this.gpa = gpa;
    }
    
    // Method to validate student data
    public boolean isValid() {
        return id != null && !id.trim().isEmpty() &&
               name != null && !name.trim().isEmpty() &&
               email != null && !email.trim().isEmpty() &&
               course != null && !course.trim().isEmpty() &&
               gpa >= 0.0 && gpa <= 4.0;
    }
    
    // Method to get student status based on GPA
    public String getStatus() {
        if (gpa >= 3.5) {
            return "Excellent";
        } else if (gpa >= 3.0) {
            return "Good";
        } else if (gpa >= 2.0) {
            return "Satisfactory";
        } else {
            return "Needs Improvement";
        }
    }
    
    @Override
    public String toString() {
        return "Student{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", course='" + course + '\'' +
                ", gpa=" + gpa +
                '}';
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Student student = (Student) obj;
        return id.equals(student.id);
    }
    
    @Override
    public int hashCode() {
        return id.hashCode();
    }
} 