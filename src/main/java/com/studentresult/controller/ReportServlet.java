package com.studentresult.controller;

import com.studentresult.dao.ResultDAO;
import com.studentresult.dao.StudentDAO;
import com.studentresult.model.Result;
import com.studentresult.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {

    private StudentDAO studentDAO;
    private ResultDAO resultDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
        resultDAO = new ResultDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            request.setAttribute(
                    "students",
                    studentDAO.getAllStudents()
            );

            request.setAttribute(
                    "sessions",
                    resultDAO.getSessions()
            );

            request.setAttribute(
                    "levels",
                    resultDAO.getLevels()
            );

            request.setAttribute(
                    "semesters",
                    resultDAO.getSemesters()
            );

            request.getRequestDispatcher(
                    "report.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<h1>Database Error</h1>"
            );
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int studentId = Integer.parseInt(
                    request.getParameter("studentId")
            );

            int sessionId = Integer.parseInt(
                    request.getParameter("sessionId")
            );

            int levelId = Integer.parseInt(
                    request.getParameter("levelId")
            );

            int semesterId = Integer.parseInt(
                    request.getParameter("semesterId")
            );

            // Load dropdown information
            request.setAttribute(
                    "students",
                    studentDAO.getAllStudents()
            );

            request.setAttribute(
                    "sessions",
                    resultDAO.getSessions()
            );

            request.setAttribute(
                    "levels",
                    resultDAO.getLevels()
            );

            request.setAttribute(
                    "semesters",
                    resultDAO.getSemesters()
            );

            // Get selected student
            Student student =
                    studentDAO.getStudentById(studentId);

            // Get result records
            List<Result> results =
                    getResults(
                            studentId,
                            sessionId,
                            levelId,
                            semesterId
                    );

            // Calculate totals
            double totalCUP = 0;
            int totalCU = 0;

            for (Result result : results) {

                totalCUP += result.getCourseUnitPoint();

                totalCU += getCreditUnit(
                        result.getCourseId()
                );
            }

            double gpa = 0;

            if (totalCU > 0) {
                gpa = totalCUP / totalCU;
            }

            // Calculate CGPA
            double cgpa =
                    calculateCGPA(studentId);

            request.setAttribute(
                    "student",
                    student
            );

            request.setAttribute(
                    "results",
                    results
            );

            request.setAttribute(
                    "totalCUP",
                    totalCUP
            );

            request.setAttribute(
                    "totalCU",
                    totalCU
            );

            request.setAttribute(
                    "gpa",
                    gpa
            );

            request.setAttribute(
                    "cgpa",
                    cgpa
            );

            request.setAttribute(
                    "reportGenerated",
                    true
            );

            request.getRequestDispatcher(
                    "report.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<h1>Database Error</h1>"
            );
        }
    }


    private List<Result> getResults(
            int studentId,
            int sessionId,
            int levelId,
            int semesterId)
            throws Exception {

        List<Result> results =
                new ArrayList<>();

        String sql = """
                SELECT
                    r.result_id,
                    r.student_id,
                    r.course_id,
                    r.session_id,
                    r.level_id,
                    r.semester_id,
                    r.ca_score,
                    r.exam_score,
                    r.total_score,
                    r.grade,
                    r.grade_point,
                    r.course_unit_point,
                    r.status,

                    c.course_code,
                    c.course_title,
                    c.credit_unit,

                    a.session_name,
                    l.level_name,
                    s.semester_name

                FROM results r

                JOIN courses c
                    ON r.course_id = c.course_id

                JOIN academic_sessions a
                    ON r.session_id = a.session_id

                JOIN levels l
                    ON r.level_id = l.level_id

                JOIN semesters s
                    ON r.semester_id = s.semester_id

                WHERE r.student_id = ?
                  AND r.session_id = ?
                  AND r.level_id = ?
                  AND r.semester_id = ?

                ORDER BY c.course_code
                """;

        try (var connection =
                     com.studentresult.util.DBConnection
                             .getConnection();

             var statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);
            statement.setInt(2, sessionId);
            statement.setInt(3, levelId);
            statement.setInt(4, semesterId);

            try (var rs =
                         statement.executeQuery()) {

                while (rs.next()) {

                    Result result =
                            new Result();

                    result.setResultId(
                            rs.getInt("result_id")
                    );

                    result.setStudentId(
                            rs.getInt("student_id")
                    );

                    result.setCourseId(
                            rs.getInt("course_id")
                    );

                    result.setSessionId(
                            rs.getInt("session_id")
                    );

                    result.setLevelId(
                            rs.getInt("level_id")
                    );

                    result.setSemesterId(
                            rs.getInt("semester_id")
                    );

                    result.setCaScore(
                            rs.getDouble("ca_score")
                    );

                    result.setExamScore(
                            rs.getDouble("exam_score")
                    );

                    result.setTotalScore(
                            rs.getDouble("total_score")
                    );

                    result.setGrade(
                            rs.getString("grade")
                    );

                    result.setGradePoint(
                            rs.getDouble("grade_point")
                    );

                    result.setCourseUnitPoint(
                            rs.getDouble(
                                    "course_unit_point")
                    );

                    result.setStatus(
                            rs.getString("status")
                    );

                    result.setCourseCode(
                            rs.getString("course_code")
                    );

                    result.setCourseTitle(
                            rs.getString("course_title")
                    );

                    result.setCreditUnit(
                            rs.getInt("credit_unit")
                    );

                    result.setSessionName(
                            rs.getString("session_name")
                    );

                    result.setLevelName(
                            rs.getString("level_name")
                    );

                    result.setSemesterName(
                            rs.getString("semester_name")
                    );

                    results.add(result);
                }
            }
        }

        return results;
    }


    private int getCreditUnit(int courseId)
            throws Exception {

        String sql =
                "SELECT credit_unit " +
                        "FROM courses " +
                        "WHERE course_id = ?";

        try (var connection =
                     com.studentresult.util.DBConnection
                             .getConnection();

             var statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, courseId);

            try (var rs =
                         statement.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt("credit_unit");
                }
            }
        }

        return 0;
    }


    private double calculateCGPA(int studentId)
            throws Exception {

        String sql = """
                SELECT
                    SUM(r.course_unit_point)
                        AS total_cup,

                    SUM(c.credit_unit)
                        AS total_cu

                FROM results r

                JOIN courses c
                    ON r.course_id = c.course_id

                WHERE r.student_id = ?
                """;

        try (var connection =
                     com.studentresult.util.DBConnection
                             .getConnection();

             var statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);

            try (var rs =
                         statement.executeQuery()) {

                if (rs.next()) {

                    double totalCUP =
                            rs.getDouble("total_cup");

                    double totalCU =
                            rs.getDouble("total_cu");

                    if (totalCU > 0) {
                        return totalCUP / totalCU;
                    }
                }
            }
        }

        return 0;
    }
}
