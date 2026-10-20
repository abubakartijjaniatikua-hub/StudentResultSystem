<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.studentresult.model.Result" %>
<%@ page import="com.studentresult.model.Student" %>
<%@ page import="com.studentresult.controller.StudentResultServlet.SemesterSummary" %>

<%
    Student student =
            (Student) request.getAttribute("student");

    Map<Integer, String> sessions =
            (Map<Integer, String>)
                    request.getAttribute("sessions");

    Map<Integer, String> levels =
            (Map<Integer, String>)
                    request.getAttribute("levels");

    Map<Integer, String> semesters =
            (Map<Integer, String>)
                    request.getAttribute("semesters");

    List<Result> results =
            (List<Result>)
                    request.getAttribute("results");

    List<SemesterSummary> summaries =
            (List<SemesterSummary>)
                    request.getAttribute("summaries");

    Boolean resultGenerated =
            (Boolean)
                    request.getAttribute("resultGenerated");
%>

<!DOCTYPE html>

<html>

<head>

    <title>Student Semester Report Slip</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f2f2f2;
            margin: 0;
            padding: 25px;
            color: #111;
        }

        .page {
            width: 900px;
            max-width: 100%;
            margin: auto;
            background: white;
            padding: 35px 45px;
            box-shadow: 0 2px 12px rgba(0,0,0,.15);
        }

        .school-header {
            text-align: center;
        }

        .school-header h1 {
            margin: 5px 0;
            font-size: 25px;
            letter-spacing: .5px;
        }

        .school-header h2 {
            margin: 2px 0;
            font-size: 18px;
        }

        .school-header p {
            margin: 3px 0;
            font-size: 13px;
        }

        .office {
            border: 1px solid #555;
            width: 55%;
            margin: 10px auto;
            padding: 5px;
            font-weight: bold;
        }

        .reference {
            display: flex;
            justify-content: space-between;
            margin-top: 18px;
            font-size: 12px;
        }

        .department {
            margin-top: 10px;
            font-size: 13px;
        }

        .title {
            text-align: center;
            font-weight: bold;
            text-decoration: underline;
            margin: 8px 0 12px;
        }

        .student-info {
            width: 100%;
            font-size: 13px;
            line-height: 1.65;
        }

        .student-info td:first-child {
            width: 160px;
            font-weight: bold;
        }

        .semester-title {
            text-align: center;
            font-size: 16px;
            font-weight: bold;
            margin: 10px 0;
        }

        .result-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 12px;
        }

        .result-table th,
        .result-table td {
            border: 1px solid #555;
            padding: 5px 4px;
            text-align: center;
        }

        .result-table th {
            font-weight: bold;
        }

        .result-table td:nth-child(2) {
            text-align: left;
        }

        .summary {
            margin: 22px auto 10px;
            width: 80%;
            font-size: 13px;
        }

        .summary-row {
            display: grid;
            grid-template-columns:
                1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr;
            margin-bottom: 8px;
            align-items: center;
        }

        .summary-row span {
            font-weight: bold;
        }

        .summary-value {
            font-weight: normal !important;
        }

        .final-summary {
            margin-top: 18px;
            display: grid;
            grid-template-columns:
                1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr;
            font-size: 13px;
        }

        .remarks {
            margin-top: 15px;
            font-size: 13px;
            font-weight: bold;
        }

        .signatures {
            display: flex;
            justify-content: space-between;
            margin-top: 55px;
            font-size: 12px;
        }

        .signature-box {
            width: 35%;
            text-align: center;
            border-top: 1px solid #333;
            padding-top: 5px;
        }

        .footer-note {
            text-align: center;
            font-size: 10px;
            font-style: italic;
            margin-top: 25px;
        }

        .controls {
            background: #f7f7f7;
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 8px;
        }

        .controls select,
        .controls button {
            padding: 9px;
            margin: 4px;
        }

        .controls button {
            background: #123b5d;
            color: white;
            border: none;
            cursor: pointer;
        }

        .back-button {
            display: inline-block;
            padding: 9px 16px;
            background: #555;
            color: white;
            text-decoration: none;
            margin-top: 20px;
            border-radius: 4px;
        }

        .print-button {
            padding: 9px 16px;
            background: #123b5d;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        @media print {

            body {
                background: white;
                padding: 0;
            }

            .page {
                width: 100%;
                max-width: none;
                box-shadow: none;
                padding: 10mm 12mm;
            }

            .no-print {
                display: none !important;
            }

            @page {
                size: A4;
                margin: 8mm;
            }
        }
        /* ================= SCHOOL HEADER ================= */

        .school-header {
            display: flex;
            align-items: center;
            justify-content: center;

            gap: 25px;

            margin-bottom: 15px;

            text-align: center;
        }

        .school-logo {
            width: 90px;
            height: 90px;

            object-fit: contain;

            border-radius: 50%;
        }

        .school-details h2 {
            margin: 0;

            font-size: 24px;

            color: #1f4e78;
        }

        .school-details h3 {
            margin: 5px 0;

            font-size: 18px;
        }

        .school-details p {
            margin: 3px 0;

            font-size: 13px;
        }

        .report-title {
            text-align: center;

            border-top: 2px solid #1f4e78;
            border-bottom: 2px solid #1f4e78;

            margin: 15px 0;
        }

        .report-title h3 {
            margin: 8px 0;

            font-size: 16px;
        }


        /* ================= PRINT ================= */

        @media print {

            .school-logo {
                width: 80px;
                height: 80px;
            }

            .school-details h2 {
                font-size: 21px;
            }

            .school-details h3 {
                font-size: 16px;
            }

        }

    </style>

