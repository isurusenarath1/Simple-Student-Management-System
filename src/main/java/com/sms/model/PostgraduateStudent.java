package com.sms.model;

/**
 * PostgraduateStudent class extending Student (Inheritance)
 */
public class PostgraduateStudent extends Student {
    private String researchArea;
    private String supervisor;
    private String degreeType; // "Masters" or "PhD"
    
    // Default constructor
    public PostgraduateStudent() {
        super();
        this.researchArea = "";
        this.supervisor = "";
        this.degreeType = "Masters";
    }
    
    // Constructor with all parameters
    public PostgraduateStudent(String id, String name, String email, String course, 
                             double gpa, String researchArea, String supervisor, String degreeType) {
        super(id, name, email, course, gpa);
        this.researchArea = researchArea;
        this.supervisor = supervisor;
        this.degreeType = degreeType;
    }
    
    // Constructor with basic info
    public PostgraduateStudent(String id, String name, String researchArea, String degreeType) {
        super(id, name);
        this.researchArea = researchArea;
        this.degreeType = degreeType;
        this.supervisor = "";
    }
    
    // Getters and Setters
    public String getResearchArea() {
        return researchArea;
    }
    
    public void setResearchArea(String researchArea) {
        this.researchArea = researchArea;
    }
    
    public String getSupervisor() {
        return supervisor;
    }
    
    public void setSupervisor(String supervisor) {
        this.supervisor = supervisor;
    }
    
    public String getDegreeType() {
        return degreeType;
    }
    
    public void setDegreeType(String degreeType) {
        if ("Masters".equals(degreeType) || "PhD".equals(degreeType)) {
            this.degreeType = degreeType;
        }
    }
    
    // Override isValid method to include postgraduate-specific validation
    @Override
    public boolean isValid() {
        return super.isValid() && 
               researchArea != null && !researchArea.trim().isEmpty() &&
               degreeType != null && !degreeType.trim().isEmpty();
    }
    
    // Method to get degree level description
    public String getDegreeLevel() {
        if ("PhD".equals(degreeType)) {
            return "Doctorate";
        } else {
            return "Masters";
        }
    }
    
    // Override toString method
    @Override
    public String toString() {
        return "PostgraduateStudent{" +
                "id='" + getId() + '\'' +
                ", name='" + getName() + '\'' +
                ", email='" + getEmail() + '\'' +
                ", course='" + getCourse() + '\'' +
                ", gpa=" + getGpa() +
                ", researchArea='" + researchArea + '\'' +
                ", supervisor='" + supervisor + '\'' +
                ", degreeType='" + degreeType + '\'' +
                '}';
    }
} 