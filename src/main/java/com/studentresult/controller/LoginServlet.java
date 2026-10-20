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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        String sql = """
                SELECT user_id,
                       username,
                       password,
                       role,
                       student_id
                FROM users
                WHERE username = ?
                AND password = ?
                """;

        try (Connection connection =
                     DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, username);
            statement.setString(2, password);

            try (ResultSet result =
                         statement.executeQuery()) {

                if (result.next()) {

                    int userId =
                            result.getInt("user_id");

                    String loggedUsername =
                            result.getString("username");

                    String role =
                            result.getString("role");

                    int studentId =
                            result.getInt("student_id");

                    HttpSession session =
                            request.getSession();

                    session.setAttribute(
                            "userId",
                            userId);

                    session.setAttribute(
                            "username",
                            loggedUsername);

                    session.setAttribute(
                            "role",
                            role);

                    // Store student ID only for student accounts
                    if ("Student".equals(role)) {

                        if (result.wasNull()) {

                            response.sendRedirect(
                                    "login.jsp?error=studentnotlinked");

                            return;
                        }

                        session.setAttribute(
                                "studentId",
                                studentId);
                    }

                    if ("Admin".equals(role)) {

                        response.sendRedirect(
                                "admin-dashboard.jsp");

                    } else if ("Student".equals(role)) {

                        response.sendRedirect(
                                "student-dashboard");

                    } else {

                        session.invalidate();

                        response.sendRedirect(
                                "login.jsp?error=invalidrole");
                    }

                } else {

                    response.sendRedirect(
                            "login.jsp?error=invalid");
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "login.jsp?error=database");
        }
    }
}