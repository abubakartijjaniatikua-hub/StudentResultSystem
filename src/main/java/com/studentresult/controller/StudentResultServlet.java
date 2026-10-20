package com.studentresult.controller;

import com.studentresult.dao.ResultDAO;
import com.studentresult.dao.StudentDAO;
import com.studentresult.model.Result;
import com.studentresult.model.Student;
import com.studentresult.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/student-result")
public class StudentResultServlet extends HttpServlet {

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
                    (Integer) session.getAttribute("studentId");

            Student student =
                    studentDAO.getStudentById(studentId);

            request.setAttribute("student", student);
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
                            "student-result.jsp")
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
                    (Integer) session.getAttribute("studentId");

            int sessionId =
                    Integer.parseInt(
                            request.getParameter("sessionId"));

            int levelId =
                    Integer.parseInt(
                            request.getParameter("levelId"));

            int semesterId =
                    Integer.parseInt(
                            request.getParameter("semesterId"));

            Student student =
                    studentDAO.getStudentById(studentId);

            List<Result> results =
                    getStudentResults(
                            studentId,
                            sessionId,
                            levelId,
                            semesterId);

            List<Result> allResults =
                    getAllStudentResults(studentId);

            List<SemesterSummary> summaries =
                    buildSemesterSummaries(
                            allResults,
                            sessionId,
                            levelId,
                            semesterId);

            double totalCUP = 0;
            int totalCU = 0;

            for (Result result : results) {

                totalCUP += result.getCourseUnitPoint();
                totalCU += result.getCreditUnit();
            }

            double gpa = 0;

            if (totalCU > 0) {
                gpa = totalCUP / totalCU;
            }

            double cgpaCUP = 0;
            int cgpaCU = 0;

            for (Result result : allResults) {

                cgpaCUP += result.getCourseUnitPoint();
                cgpaCU += result.getCreditUnit();
            }

            double cgpa = 0;

            if (cgpaCU > 0) {
                cgpa = cgpaCUP / cgpaCU;
            }

            int totalCarryOverCourses = 0;
            int totalCarryOverUnits = 0;

            for (Result result : allResults) {

                if ("Carry Over".equalsIgnoreCase(
                        result.getStatus())) {

                    totalCarryOverCourses++;
                    totalCarryOverUnits +=
                            result.getCreditUnit();
                }
            }

            request.setAttribute("student", student);

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
                    "summaries",
                    summaries);

            request.setAttribute(
                    "totalCU",
                    totalCU);

            request.setAttribute(
                    "totalCUP",
                    totalCUP);

            request.setAttribute(
                    "gpa",
                    gpa);

            request.setAttribute(
                    "cgpa",
                    cgpa);

            request.setAttribute(
                    "totalCarryOverCourses",
                    totalCarryOverCourses);

            request.setAttribute(
                    "totalCarryOverUnits",
                    totalCarryOverUnits);

            request.setAttribute(
                    "resultGenerated",
                    true);

            request.getRequestDispatcher(
                            "student-result.jsp")
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

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);
            statement.setInt(2, sessionId);
            statement.setInt(3, levelId);
            statement.setInt(4, semesterId);

            try (ResultSet rs =
                         statement.executeQuery()) {

                while (rs.next()) {

                    results.add(createResult(rs));
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

                ORDER BY
                    a.session_name,
                    l.level_id,
                    s.semester_id,
                    c.course_code
                """;

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, studentId);

            try (ResultSet rs =
                         statement.executeQuery()) {

                while (rs.next()) {

                    results.add(createResult(rs));
                }
            }
        }

        return results;
    }

    private Result createResult(ResultSet rs)
            throws Exception {

        Result result = new Result();

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
                rs.getDouble("course_unit_point"));

        result.setStatus(
                rs.getString("status"));

        result.setCourseCode(
                rs.getString("course_code"));

        result.setCourseTitle(
                rs.getString("course_title"));

        result.setCreditUnit(
                rs.getInt("credit_unit"));

        result.setSessionName(
                rs.getString("session_name"));

        result.setLevelName(
                rs.getString("level_name"));

        result.setSemesterName(
                rs.getString("semester_name"));

        return result;
    }

    private List<SemesterSummary> buildSemesterSummaries(
            List<Result> allResults,
            int selectedSessionId,
            int selectedLevelId,
            int selectedSemesterId) {

        Map<String, List<Result>> groups =
                new LinkedHashMap<>();

        for (Result result : allResults) {

            String key =
                    result.getSessionId() + "-" +
                            result.getLevelId() + "-" +
                            result.getSemesterId();

            groups.computeIfAbsent(
                            key,
                            k -> new ArrayList<>())
                    .add(result);
        }

        List<List<Result>> orderedGroups =
                new ArrayList<>(groups.values());

        orderedGroups.sort(
                Comparator.comparingInt(
                        group -> semesterOrder(
                                group.get(0))));

        List<SemesterSummary> summaries =
                new ArrayList<>();

        int number = 1;

        for (List<Result> group : orderedGroups) {

            Result first = group.get(0);

            int order =
                    semesterOrder(first);

            int selectedOrder =
                    semesterOrder(
                            selectedSessionId,
                            selectedLevelId,
                            selectedSemesterId,
                            first);

            if (order > selectedOrder) {
                continue;
            }

            int tcu = 0;
            double wgp = 0;
            int coCourses = 0;
            int coUnits = 0;

            for (Result result : group) {

                tcu += result.getCreditUnit();

                wgp += result.getCourseUnitPoint();

                if ("Carry Over".equalsIgnoreCase(
                        result.getStatus())) {

                    coCourses++;

                    coUnits += result.getCreditUnit();
                }
            }

            double gpa = 0;

            if (tcu > 0) {
                gpa = wgp / tcu;
            }

            summaries.add(
                    new SemesterSummary(
                            number,
                            tcu,
                            wgp,
                            gpa,
                            coCourses,
                            coUnits));

            number++;
        }

        return summaries;
    }

    private int semesterOrder(Result result) {

        return semesterOrder(
                result.getSessionId(),
                result.getLevelId(),
                result.getSemesterId(),
                result);
    }

    private int semesterOrder(
            int sessionId,
            int levelId,
            int semesterId,
            Result reference) {

        /*
         * For the student's ND programme:
         *
         * ND I First Semester  = 1
         * ND I Second Semester = 2
         * ND II First Semester = 3
         * ND II Second Semester = 4
         *
         * Session year is also included so that
         * records from earlier academic sessions
         * remain before later sessions.
         */

        int sessionYear = 0;

        try {

            String session =
                    reference.getSessionName();

            if (session != null &&
                    session.length() >= 4) {

                sessionYear =
                        Integer.parseInt(
                                session.substring(0, 4));
            }

        } catch (Exception ignored) {
        }

        int levelValue = levelId;
        int semesterValue = semesterId;

        return sessionYear * 100
                + levelValue * 10
                + semesterValue;
    }

    public static class SemesterSummary {

        private final int number;
        private final int tcu;
        private final double wgp;
        private final double gpa;
        private final int coCourses;
        private final int coUnits;

        public SemesterSummary(
                int number,
                int tcu,
                double wgp,
                double gpa,
                int coCourses,
                int coUnits) {

            this.number = number;
            this.tcu = tcu;
            this.wgp = wgp;
            this.gpa = gpa;
            this.coCourses = coCourses;
            this.coUnits = coUnits;
        }

        public int getNumber() {
            return number;
        }

        public int getTcu() {
            return tcu;
        }

        public double getWgp() {
            return wgp;
        }

        public double getGpa() {
            return gpa;
        }

        public int getCoCourses() {
            return coCourses;
        }

        public int getCoUnits() {
            return coUnits;
        }
    }
}