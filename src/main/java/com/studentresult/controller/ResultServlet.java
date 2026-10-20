package com.studentresult.controller;

import com.studentresult.dao.CourseDAO;
import com.studentresult.dao.ResultDAO;
import com.studentresult.dao.StudentDAO;
import com.studentresult.model.Course;
import com.studentresult.model.Result;
import com.studentresult.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/results")
public class ResultServlet extends HttpServlet {

    private ResultDAO resultDAO;
    private StudentDAO studentDAO;
    private CourseDAO courseDAO;

    @Override
    public void init() {

        resultDAO = new ResultDAO();
        studentDAO = new StudentDAO();
        courseDAO = new CourseDAO();
    }


    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String action =
                    request.getParameter("action");

            if ("edit".equals(action)) {

                int resultId =
                        Integer.parseInt(
                                request.getParameter("resultId"));

                Result result =
                        resultDAO.getResultById(resultId);

                request.setAttribute(
                        "result", result);

                loadFormData(request);

                request.getRequestDispatcher(
                                "edit-result.jsp")
                        .forward(request, response);

                return;
            }

            loadFormData(request);

            List<Result> results =
                    resultDAO.getAllResults();

            request.setAttribute(
                    "results", results);

            request.getRequestDispatcher(
                            "results.jsp")
                    .forward(request, response);

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

        String action =
                request.getParameter("action");

        try {

            if ("add".equals(action)) {

                Result result =
                        createResultFromRequest(request);

                resultDAO.addResult(result);

            } else if ("update".equals(action)) {

                Result result =
                        createResultFromRequest(request);

                result.setResultId(
                        Integer.parseInt(
                                request.getParameter(
                                        "resultId")));

                resultDAO.updateResult(result);

            } else if ("delete".equals(action)) {

                int resultId =
                        Integer.parseInt(
                                request.getParameter(
                                        "resultId"));

                resultDAO.deleteResult(resultId);
            }

            response.sendRedirect("results");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<h1>Database Error</h1>"
            );
        }
    }


    private Result createResultFromRequest(
            HttpServletRequest request) {

        Result result = new Result();

        result.setStudentId(
                Integer.parseInt(
                        request.getParameter("studentId")));

        result.setCourseId(
                Integer.parseInt(
                        request.getParameter("courseId")));

        result.setSessionId(
                Integer.parseInt(
                        request.getParameter("sessionId")));

        result.setLevelId(
                Integer.parseInt(
                        request.getParameter("levelId")));

        result.setSemesterId(
                Integer.parseInt(
                        request.getParameter("semesterId")));

        double ca;
        double exam;

        try {

            ca = Double.parseDouble(
                    request.getParameter("caScore"));

            exam = Double.parseDouble(
                    request.getParameter("examScore"));

        } catch (NumberFormatException e) {

            throw new IllegalArgumentException(
                    "CA and Exam scores must be valid numbers."
            );
        }

        if (ca < 0 || ca > 40) {

            throw new IllegalArgumentException(
                    "CA score must be between 0 and 40."
            );
        }

        if (exam < 0 || exam > 60) {

            throw new IllegalArgumentException(
                    "Exam score must be between 0 and 60."
            );
        }

        double total = ca + exam;

        String grade = calculateGrade(total);

        double gradePoint =
                calculateGradePoint(total);

        int creditUnit =
                getCreditUnit(
                        result.getCourseId());

        double cup =
                creditUnit * gradePoint;

        String status;

        if (total >= 40) {
            status = "Passed";
        } else {
            status = "Carry Over";
        }

        result.setCaScore(ca);
        result.setExamScore(exam);
        result.setTotalScore(total);
        result.setGrade(grade);
        result.setGradePoint(gradePoint);
        result.setCourseUnitPoint(cup);
        result.setStatus(status);

        return result;
    }


    private String calculateGrade(double total) {


        if (total >= 75) {
            return "A";
        } else if (total >= 70) {
            return "AB";
        } else if (total >= 65) {
            return "B";
        } else if (total >= 60) {
            return "BC";
        } else if (total >= 55) {
            return "C";
        } else if (total >= 50) {
            return "CD";
        } else if (total >= 45) {
            return "D";
        } else if (total >= 40) {
            return "E";
        } else {
            return "F";
        }
    }


    private double calculateGradePoint(double total) {

        if (total >= 75) {
            return 4.00;
        } else if (total >= 70) {
            return 3.50;
        } else if (total >= 65) {
            return 3.25;
        } else if (total >= 60) {
            return 3.00;
        } else if (total >= 55) {
            return 2.75;
        } else if (total >= 50) {
            return 2.50;
        } else if (total >= 45) {
            return 2.25;
        } else if (total >= 40) {
            return 2.00;
        } else {
            return 0.00;
        }
    }


    private int getCreditUnit(int courseId)
            throws RuntimeException {

        try {

            Course course =
                    courseDAO.getCourseById(courseId);

            if (course != null) {
                return course.getCreditUnit();
            }

            throw new RuntimeException(
                    "Course not found.");

        } catch (Exception e) {

            throw new RuntimeException(
                    "Unable to get course credit unit.", e);
        }
    }


    private void loadFormData(HttpServletRequest request)
            throws Exception {

        List<Student> students =
                studentDAO.getAllStudents();

        List<Course> courses =
                courseDAO.getAllCourses();

        Map<Integer, String> sessions =
                resultDAO.getSessions();

        Map<Integer, String> levels =
                resultDAO.getLevels();

        Map<Integer, String> semesters =
                resultDAO.getSemesters();

        request.setAttribute(
                "students", students);

        request.setAttribute(
                "courses", courses);

        request.setAttribute(
                "sessions", sessions);

        request.setAttribute(
                "levels", levels);

        request.setAttribute(
                "semesters", semesters);
    }
}
