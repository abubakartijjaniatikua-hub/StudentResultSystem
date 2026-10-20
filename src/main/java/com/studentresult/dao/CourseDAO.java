package com.studentresult.dao;

import com.studentresult.model.Course;
import com.studentresult.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {

    // CREATE
    public void addCourse(Course course) throws SQLException {

        String sql = """
                INSERT INTO courses
                (course_code, course_title, credit_unit, programme)
                VALUES (?, ?, ?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, course.getCourseCode());
            statement.setString(2, course.getCourseTitle());
            statement.setInt(3, course.getCreditUnit());
            statement.setString(4, course.getProgramme());

            statement.executeUpdate();
        }
    }


    // READ ALL COURSES
    public List<Course> getAllCourses() throws SQLException {

        List<Course> courses = new ArrayList<>();

        String sql = "SELECT * FROM courses ORDER BY course_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {

            while (result.next()) {

                Course course = new Course();

                course.setCourseId(
                        result.getInt("course_id"));

                course.setCourseCode(
                        result.getString("course_code"));

                course.setCourseTitle(
                        result.getString("course_title"));

                course.setCreditUnit(
                        result.getInt("credit_unit"));

                course.setProgramme(
                        result.getString("programme"));

                courses.add(course);
            }
        }

        return courses;
    }


    // GET COURSE BY ID
    public Course getCourseById(int courseId)
            throws SQLException {

        String sql =
                "SELECT * FROM courses WHERE course_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, courseId);

            try (ResultSet result = statement.executeQuery()) {

                if (result.next()) {

                    Course course = new Course();

                    course.setCourseId(
                            result.getInt("course_id"));

                    course.setCourseCode(
                            result.getString("course_code"));

                    course.setCourseTitle(
                            result.getString("course_title"));

                    course.setCreditUnit(
                            result.getInt("credit_unit"));

                    course.setProgramme(
                            result.getString("programme"));

                    return course;
                }
            }
        }

        return null;
    }


    // UPDATE
    public void updateCourse(Course course)
            throws SQLException {

        String sql = """
                UPDATE courses
                SET course_code = ?,
                    course_title = ?,
                    credit_unit = ?,
                    programme = ?
                WHERE course_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, course.getCourseCode());
            statement.setString(2, course.getCourseTitle());
            statement.setInt(3, course.getCreditUnit());
            statement.setString(4, course.getProgramme());
            statement.setInt(5, course.getCourseId());

            statement.executeUpdate();
        }
    }


    // DELETE
    public void deleteCourse(int courseId)
            throws SQLException {

        String sql =
                "DELETE FROM courses WHERE course_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, courseId);

            statement.executeUpdate();
        }
    }
}