</head>

<body>

<div class="page">

    <!-- Selection controls -->

    <div class="controls no-print">

        <form action="student-result" method="post">

            <select name="sessionId" required>

                <option value="">
                    Academic Session
                </option>

                <% for (
                    Map.Entry<Integer, String> entry
                    : sessions.entrySet()) {
                %>

                    <option value="<%= entry.getKey() %>">
                        <%= entry.getValue() %>
                    </option>

                <% } %>

            </select>


            <select name="levelId" required>

                <option value="">
                    Level
                </option>

                <% for (
                    Map.Entry<Integer, String> entry
                    : levels.entrySet()) {
                %>

                    <option value="<%= entry.getKey() %>">
                        <%= entry.getValue() %>
                    </option>

                <% } %>

            </select>


            <select name="semesterId" required>

                <option value="">
                    Semester
                </option>

                <% for (
                    Map.Entry<Integer, String> entry
                    : semesters.entrySet()) {
                %>

                    <option value="<%= entry.getKey() %>">
                        <%= entry.getValue() %>
                    </option>

                <% } %>

            </select>


            <button type="submit">
                View Result
            </button>

        </form>

    </div>


    <% if (Boolean.TRUE.equals(resultGenerated)) { %>


    <!-- ================= SCHOOL HEADER ================= -->

    <div class="school-header">

        <img src="images/kanopoly-logo.jpg"
             alt="Kano State Polytechnic Logo"
             class="school-logo">

        <div class="school-details">

            <h2>KANO STATE POLYTECHNIC</h2>

            <h3>SCHOOL OF TECHNOLOGY</h3>

            <p>
                Matan Fada Road, P.M.B 3348, Kano
            </p>

            <p>
                OFFICE OF THE DIRECTOR
            </p>

        </div>

    </div>

    <div class="report-title">

        <h3>STUDENT SEMESTER REPORT SLIP</h3>

    </div>


    <div class="reference">

        <span>
            Your Ref: __________________
        </span>

        <span>
            Our Ref: __________________
        </span>

        <span>
            Date: __________________
        </span>

    </div>


    <div class="department">

        <strong>DEPARTMENT</strong>
        &nbsp;&nbsp;&nbsp;
        COMPUTER SCIENCE

    </div>


    <div class="title">
        STUDENT SEMESTER REPORT SLIP
    </div>


    <!-- STUDENT INFORMATION -->

    <table class="student-info">

        <tr>

            <td>NAME OF STUDENT:</td>

            <td>
                <%= student.getFullName() %>
            </td>

        </tr>

        <tr>

            <td>REGISTRATION NUMBER:</td>

            <td>
                <%= student.getRegistrationNumber() %>
            </td>

        </tr>

        <tr>

            <td>PROGRAMME:</td>

            <td>
                <%= student.getProgramme() %>
            </td>

        </tr>

        <tr>

            <td>LEVEL:</td>

            <td>
                <%= student.getCurrentLevel() %>
            </td>

        </tr>

    </table>


    <%
        String selectedSession = "";
        String selectedLevel = "";
        String selectedSemester = "";

        if (results != null && !results.isEmpty()) {

            Result first = results.get(0);

            selectedSession =
                    first.getSessionName();

            selectedLevel =
                    first.getLevelName();

            selectedSemester =
                    first.getSemesterName();
        }
    %>


    <div class="semester-title">

        <%= selectedSemester.toUpperCase() %>
        <%= selectedLevel.toUpperCase() %>
        <%= selectedSession.toUpperCase() %>
        SESSION

    </div>


    <!-- MAIN RESULT TABLE -->

    <table class="result-table">

        <thead>

        <tr>

            <th>CODE</th>
            <th>COURSE</th>
            <th>CA</th>
            <th>EX</th>
            <th>TT</th>
            <th>C.U.</th>
            <th>PT</th>

        </tr>

        </thead>

        <tbody>

        <% if (results != null) {

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
                <%= String.format(
                        "%.0f",
                        result.getCaScore()) %>
            </td>

            <td>
                <%= String.format(
                        "%.0f",
                        result.getExamScore()) %>
            </td>

            <td>
                <%= String.format(
                        "%.0f",
                        result.getTotalScore()) %>
            </td>

            <td>
                <%= result.getCreditUnit() %>
            </td>

            <td>
                <%= String.format(
                        "%.2f",
                        result.getGradePoint()) %>
            </td>

        </tr>

        <%  }
        } %>

        </tbody>

    </table>


    <!-- SEMESTER SUMMARY -->

    <div class="summary">

        <% if (summaries != null) {

            for (SemesterSummary summary
                    : summaries) {
        %>

        <div class="summary-row">

            <span>
                TCU <%= summary.getNumber() %>:
            </span>

            <span class="summary-value">
                <%= summary.getTcu() %>
            </span>

            <span>
                WGP<%= summary.getNumber() %>:
            </span>

            <span class="summary-value">
                <%= String.format(
                        "%.2f",
                        summary.getWgp()) %>
            </span>

            <span>
                GPA <%= summary.getNumber() %>:
            </span>

            <span class="summary-value">
                <%= String.format(
                        "%.2f",
                        summary.getGpa()) %>
            </span>

            <span>
                CO <%= summary.getNumber() %>:
            </span>

            <span class="summary-value">
                <%= summary.getCoCourses() %>
                (<%= summary.getCoUnits() %>)
            </span>

        </div>

        <%  }
        } %>

    </div>


    <!-- CUMULATIVE SUMMARY -->

    <div class="final-summary">

        <div>
            <strong>CCU:</strong>
            <%= request.getAttribute("totalCU") %>
        </div>

        <div>
            <strong>TWGP:</strong>
            <%= String.format(
                    "%.2f",
                    (Double)
                            request.getAttribute(
                                    "totalCUP")) %>
        </div>

        <div>
            <strong>CGPA:</strong>
            <%= String.format(
                    "%.2f",
                    (Double)
                            request.getAttribute(
                                    "cgpa")) %>
        </div>

        <div>
            <strong>TCO:</strong>
            <%= request.getAttribute(
                    "totalCarryOverCourses") %>
            (<%= request.getAttribute(
                    "totalCarryOverUnits") %>)
        </div>

    </div>


    <div class="remarks">

        REMARKS:
        &nbsp;&nbsp;
        U/C

    </div>


    <!-- SIGNATURES -->

    <div class="signatures">

        <div class="signature-box">
            HOD Signature
        </div>

        <div class="signature-box">
            Chief Examination Officer Signature
        </div>

    </div>


    <div class="footer-note">

        This result is not an Academic Transcript,
        and it is subject to Polytechnic Academic
        Board Approval.

    </div>


    <div class="no-print">

        <button
                class="print-button"
                onclick="window.print()">

            Print Result

        </button>

        <a
                href="student-dashboard"
                class="back-button">

            Back to Dashboard

        </a>

    </div>


    <% } %>

</div>

</body>

</html>