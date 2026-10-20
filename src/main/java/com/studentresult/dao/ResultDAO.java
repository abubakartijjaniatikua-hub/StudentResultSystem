package com.studentresult.dao;

import com.studentresult.model.Result;
import com.studentresult.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ResultDAO {

    public void addResult(Result result) throws SQLException {

        String sql = """
                INSERT INTO results
                (student_id, course_id, session_id, level_id, semester_id,
                 ca_score, exam_score, total_score, grade,
                 grade_point, course_unit_point, status)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, result.getStudentId());
            statement.setInt(2, result.getCourseId());
            statement.setInt(3, result.getSessionId());
            statement.setInt(4, result.getLevelId());
            statement.setInt(5, result.getSemesterId());

            statement.setDouble(6, result.getCaScore());
            statement.setDouble(7, result.getExamScore());
            statement.setDouble(8, result.getTotalScore());

            statement.setString(9, result.getGrade());

            statement.setDouble(10, result.getGradePoint());
            statement.setDouble(11, result.getCourseUnitPoint());

            statement.setString(12, result.getStatus());

            statement.executeUpdate();
        }
    }


    public List<Result> getAllResults() throws SQLException {

        List<Result> results = new ArrayList<>();

        String sql = """
                SELECT
                    r.*,
                    s.full_name,
                    s.registration_number,
                    c.course_code,
                    c.course_title,
                    c.credit_unit,
                    a.session_name,
                    l.level_name,
                    sem.semester_name
                FROM results r
                JOIN students s
                    ON r.student_id = s.student_id
                JOIN courses c
                    ON r.course_id = c.course_id
                JOIN academic_sessions a
                    ON r.session_id = a.session_id
                JOIN levels l
                    ON r.level_id = l.level_id
                JOIN semesters sem
                    ON r.semester_id = sem.semester_id
                ORDER BY r.result_id DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {

                Result result = new Result();

                result.setResultId(rs.getInt("result_id"));

                result.setStudentId(rs.getInt("student_id"));
                result.setCourseId(rs.getInt("course_id"));
                result.setSessionId(rs.getInt("session_id"));
                result.setLevelId(rs.getInt("level_id"));
                result.setSemesterId(rs.getInt("semester_id"));

                result.setStudentName(rs.getString("full_name"));
                result.setRegistrationNumber(
                        rs.getString("registration_number"));

                result.setCourseCode(
                        rs.getString("course_code"));

                result.setCourseTitle(
                        rs.getString("course_title"));

                result.setSessionName(
                        rs.getString("session_name"));

                result.setLevelName(
                        rs.getString("level_name"));

                result.setSemesterName(
                        rs.getString("semester_name"));

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

                results.add(result);
            }
        }

        return results;
    }


    public Result getResultById(int resultId)
            throws SQLException {

        String sql = """
                SELECT
                    r.*,
                    s.full_name,
                    s.registration_number,
                    c.course_code,
                    c.course_title,
                    a.session_name,
                    l.level_name,
                    sem.semester_name
                FROM results r
                JOIN students s
                    ON r.student_id = s.student_id
                JOIN courses c
                    ON r.course_id = c.course_id
                JOIN academic_sessions a
                    ON r.session_id = a.session_id
                JOIN levels l
                    ON r.level_id = l.level_id
                JOIN semesters sem
                    ON r.semester_id = sem.semester_id
                WHERE r.result_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, resultId);

            try (ResultSet rs = statement.executeQuery()) {

                if (rs.next()) {

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

                    result.setStudentName(
                            rs.getString("full_name"));

                    result.setRegistrationNumber(
                            rs.getString("registration_number"));

                    result.setCourseCode(
                            rs.getString("course_code"));

                    result.setCourseTitle(
                            rs.getString("course_title"));

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

                    return result;
                }
            }
        }

        return null;
    }


    public void updateResult(Result result)
            throws SQLException {

        String sql = """
                UPDATE results
                SET student_id = ?,
                    course_id = ?,
                    session_id = ?,
                    level_id = ?,
                    semester_id = ?,
                    ca_score = ?,
                    exam_score = ?,
                    total_score = ?,
                    grade = ?,
                    grade_point = ?,
                    course_unit_point = ?,
                    status = ?
                WHERE result_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, result.getStudentId());
            statement.setInt(2, result.getCourseId());
            statement.setInt(3, result.getSessionId());
            statement.setInt(4, result.getLevelId());
            statement.setInt(5, result.getSemesterId());

            statement.setDouble(6, result.getCaScore());
            statement.setDouble(7, result.getExamScore());
            statement.setDouble(8, result.getTotalScore());

            statement.setString(9, result.getGrade());

            statement.setDouble(10, result.getGradePoint());
            statement.setDouble(11, result.getCourseUnitPoint());

            statement.setString(12, result.getStatus());

            statement.setInt(13, result.getResultId());

            statement.executeUpdate();
        }
    }


    public void deleteResult(int resultId)
            throws SQLException {

        String sql =
                "DELETE FROM results WHERE result_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, resultId);

            statement.executeUpdate();
        }
    }


    public Map<Integer, String> getSessions()
            throws SQLException {

        return getOptions(
                "SELECT session_id, session_name " +
                        "FROM academic_sessions ORDER BY session_id"
        );
    }


    public Map<Integer, String> getLevels()
            throws SQLException {

        return getOptions(
                "SELECT level_id, level_name " +
                        "FROM levels ORDER BY level_id"
        );
    }


    public Map<Integer, String> getSemesters()
            throws SQLException {

        return getOptions(
                "SELECT semester_id, semester_name " +
                        "FROM semesters ORDER BY semester_id"
        );
    }


    private Map<Integer, String> getOptions(String sql)
            throws SQLException {

        Map<Integer, String> options =
                new LinkedHashMap<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {

                options.put(
                        rs.getInt(1),
                        rs.getString(2)
                );
            }
        }

        return options;
    }

public List<Result> searchResults(String keyword) throws SQLException {

    List<Result> results = new ArrayList<>();

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

                st.full_name,
                st.registration_number,

                c.course_code,
                c.course_title,

                a.session_name,
                l.level_name,
                s.semester_name

            FROM results r

            JOIN students st
                ON r.student_id = st.student_id

            JOIN courses c
                ON r.course_id = c.course_id

            JOIN academic_sessions a
                ON r.session_id = a.session_id

            JOIN levels l
                ON r.level_id = l.level_id

            JOIN semesters s
                ON r.semester_id = s.semester_id

            WHERE st.registration_number LIKE ?
               OR st.full_name LIKE ?
               OR c.course_code LIKE ?
               OR c.course_title LIKE ?

            ORDER BY st.full_name, c.course_code
            """;

    try (Connection connection =
                 DBConnection.getConnection();

         PreparedStatement statement =
                 connection.prepareStatement(sql)) {

        String search = "%" + keyword + "%";

        statement.setString(1, search);
        statement.setString(2, search);
        statement.setString(3, search);
        statement.setString(4, search);

        try (ResultSet rs =
                     statement.executeQuery()) {

            while (rs.next()) {

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

                result.setStudentName(
                        rs.getString("full_name"));

                result.setRegistrationNumber(
                        rs.getString("registration_number"));

                result.setCourseCode(
                        rs.getString("course_code"));

                result.setCourseTitle(
                        rs.getString("course_title"));

                result.setSessionName(
                        rs.getString("session_name"));

                result.setLevelName(
                        rs.getString("level_name"));

                result.setSemesterName(
                        rs.getString("semester_name"));

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

                results.add(result);
            }
        }
    }

    return results;
}
}