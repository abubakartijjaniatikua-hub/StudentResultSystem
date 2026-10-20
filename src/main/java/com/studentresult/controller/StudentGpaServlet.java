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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/student-gpa")
public class StudentGpaServlet extends HttpServlet {

    private StudentDAO studentDAO;
    private ResultDAO resultDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
        resultDAO = new ResultDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("studentId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {

            int studentId =
                    (Integer) session.getAttribute(
                            "studentId");

            Student student =
                    studentDAO.getStudentById(studentId);

            request.setAttribute(
                    "student",
                    student);

            request.setAttribute(
                    "sessions",
                    resultDAO.getSessions());

            request.setAttribute(
                    "levels",
                    resultDAO.getLevels());

            request.setAttribute(
                    "semesters",
                    resultDAO.getSemesters());

            request.getRequestDispatcher(
                            "student-gpa.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<h1>Database Error</h1>");
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("studentId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {

            int studentId =
                    (Integer) session.getAttribute(
                            "studentId");

            int sessionId =
                    Integer.parseInt(
                            request.getParameter(
                                    "sessionId"));

            int levelId =
                    Integer.parseInt(
                            request.getParameter(
                                    "levelId"));

            int semesterId =
                    Integer.parseInt(
                            request.getParameter(
                                    "semesterId"));

            Student student =
                    studentDAO.getStudentById(
                            studentId);

            List<Result> results =
                    getStudentResults(
                            studentId,
                            sessionId,
                            levelId,
                            semesterId);

            double totalCUP = 0;
            int totalCreditUnit = 0;

            for (Result result : results) {

                totalCUP +=
                        result.getCourseUnitPoint();

                totalCreditUnit +=
                        result.getCreditUnit();
            }

            double gpa = 0;

            if (totalCreditUnit > 0) {
                gpa = totalCUP / totalCreditUnit;
            }

            // Calculate overall CGPA
            List<Result> allResults =
                    getAllStudentResults(studentId);

            double cgpaCUP = 0;
            int cgpaCU = 0;

            for (Result result : allResults) {

                cgpaCUP +=
                        result.getCourseUnitPoint();

                cgpaCU +=
                        result.getCreditUnit();
            }

            double cgpa = 0;

            if (cgpaCU > 0) {
                cgpa = cgpaCUP / cgpaCU;
            }

            request.setAttribute(
                    "student",
                    student);

            request.setAttribute(
                    "sessions",
                    resultDAO.getSessions());

            request.setAttribute(
                    "levels",
                    resultDAO.getLevels());

            request.setAttribute(
                    "semesters",
                    resultDAO.getSemesters());

            request.setAttribute(
                    "results",
                    results);

            request.setAttribute(
                    "totalCUP",
                    totalCUP);

            request.setAttribute(
                    "totalCreditUnit",
                    totalCreditUnit);

            request.setAttribute(
                    "gpa",
                    gpa);

            request.setAttribute(
                    "cgpa",
                    cgpa);

            request.setAttribute(
                    "resultGenerated",
                    true);

            request.getRequestDispatcher(
                            "student-gpa.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<h1>Database Error</h1>");
        }
    }

    private List<Result> getStudentResults(
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
                            rs.getInt("result_id"));

                    result.setStudentId(
                            rs.getInt("student_id"));

                    result.setCourseId(
                            rs.getInt("course_id"));

                    result.setSessionId(
                            rs.getInt("session_id"));

                    result.setLevelId(
                            rs.getInt("level_id"));

                    result.setSemesterId(
                            rs.getInt("semester_id"));

                    result.setCaScore(
                            rs.getDouble("ca_score"));

                    result.setExamScore(
                            rs.getDouble("exam_score"));

                    result.setTotalScore(
                            rs.getDouble("total_score"));

                    result.setGrade(
                            rs.getString("grade"));

                    result.setGradePoint(
                            rs.getDouble("grade_point"));

                    result.setCourseUnitPoint(
                            rs.getDouble(
                                    "course_unit_point"));

                    result.setStatus(
                            rs.getString("status"));

                    result.setCourseCode(
                            rs.getString("course_code"));

                    result.setCourseTitle(
                            rs.getString("course_title"));

                    result.setCreditUnit(
                            rs.getInt("credit_unit"));

                    result.setSessionName(
                            rs.getString(
                                    "session_name"));

                    result.setLevelName(
                            rs.getString(
                                    "level_name"));

                    result.setSemesterName(
                            rs.getString(
                                    "semester_name"));

                    results.add(result);
                }
            }
        }

        return results;
    }

    private List<Result> getAllStudentResults(
            int studentId)
            throws Exception {

        List<Result> results =
                new ArrayList<>();

        String sql = """
                SELECT
                    r.course_id,
                    r.course_unit_point,
                    c.credit_unit

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

                while (rs.next()) {

                    Result result =
                            new Result();

                    result.setCourseId(
                            rs.getInt("course_id"));

                    result.setCourseUnitPoint(
                            rs.getDouble(
                                    "course_unit_point"));

                    result.setCreditUnit(
                            rs.getInt("credit_unit"));

                    results.add(result);
                }
            }
        }

        return results;
    }
}