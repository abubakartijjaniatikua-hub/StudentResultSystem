<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.studentresult.model.Student" %>
<%@ page import="com.studentresult.model.Result" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>GPA / CGPA Management</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f4f6f9;
            padding: 30px;
        }

        .container {
            max-width: 1200px;
            margin: auto;
        }

        .header {
            background: #0d47a1;
            color: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 25px;
        }

        .header h1 {
            margin-bottom: 8px;
        }

        .header p {
            opacity: 0.9;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 25px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
        }

        .card h2 {
            color: #0d47a1;
            margin-bottom: 20px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
        }

        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .btn {
            margin-top: 20px;
            padding: 12px 25px;
            background: #0d47a1;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .btn:hover {
            background: #1565c0;
        }

        .summary {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 25px;
        }

        .summary-box {
            background: white;
            padding: 25px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
        }

        .summary-box h3 {
            color: #666;
            margin-bottom: 10px;
        }

        .summary-box .value {
            font-size: 30px;
            font-weight: bold;
            color: #0d47a1;
        }

        .student-info {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #0d47a1;
            color: white;
            padding: 12px;
            text-align: left;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background: #f5f5f5;
        }

        .back {
            display: inline-block;
            margin-top: 10px;
            color: #0d47a1;
            text-decoration: none;
            font-weight: bold;
        }

        @media (max-width: 700px) {

            body {
                padding: 15px;
            }

            .form-grid,
            .summary {
                grid-template-columns: 1fr;
            }
        }

    </style>

</head>

<body>

<div class="container">

    <div class="header">

        <h1>GPA / CGPA Management</h1>

        <p>
            Student Result Management System
        </p>

    </div>


    <div class="card">

        <h2>Select Student Result</h2>

        <form action="gpa" method="post">

            <div class="form-grid">

                <div>

                    <label>Student</label>

                    <select name="studentId" required>

                        <option value="">
                            Select Student
                        </option>

                        <%
                            List<Student> students =
                                    (List<Student>)
                                    request.getAttribute("students");

                            if (students != null) {

                                for (Student student : students) {
                        %>

                        <option value="<%= student.getStudentId() %>">

                            <%= student.getRegistrationNumber() %>
                            -
                            <%= student.getFullName() %>

                        </option>

                        <%
                                }
                            }
                        %>

                    </select>

                </div>


                <div>

                    <label>Academic Session</label>

                    <select name="sessionId" required>

                        <option value="">
                            Select Session
                        </option>

                        <%
                            Map<Integer, String> sessions =
                                    (Map<Integer, String>)
                                    request.getAttribute("sessions");

                            if (sessions != null) {

                                for (Map.Entry<Integer, String> item :
                                        sessions.entrySet()) {
                        %>

                        <option value="<%= item.getKey() %>">
                            <%= item.getValue() %>
                        </option>

                        <%
                                }
                            }
                        %>

                    </select>

                </div>


                <div>

                    <label>Level</label>

                    <select name="levelId" required>

                        <option value="">
                            Select Level
                        </option>

                        <%
                            Map<Integer, String> levels =
                                    (Map<Integer, String>)
                                    request.getAttribute("levels");

                            if (levels != null) {

                                for (Map.Entry<Integer, String> item :
                                        levels.entrySet()) {
                        %>

                        <option value="<%= item.getKey() %>">
                            <%= item.getValue() %>
                        </option>

                        <%
                                }
                            }
                        %>

                    </select>

                </div>


                <div>

                    <label>Semester</label>

                    <select name="semesterId" required>

                        <option value="">
                            Select Semester
                        </option>

                        <%
                            Map<Integer, String> semesters =
                                    (Map<Integer, String>)
                                    request.getAttribute("semesters");

                            if (semesters != null) {

                                for (Map.Entry<Integer, String> item :
                                        semesters.entrySet()) {
                        %>

                        <option value="<%= item.getKey() %>">
                            <%= item.getValue() %>
                        </option>

                        <%
                                }
                            }
                        %>

                    </select>

                </div>

            </div>


            <button type="submit" class="btn">
                Calculate GPA / CGPA
            </button>

        </form>

    </div>


    <%

        Student selectedStudent =
                (Student) request.getAttribute(
                        "selectedStudent");

        List<Result> results =
                (List<Result>) request.getAttribute(
                        "results");

        if (selectedStudent != null) {

    %>

    <div class="card">

        <div class="student-info">

            <strong>Student:</strong>
            <%= selectedStudent.getFullName() %>

            &nbsp;&nbsp;&nbsp;

            <strong>Registration No:</strong>
            <%= selectedStudent.getRegistrationNumber() %>

            &nbsp;&nbsp;&nbsp;

            <strong>Programme:</strong>
            <%= selectedStudent.getProgramme() %>

        </div>


        <div class="summary">

            <div class="summary-box">

                <h3>Total Credit Unit</h3>

                <div class="value">

                    <%= request.getAttribute(
                            "totalCreditUnit") %>

                </div>

            </div>


            <div class="summary-box">

                <h3>Semester GPA</h3>

                <div class="value">

                    <%
                        Double gpa =
                                (Double) request.getAttribute(
                                        "gpa");

                        if (gpa != null) {
                    %>

                        <%= String.format("%.2f", gpa) %>

                    <%
                        }
                    %>

                </div>

            </div>


            <div class="summary-box">

                <h3>CGPA</h3>

                <div class="value">

                    <%
                        Double cgpa =
                                (Double) request.getAttribute(
                                        "cgpa");

                        if (cgpa != null) {
                    %>

                        <%= String.format("%.2f", cgpa) %>

                    <%
                        }
                    %>

                </div>

            </div>

        </div>


        <h2>Semester Result Details</h2>


        <div class="table-container">

            <table>

                <thead>

                <tr>

                    <th>Course Code</th>
                    <th>Course Title</th>
                    <th>CU</th>
                    <th>Score</th>
                    <th>Grade</th>
                    <th>GP</th>
                    <th>CUP</th>
                    <th>Status</th>

                </tr>

                </thead>

                <tbody>

                <%
                    if (results != null &&
                        !results.isEmpty()) {

                        for (Result result : results) {
                %>

                <tr>

                    <td>
                        <%= result.getCourseCode() %>
                    </td>

                    <td>
                        <%= result.getCourseTitle() %>
                    </td>

                    <td>
                        <%= result.getCreditUnit() %>
                    </td>

                    <td>
                        <%= result.getTotalScore() %>
                    </td>

                    <td>
                        <%= result.getGrade() %>
                    </td>

                    <td>
                        <%= result.getGradePoint() %>
                    </td>

                    <td>
                        <%= result.getCourseUnitPoint() %>
                    </td>

                    <td>
                        <%= result.getStatus() %>
                    </td>

                </tr>

                <%
                        }

                    } else {
                %>

                <tr>

                    <td colspan="8"
                        style="text-align:center;">

                        No result found for the selected
                        semester.

                    </td>

                </tr>

                <%
                    }
                %>

                </tbody>

            </table>

        </div>

    </div>

    <%
        }
    %>


    <a href="admin-dashboard.jsp"
       class="back">

         Back to Admin Dashboard

    </a>

</div>

</body>

</html>
