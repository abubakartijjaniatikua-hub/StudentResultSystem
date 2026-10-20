package com.studentresult.model;

public class Student {

    private int studentId;
    private String registrationNumber;
    private String fullName;
    private String programme;
    private String currentLevel;
    private String status;

    public Student() {
    }

    public Student(int studentId, String registrationNumber,
                   String fullName, String programme,
                   String currentLevel, String status) {

        this.studentId = studentId;
        this.registrationNumber = registrationNumber;
        this.fullName = fullName;
        this.programme = programme;
        this.currentLevel = currentLevel;
        this.status = status;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getRegistrationNumber() {
        return registrationNumber;
    }

    public void setRegistrationNumber(String registrationNumber) {
        this.registrationNumber = registrationNumber;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getProgramme() {
        return programme;
    }

    public void setProgramme(String programme) {
        this.programme = programme;
    }

    public String getCurrentLevel() {
        return currentLevel;
    }

    public void setCurrentLevel(String currentLevel) {
        this.currentLevel = currentLevel;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}