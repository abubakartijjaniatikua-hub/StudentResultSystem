<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.studentresult.model.Result" %>
<%@ page import="com.studentresult.model.Student" %>

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

    Boolean resultGenerated =
            (Boolean)
                    request.getAttribute(
                            "resultGenerated");
%>

<!DOCTYPE html>
<html>
<head>

    <title>Student GPA / CGPA</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 30px;
        }

        .container {
            max-width: 1100px;
            margin: auto;
        }

        .header {
            background: #123b5d;
            color: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,.08);
        }

        select,
        button {
            padding: 11px;
            margin: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        button {
            background: #123b5d;
            color: white;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th,
        td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background: #123b5d;
            color: white;
        }

        .summary {
            display: flex;
            gap: 20px;
            margin-top: 20px;
        }

        .summary-box {
            flex: 1;
            background: #eef3f7;
            padding: 20px;
            text-align: center;
            border-radius: 8px;
        }

        .summary-box h2 {
            margin: 5px;
            color: #123b5d;
        }

        .back {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            background: #555;
            color: white;
            padding: 10px 18px;
            border-radius: 5px;
        }

    </style>

</head>

<body>

<div class="container">

    <div class="header">

        <h1>GPA / CGPA</h1>

        <p>
            Student:
            <strong>
                <%= student != null
                        ? student.getFullName()
                        : "" %>
            </strong>
        </p>

        <p>
            Registration Number:
            <strong>
                <%= student != null
                        ? student.getRegistrationNumber()
                        : "" %>
            </strong>
        </p>

    </div>


    <div class="card">

        <h2>Select Academic Period</h2>

        <form action="student-gpa" method="post">

            <select name="sessionId" required>

                <option value="">
                    Academic Session
                </option>

                <% for (Map.Entry<Integer, String> entry
                        : sessions.entrySet()) { %>

                    <option value="<%= entry.getKey() %>">
                        <%= entry.getValue() %>
                    </option>

                <% } %>

            </select>


            <select name="levelId" required>

                <option value="">
                    Level
                </option>

                <% for (Map.Entry<Integer, String> entry
                        : levels.entrySet()) { %>

                    <option value="<%= entry.getKey() %>">
                        <%= entry.getValue() %>
                    </option>

                <% } %>

            </select>


            <select name="semesterId" required>

                <option value="">
                    Semester
                </option>

                <% for (Map.Entry<Integer, String> entry
                        : semesters.entrySet()) { %>

                    <option value="<%= entry.getKey() %>">
                        <%= entry.getValue() %>
                    </option>

                <% } %>

            </select>

            <button type="submit">
                Calculate GPA
            </button>

        </form>

    </div>


    <% if (Boolean.TRUE.equals(resultGenerated)) { %>

    <div class="card">

        <h2>Semester Result</h2>

        <% if (results != null && !results.isEmpty()) { %>

        <table>

            <tr>
                <th>Course</th>
                <th>CU</th>
                <th>Grade</th>
                <th>GP</th>
                <th>CUP</th>
            </tr>

            <% for (Result result : results) { %>

            <tr>

                <td>
                    <%= result.getCourseCode() %>
                    -
                    <%= result.getCourseTitle() %>
                </td>

                <td>
                    <%= result.getCreditUnit() %>
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

            </tr>

            <% } %>

        </table>


        <div class="summary">

            <div class="summary-box">

                <p>Total Credit Unit</p>

                <h2>
                    <%= request.getAttribute(
                            "totalCreditUnit") %>
                </h2>

            </div>


            <div class="summary-box">

                <p>Total CUP</p>

                <h2>
                    <%= request.getAttribute(
                            "totalCUP") %>
                </h2>

            </div>


            <div class="summary-box">

                <p>Semester GPA</p>

                <h2>
                    <%= String.format(
                            "%.2f",
                            (Double) request.getAttribute(
                                    "gpa")) %>
                </h2>

            </div>


            <div class="summary-box">

                <p>Overall CGPA</p>

                <h2>
                    <%= String.format(
                            "%.2f",
                            (Double) request.getAttribute(
                                    "cgpa")) %>
                </h2>

            </div>

        </div>

        <% } else { %>

            <p>
                No result found for the selected
                academic period.
            </p>

        <% } %>

    </div>

    <% } %>


    <a href="student-dashboard"
       class="back">
        Back to Dashboard
    </a>

</div>

</body>
</html>