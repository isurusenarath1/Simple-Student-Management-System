package com.sms.util;

import com.sms.model.Student;
import com.sms.model.UndergraduateStudent;
import com.sms.model.PostgraduateStudent;
import java.util.ArrayList;
import java.util.List;

/**
 * StudentManager utility class for managing student data in-memory
 */
public class StudentManager {
    private static final List<Student> students = new ArrayList<>();
    
    // Static initialization block to add some sample data
    static {
        // Add some sample students
        students.add(new UndergraduateStudent("UG001", "John Doe", "john.doe@email.com", 
                                           "Computer Science", 3.8, "Software Engineering", 3));
        students.add(new UndergraduateStudent("UG002", "Jane Smith", "jane.smith@email.com", 
                                           "Mathematics", 3.5, "Applied Mathematics", 2));
        students.add(new PostgraduateStudent("PG001", "Mike Johnson", "mike.johnson@email.com", 
                                           "Computer Science", 3.9, "Machine Learning", "Dr. Brown", "PhD"));
        students.add(new PostgraduateStudent("PG002", "Sarah Wilson", "sarah.wilson@email.com", 
                                           "Physics", 3.7, "Quantum Physics", "Dr. Davis", "Masters"));
    }
    
    // Method to add a new student
    public static boolean addStudent(Student student) {
        if (student != null && student.isValid() && !studentExists(student.getId())) {
            students.add(student);
            return true;
        }
        return false;
    }
    
    // Method to get all students
    public static List<Student> getAllStudents() {
        return new ArrayList<>(students);
    }
    
    // Method to find student by ID
    public static Student findStudentById(String id) {
        for (Student student : students) {
            if (student.getId().equals(id)) {
                return student;
            }
        }
        return null;
    }
    
    // Method to update student
    public static boolean updateStudent(String id, Student updatedStudent) {
        for (int i = 0; i < students.size(); i++) {
            if (students.get(i).getId().equals(id)) {
                if (updatedStudent != null && updatedStudent.isValid()) {
                    students.set(i, updatedStudent);
                    return true;
                }
                return false;
            }
        }
        return false;
    }
    
    // Method to delete student
    public static boolean deleteStudent(String id) {
        for (int i = 0; i < students.size(); i++) {
            if (students.get(i).getId().equals(id)) {
                students.remove(i);
                return true;
            }
        }
        return false;
    }
    
    // Method to check if student exists
    public static boolean studentExists(String id) {
        return findStudentById(id) != null;
    }
    
    // Method to get student count
    public static int getStudentCount() {
        return students.size();
    }
    
    // Method to get students by type
    public static List<UndergraduateStudent> getUndergraduateStudents() {
        List<UndergraduateStudent> ugStudents = new ArrayList<>();
        for (Student student : students) {
            if (student instanceof UndergraduateStudent) {
                ugStudents.add((UndergraduateStudent) student);
            }
        }
        return ugStudents;
    }
    
    public static List<PostgraduateStudent> getPostgraduateStudents() {
        List<PostgraduateStudent> pgStudents = new ArrayList<>();
        for (Student student : students) {
            if (student instanceof PostgraduateStudent) {
                pgStudents.add((PostgraduateStudent) student);
            }
        }
        return pgStudents;
    }
    
    // Method to search students by name
    public static List<Student> searchStudentsByName(String name) {
        List<Student> results = new ArrayList<>();
        for (Student student : students) {
            if (student.getName().toLowerCase().contains(name.toLowerCase())) {
                results.add(student);
            }
        }
        return results;
    }
    
    // Method to get average GPA
    public static double getAverageGPA() {
        if (students.isEmpty()) {
            return 0.0;
        }
        
        double totalGPA = 0.0;
        for (Student student : students) {
            totalGPA += student.getGpa();
        }
        return totalGPA / students.size();
    }
    
    // Method to get students with high GPA (>= 3.5)
    public static List<Student> getHighGPAStudents() {
        List<Student> highGPAStudents = new ArrayList<>();
        for (Student student : students) {
            if (student.getGpa() >= 3.5) {
                highGPAStudents.add(student);
            }
        }
        return highGPAStudents;
    }
} 