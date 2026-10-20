package com.studentresult.dao;

import com.studentresult.model.Student;
import com.studentresult.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    // CREATE
    public void addStudent(Student student) throws SQLException {

        String sql = """
                INSERT INTO students
                (registration_number, full_name, programme, current_level, status)
                VALUES (?, ?, ?, ?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, student.getRegistrationNumber());
            statement.setString(2, student.getFullName());
            statement.setString(3, student.getProgramme());
            statement.setString(4, student.getCurrentLevel());
            statement.setString(5, student.getStatus());

            statement.executeUpdate();
        }
    }


    // UPDATE
    public void updateStudent(Student student) throws SQLException {

        String sql = """
            UPDATE students
            SET registration_number = ?,
                full_name = ?,
                programme = ?,
                current_level = ?,
                status = ?
            WHERE student_id = ?
            """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, student.getRegistrationNumber());
            statement.setString(2, student.getFullName());
            statement.setString(3, student.getProgramme());
            statement.setString(4, student.getCurrentLevel());
            statement.setString(5, student.getStatus());
            statement.setInt(6, student.getStudentId());

            statement.executeUpdate();
        }
    }


    // READ
    public List<Student> getAllStudents() throws SQLException {

        List<Student> students = new ArrayList<>();

        String sql = "SELECT * FROM students ORDER BY student_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {

            while (result.next()) {

                Student student = new Student();

                student.setStudentId(result.getInt("student_id"));
                student.setRegistrationNumber(
                        result.getString("registration_number"));
                student.setFullName(
                        result.getString("full_name"));
                student.setProgramme(
                        result.getString("programme"));
                student.setCurrentLevel(
                        result.getString("current_level"));
                student.setStatus(
                        result.getString("status"));

                students.add(student);
            }
        }

        return students;
    }

    // GET STUDENT BY ID
    public Student getStudentById(int studentId) throws SQLException {

        String sql = "SELECT * FROM students WHERE student_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);

            try (ResultSet result = statement.executeQuery()) {

                if (result.next()) {

                    Student student = new Student();

                    student.setStudentId(
                            result.getInt("student_id"));

                    student.setRegistrationNumber(
                            result.getString("registration_number"));

                    student.setFullName(
                            result.getString("full_name"));

                    student.setProgramme(
                            result.getString("programme"));

                    student.setCurrentLevel(
                            result.getString("current_level"));

                    student.setStatus(
                            result.getString("status"));

                    return student;
                }
            }
        }

        return null;
    }

    // DELETE
    public void deleteStudent(int studentId) throws SQLException {

        String sql = "DELETE FROM students WHERE student_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);

            statement.executeUpdate();
        }
    }
}