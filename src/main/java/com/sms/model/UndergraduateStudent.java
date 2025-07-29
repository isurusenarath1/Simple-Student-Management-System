package com.sms.model;

/**
 * UndergraduateStudent class extending Student (Inheritance)
 */
public class UndergraduateStudent extends Student {
    private String major;
    private int yearLevel;
    
    // Default constructor
    public UndergraduateStudent() {
        super();
        this.major = "";
        this.yearLevel = 1;
    }
    
    // Constructor with all parameters
    public UndergraduateStudent(String id, String name, String email, String course, 
                              double gpa, String major, int yearLevel) {
        super(id, name, email, course, gpa);
        this.major = major;
        this.yearLevel = yearLevel;
    }
    
    // Constructor with basic info
    public UndergraduateStudent(String id, String name, String major) {
        super(id, name);
        this.major = major;
        this.yearLevel = 1;
    }
    
    // Getters and Setters
    public String getMajor() {
        return major;
    }
    
    public void setMajor(String major) {
        this.major = major;
    }
    
    public int getYearLevel() {
        return yearLevel;
    }
    
    public void setYearLevel(int yearLevel) {
        if (yearLevel >= 1 && yearLevel <= 4) {
            this.yearLevel = yearLevel;
        }
    }
    
    // Override isValid method to include undergraduate-specific validation
    @Override
    public boolean isValid() {
        return super.isValid() && 
               major != null && !major.trim().isEmpty() &&
               yearLevel >= 1 && yearLevel <= 4;
    }
    
    // Method to get year level description
    public String getYearDescription() {
        switch (yearLevel) {
            case 1: return "Freshman";
            case 2: return "Sophomore";
            case 3: return "Junior";
            case 4: return "Senior";
            default: return "Unknown";
        }
    }
    
    // Override toString method
    @Override
    public String toString() {
        return "UndergraduateStudent{" +
                "id='" + getId() + '\'' +
                ", name='" + getName() + '\'' +
                ", email='" + getEmail() + '\'' +
                ", course='" + getCourse() + '\'' +
                ", gpa=" + getGpa() +
                ", major='" + major + '\'' +
                ", yearLevel=" + yearLevel +
                '}';
    }
} 