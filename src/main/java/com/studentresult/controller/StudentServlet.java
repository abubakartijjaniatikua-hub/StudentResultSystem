package com.studentresult.controller;

import com.studentresult.dao.StudentDAO;
import com.studentresult.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {

    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }


    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("action");

            if ("edit".equals(action)) {

                int studentId = Integer.parseInt(
                        request.getParameter("studentId"));

                Student student = studentDAO.getStudentById(studentId);

                request.setAttribute("student", student);

                request.getRequestDispatcher("edit-student.jsp")
                        .forward(request, response);

                return;
            }

            List<Student> students = studentDAO.getAllStudents();

            request.setAttribute("students", students);

            request.getRequestDispatcher("students.jsp")
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

        String action = request.getParameter("action");

        try {

            if ("add".equals(action)) {

                Student student = new Student();

                student.setRegistrationNumber(
                        request.getParameter("registrationNumber"));

                student.setFullName(
                        request.getParameter("fullName"));

                student.setProgramme(
                        request.getParameter("programme"));

                student.setCurrentLevel(
                        request.getParameter("currentLevel"));

                student.setStatus(
                        request.getParameter("status"));

                studentDAO.addStudent(student);

            }

            else if ("update".equals(action)) {

                Student student = new Student();

                student.setStudentId(
                        Integer.parseInt(request.getParameter("studentId")));

                student.setRegistrationNumber(
                        request.getParameter("registrationNumber"));

                student.setFullName(
                        request.getParameter("fullName"));

                student.setProgramme(
                        request.getParameter("programme"));

                student.setCurrentLevel(
                        request.getParameter("currentLevel"));

                student.setStatus(
                        request.getParameter("status"));

                studentDAO.updateStudent(student);
            }

            else if ("delete".equals(action)) {

                int studentId = Integer.parseInt(
                        request.getParameter("studentId"));

                studentDAO.deleteStudent(studentId);
            }

            response.sendRedirect("students");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<h1>Database Error</h1>"
            );
        }
    }
}