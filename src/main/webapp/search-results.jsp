<%@ page import="java.util.List" %>
<%@ page import="com.studentresult.model.Result" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Search Results</title>

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
            max-width: 1400px;
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

        .search-box {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 25px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
        }

        .search-form {
            display: flex;
            gap: 10px;
        }

        .search-form input {
            flex: 1;
            padding: 13px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        .search-form button {
            padding: 13px 25px;
            background: #0d47a1;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .search-form button:hover {
            background: #1565c0;
        }

        .result-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
        }

        .result-card h2 {
            color: #0d47a1;
            margin-bottom: 20px;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1200px;
        }

        th {
            background: #0d47a1;
            color: white;
            padding: 12px;
            text-align: left;
        }

        td {
            padding: 11px;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background: #f5f5f5;
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
            padding: 30px;
            color: #777;
        }

        @media (max-width: 700px) {

            body {
                padding: 15px;
            }

            .search-form {
                flex-direction: column;
            }

            .search-form button {
                width: 100%;
            }
        }

    </style>

</head>

<body>

<div class="container">

    <div class="header">

        <h1>Search Student Results</h1>

        <p>
            Computer Science Department
        </p>

    </div>


    <div class="search-box">

        <form action="search-results"
              method="get"
              class="search-form">

            <input
                    type="text"
                    name="keyword"
                    value="<%= request.getAttribute("keyword") != null
                            ? request.getAttribute("keyword")
                            : "" %>"
                    placeholder="Search registration number, student name, course code..."
                    required>

            <button type="submit">
                Search
            </button>

        </form>

    </div>


    <div class="result-card">

        <h2>Search Results</h2>

        <%
            List<Result> results =
                    (List<Result>)
                    request.getAttribute("results");

            if (results != null &&
                !results.isEmpty()) {
        %>

        <div class="table-container">

            <table>

                <thead>

                <tr>

                    <th>Student</th>
                    <th>Reg. No.</th>
                    <th>Course</th>
                    <th>Session</th>
                    <th>Level</th>
                    <th>Semester</th>
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
                    for (Result result : results) {
                %>

                <tr>

                    <td>
                        <%= result.getStudentName() %>
                    </td>

                    <td>
                        <%= result.getRegistrationNumber() %>
                    </td>

                    <td>
                        <%= result.getCourseCode() %>
                    </td>

                    <td>
                        <%= result.getSessionName() %>
                    </td>

                    <td>
                        <%= result.getLevelName() %>
                    </td>

                    <td>
                        <%= result.getSemesterName() %>
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
                %>

                </tbody>

            </table>

        </div>

        <%
            } else {
        %>

        <div class="no-result">

            No result found.

        </div>

        <%
            }
        %>

    </div>


    <a href="admin-dashboard.jsp"
       class="back">

         Back to Admin Dashboard

    </a>

</div>

</body>

</html>