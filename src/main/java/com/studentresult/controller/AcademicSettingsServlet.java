package com.studentresult.controller;

import com.studentresult.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/academic-settings")
public class AcademicSettingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            loadData(request);

            request.getRequestDispatcher(
                    "academic-settings.jsp"
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

        String action = request.getParameter("action");
        String type = request.getParameter("type");

        try {

            if ("add".equals(action)) {

                addRecord(
                        type,
                        request.getParameter("name")
                );

            } else if ("update".equals(action)) {

                updateRecord(
                        type,
                        Integer.parseInt(
                                request.getParameter("id")
                        ),
                        request.getParameter("name")
                );

            } else if ("delete".equals(action)) {

                deleteRecord(
                        type,
                        Integer.parseInt(
                                request.getParameter("id")
                        )
                );
            }

            response.sendRedirect(
                    "academic-settings"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "academic-settings?error=true"
            );
        }
    }


    private void addRecord(String type,
                           String name)
            throws Exception {

        String table;
        String column;

        if ("session".equals(type)) {

            table = "academic_sessions";
            column = "session_name";

        } else if ("level".equals(type)) {

            table = "levels";
            column = "level_name";

        } else if ("semester".equals(type)) {

            table = "semesters";
            column = "semester_name";

        } else {
            throw new IllegalArgumentException(
                    "Invalid type"
            );
        }

        String sql =
                "INSERT INTO " + table +
                        " (" + column + ") VALUES (?)";

        try (Connection connection =
                     DBConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, name);
            statement.executeUpdate();
        }
    }


    private void updateRecord(String type,
                              int id,
                              String name)
            throws Exception {

        String table;
        String column;
        String idColumn;

        if ("session".equals(type)) {

            table = "academic_sessions";
            column = "session_name";
            idColumn = "session_id";

        } else if ("level".equals(type)) {

            table = "levels";
            column = "level_name";
            idColumn = "level_id";

        } else if ("semester".equals(type)) {

            table = "semesters";
            column = "semester_name";
            idColumn = "semester_id";

        } else {
            throw new IllegalArgumentException(
                    "Invalid type"
            );
        }

        String sql =
                "UPDATE " + table +
                        " SET " + column + " = ?" +
                        " WHERE " + idColumn + " = ?";

        try (Connection connection =
                     DBConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, name);
            statement.setInt(2, id);

            statement.executeUpdate();
        }
    }


    private void deleteRecord(String type,
                              int id)
            throws Exception {

        String table;
        String idColumn;

        if ("session".equals(type)) {

            table = "academic_sessions";
            idColumn = "session_id";

        } else if ("level".equals(type)) {

            table = "levels";
            idColumn = "level_id";

        } else if ("semester".equals(type)) {

            table = "semesters";
            idColumn = "semester_id";

        } else {
            throw new IllegalArgumentException(
                    "Invalid type"
            );
        }

        String sql =
                "DELETE FROM " + table +
                        " WHERE " + idColumn + " = ?";

        try (Connection connection =
                     DBConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            statement.executeUpdate();
        }
    }


    private void loadData(HttpServletRequest request)
            throws Exception {

        request.setAttribute(
                "sessions",
                getRecords(
                        "academic_sessions",
                        "session_id",
                        "session_name"
                )
        );

        request.setAttribute(
                "levels",
                getRecords(
                        "levels",
                        "level_id",
                        "level_name"
                )
        );

        request.setAttribute(
                "semesters",
                getRecords(
                        "semesters",
                        "semester_id",
                        "semester_name"
                )
        );
    }


    private List<Map<String, Object>> getRecords(
            String table,
            String idColumn,
            String nameColumn)
            throws Exception {

        List<Map<String, Object>> records =
                new ArrayList<>();

        String sql =
                "SELECT " + idColumn +
                        ", " + nameColumn +
                        " FROM " + table +
                        " ORDER BY " + idColumn;

        try (Connection connection =
                     DBConnection.getConnection();

             PreparedStatement statement =
                     connection.prepareStatement(sql);

             ResultSet result =
                     statement.executeQuery()) {

            while (result.next()) {

                Map<String, Object> record =
                        new HashMap<>();

                record.put(
                        "id",
                        result.getInt(idColumn)
                );

                record.put(
                        "name",
                        result.getString(nameColumn)
                );

                records.add(record);
            }
        }

        return records;
    }
}