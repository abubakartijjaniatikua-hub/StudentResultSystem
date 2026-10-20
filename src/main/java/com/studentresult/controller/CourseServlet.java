package com.studentresult.controller;

import com.studentresult.dao.CourseDAO;
import com.studentresult.model.Course;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/courses")
public class CourseServlet extends HttpServlet {

    private CourseDAO courseDAO;


    @Override
    public void init() {
        courseDAO = new CourseDAO();
    }


    // READ / EDIT PAGE
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String action = request.getParameter("action");


            // EDIT
            if ("edit".equals(action)) {

                int courseId = Integer.parseInt(
                        request.getParameter("courseId"));

                Course course =
                        courseDAO.getCourseById(courseId);

                request.setAttribute(
                        "course", course);

                request.getRequestDispatcher(
                                "edit-courses.jsp")
                        .forward(request, response);

                return;
            }


            // DISPLAY ALL COURSES

            List<Course> courses =
                    courseDAO.getAllCourses();

            request.setAttribute(
                    "courses", courses);

            request.getRequestDispatcher(
                            "courses.jsp")
                    .forward(request, response);


        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<h1>Database Error</h1>"
            );
        }
    }


    // CREATE / UPDATE / DELETE
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        try {


            // ADD COURSE
            if ("add".equals(action)) {

                Course course = new Course();

                course.setCourseCode(
                        request.getParameter(
                                "courseCode"));

                course.setCourseTitle(
                        request.getParameter(
                                "courseTitle"));

                course.setCreditUnit(
                        Integer.parseInt(
                                request.getParameter(
                                        "creditUnit")));

                course.setProgramme(
                        request.getParameter(
                                "programme"));

                courseDAO.addCourse(course);
            }


            // UPDATE COURSE
            else if ("update".equals(action)) {

                Course course = new Course();

                course.setCourseId(
                        Integer.parseInt(
                                request.getParameter(
                                        "courseId")));

                course.setCourseCode(
                        request.getParameter(
                                "courseCode"));

                course.setCourseTitle(
                        request.getParameter(
                                "courseTitle"));

                course.setCreditUnit(
                        Integer.parseInt(
                                request.getParameter(
                                        "creditUnit")));

                course.setProgramme(
                        request.getParameter(
                                "programme"));

                courseDAO.updateCourse(course);
            }


            // DELETE COURSE
            else if ("delete".equals(action)) {

                int courseId =
                        Integer.parseInt(
                                request.getParameter(
                                        "courseId"));

                courseDAO.deleteCourse(courseId);
            }


            response.sendRedirect("courses");


        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<h1>Database Error</h1>"
            );
        }
    }
}