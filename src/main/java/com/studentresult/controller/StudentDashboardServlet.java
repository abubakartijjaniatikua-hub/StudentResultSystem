package com.studentresult.controller;

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

@WebServlet("/student-dashboard")
public class StudentDashboardServlet extends HttpServlet {

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

        int studentId =
                (Integer) session.getAttribute("studentId");

        try {

            String sql = """
                    SELECT
                        student_id,
                        registration_number,
                        full_name,
                        programme,
                        current_level,
                        status
                    FROM students
                    WHERE student_id = ?
                    """;

            try (Connection connection =
                         DBConnection.getConnection();
                 PreparedStatement statement =
                         connection.prepareStatement(sql)) {

                statement.setInt(1, studentId);

                try (ResultSet rs =
                             statement.executeQuery()) {

                    if (rs.next()) {

                        request.setAttribute(
                                "studentId",
                                rs.getInt("student_id"));

                        request.setAttribute(
                                "registrationNumber",
                                rs.getString(
                                        "registration_number"));

                        request.setAttribute(
                                "fullName",
                                rs.getString(
                                        "full_name"));

                        request.setAttribute(
                                "programme",
                                rs.getString(
                                        "programme"));

                        request.setAttribute(
                                "currentLevel",
                                rs.getString(
                                        "current_level"));

                        request.setAttribute(
                                "status",
                                rs.getString(
                                        "status"));
                    }
                }
            }

            request.getRequestDispatcher(
                            "student-dashboard.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "<h1>Database Error</h1>"
            );
        }
    }
}