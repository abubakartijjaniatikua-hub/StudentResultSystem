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

    <title>Student Result Report</title>

    <style>

        * {
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            margin: 0;
            background: #f4f6f9;
            padding: 30px;
        }

        .container {
            max-width: 1100px;
            margin: auto;
        }

        .selection-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 25px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
        }

        .selection-card h2 {
            color: #0d47a1;
            margin-bottom: 20px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 7px;
        }

        select {
            width: 100%;
            padding: 11px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .generate-btn {
            margin-top: 20px;
            padding: 12px 25px;
            background: #0d47a1;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .generate-btn:hover {
            background: #1565c0;
        }

        .report {
            background: white;
            padding: 35px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
        }

        .school-header {
            text-align: center;
            border-bottom: 2px solid #000;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .school-header h1 {
            margin: 5px 0;
            font-size: 24px;
        }

        .school-header h2 {
            margin: 5px 0;
            font-size: 20px;
        }

        .school-header p {
            margin: 5px 0;
        }

        .student-info {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
            margin-bottom: 25px;
        }

        .student-info div {
            padding: 8px;
        }

        .student-info strong {
            display: inline-block;
            min-width: 130px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th {
            background: #0d47a1;
            color: white;
            padding: 10px;
            border: 1px solid #ddd;
            font-size: 13px;
        }

        td {
            padding: 9px;
            border: 1px solid #ddd;
            font-size: 13px;
        }

        .summary {
            margin-top: 25px;
            display: flex;
            justify-content: flex-end;
        }

        .summary table {
            width: 420px;
        }

        .summary td {
            font-weight: bold;
        }

        .print-area {
            margin-top: 25px;
            text-align: center;
        }

        .print-btn {
            padding: 12px 30px;
            background: #0d47a1;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .back {
            display: inline-block;
            margin-top: 20px;
            color: #0d47a1;
            text-decoration: none;
            font-weight: bold;
        }

        .no-result {
            text-align: center;
            padding: 25px;
            color: #777;
        }

        @media (max-width: 700px) {

            body {
                padding: 15px;
            }

            .form-grid,
            .student-info {
                grid-template-columns: 1fr;
            }

            .report {
                padding: 15px;
            }

            .summary {
                justify-content: stretch;
            }

            .summary table {
                width: 100%;
            }
        }


        /* PRINT SETTINGS */

        @media print {

            body {
                background: white;
                padding: 0;
            }

            .selection-card,
            .print-area,
            .back {
                display: none;
            }

            .container {
                max-width: 100%;
            }

            .report {
                box-shadow: none;
                padding: 10px;
            }

            th {
                background: #ddd !important;
                color: black !important;
            }

            @page {
                size: A4;
                margin: 15mm;
            }
        }

    </style>

</head>

<body>

<div class="container">


    <!-- REPORT SELECTION -->

    <div class="selection-card">

        <h2>Generate Student Result Report</h2>

        <form action="report" method="post">

            <div class="form-grid">


                <!-- STUDENT -->

                <div>

                    <label>Student</label>

                    <select name="studentId" required>

                        <option value="">
                            Select Student
                        </option>

                        <%
                            List<Student> students =
                                    (List<Student>)
                                    request.getAttribute(
                                            "students");

                            if (students != null) {

                                for (Student student :
                                        students) {
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


                <!-- SESSION -->

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


                <!-- LEVEL -->

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


                <!-- SEMESTER -->

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


            <button class="generate-btn"
                    type="submit">

                Generate Result Report

            </button>

        </form>

    </div>


    <%

        Boolean reportGenerated =
                (Boolean) request.getAttribute(
                        "reportGenerated");

        Student student =
                (Student) request.getAttribute(
                        "student");

        List<Result> results =
                (List<Result>) request.getAttribute(
                        "results");

        if (Boolean.TRUE.equals(reportGenerated)
                && student != null) {

    %>


    <!-- PRINTABLE REPORT -->

    <div class="report">


        <!-- HEADER -->

        <div class="school-header">

            <h1>KANO STATE POLYTECHNIC</h1>

            <h2>DEPARTMENT OF COMPUTER SCIENCE</h2>

            <p>
                STUDENT SEMESTER RESULT
            </p>

        </div>


        <!-- STUDENT INFORMATION -->

        <div class="student-info">

            <div>
                <strong>Student Name:</strong>

                <%= student.getFullName() %>
            </div>

            <div>
                <strong>Registration No:</strong>

                <%= student.getRegistrationNumber() %>
            </div>

            <div>
                <strong>Programme:</strong>

                <%= student.getProgramme() %>
            </div>

            <div>
                <strong>Current Level:</strong>

                <%= student.getCurrentLevel() %>
            </div>

        </div>


        <!-- RESULT TABLE -->

        <table>

            <thead>

            <tr>

                <th>S/N</th>
                <th>Course Code</th>
                <th>Course Title</th>
                <th>CU</th>
                <th>CA</th>
                <th>Exam</th>
                <th>Total</th>
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

                    int count = 1;

                    for (Result result : results) {

            %>

            <tr>

                <td>
                    <%= count++ %>
                </td>

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
                    <%= result.getCaScore() %>
                </td>

                <td>
                    <%= result.getExamScore() %>
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

                <td colspan="11"
                    class="no-result">

                    No result available.

                </td>

            </tr>

            <%

                }

            %>

            </tbody>

        </table>


        <!-- SUMMARY -->

        <div class="summary">

            <table>

                <tr>

                    <td>
                        Total Credit Unit
                    </td>

                    <td>
                        <%= request.getAttribute(
                                "totalCU") %>
                    </td>

                </tr>

                <tr>

                    <td>
                        Total Course Unit Point
                    </td>

                    <td>
                        <%= String.format(
                                "%.2f",
                                (Double)
                                request.getAttribute(
                                        "totalCUP")) %>
                    </td>

                </tr>

                <tr>

                    <td>
                        GPA
                    </td>

                    <td>
                        <%= String.format(
                                "%.2f",
                                (Double)
                                request.getAttribute(
                                        "gpa")) %>
                    </td>

                </tr>

                <tr>

                    <td>
                        CGPA
                    </td>

                    <td>
                        <%= String.format(
                                "%.2f",
                                (Double)
                                request.getAttribute(
                                        "cgpa")) %>
                    </td>

                </tr>

            </table>

        </div>


        <!-- PRINT BUTTON -->

        <div class="print-area">

            <button class="print-btn"
                    onclick="window.print()">

                 Print Result

            </button>

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