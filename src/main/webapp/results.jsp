<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.studentresult.model.Student" %>
<%@ page import="com.studentresult.model.Course" %>
<%@ page import="com.studentresult.model.Result" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Result Management</title>

    <style>

        * {
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            margin: 0;
            background: #f4f6f9;
        }

        .header {
            background: #0d47a1;
            color: white;
            padding: 20px;
        }

        .container {
            width: 95%;
            margin: 25px auto;
        }

        .card {
            background: white;
            padding: 25px;
            margin-bottom: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
        }

        h2 {
            color: #0d47a1;
            margin-top: 0;
        }

        .form-grid {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(200px, 1fr));

            gap: 15px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
        }

        select,
        input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        button,
        .btn {
            border: none;
            padding: 10px 15px;
            border-radius: 6px;
            background: #0d47a1;
            color: white;
            text-decoration: none;
            cursor: pointer;
        }

        .btn-danger {
            background: #c62828;
        }

        .btn-warning {
            background: #ef6c00;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
        }

        th,
        td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background: #0d47a1;
            color: white;
        }

        tr:nth-child(even) {
            background: #f8f8f8;
        }

        .back {
            display: inline-block;
            margin-bottom: 20px;
        }

        @media (max-width: 900px) {

            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
        }

    </style>

</head>

<body>

<div class="header">

    <h1>Result Management</h1>

    <p>Computer Science Department</p>

</div>


<div class="container">

    <a href="admin-dashboard.jsp"
       class="btn back">
         Back to Dashboard
    </a>


    <!-- RESULT ENTRY -->

    <div class="card">

        <h2>Enter Student Result</h2>

        <form action="results" method="post">

            <input type="hidden"
                   name="action"
                   value="add">


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
                                    request.getAttribute("students");

                            for (Student student : students) {
                        %>

                            <option value="<%= student.getStudentId() %>">

                                <%= student.getRegistrationNumber() %>
                                -
                                <%= student.getFullName() %>

                            </option>

                        <%
                            }
                        %>

                    </select>

                </div>


                <!-- COURSE -->

                <div>

                    <label>Course</label>

                    <select name="courseId" required>

                        <option value="">
                            Select Course
                        </option>

                        <%
                            List<Course> courses =
                                    (List<Course>)
                                    request.getAttribute("courses");

                            for (Course course : courses) {
                        %>

                            <option value="<%= course.getCourseId() %>">

                                <%= course.getCourseCode() %>
                                -
                                <%= course.getCourseTitle() %>
                                (CU:
                                <%= course.getCreditUnit() %>)

                            </option>

                        <%
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
                            Map<Integer,String> sessions =
                                    (Map<Integer,String>)
                                    request.getAttribute("sessions");

                            for (Map.Entry<Integer,String> entry :
                                    sessions.entrySet()) {
                        %>

                            <option value="<%= entry.getKey() %>">

                                <%= entry.getValue() %>

                            </option>

                        <%
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
                            Map<Integer,String> levels =
                                    (Map<Integer,String>)
                                    request.getAttribute("levels");

                            for (Map.Entry<Integer,String> entry :
                                    levels.entrySet()) {
                        %>

                            <option value="<%= entry.getKey() %>">

                                <%= entry.getValue() %>

                            </option>

                        <%
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
                            Map<Integer,String> semesters =
                                    (Map<Integer,String>)
                                    request.getAttribute("semesters");

                            for (Map.Entry<Integer,String> entry :
                                    semesters.entrySet()) {
                        %>

                            <option value="<%= entry.getKey() %>">

                                <%= entry.getValue() %>

                            </option>

                        <%
                            }
                        %>

                    </select>

                </div>


                <!-- CA -->

                <div>

                    <label>CA Score</label>

                    <input type="number"
                           name="caScore"
                           min="0"
                           max="40"
                           step="0.01"
                           required>

                </div>


                <!-- EXAM -->

                <div>

                    <label>Examination Score</label>

                    <input type="number"
                           name="examScore"
                           min="0"
                           max="60"
                           step="0.01"
                           required>

                </div>

            </div>

            <br>

            <button type="submit">
                Save Result
            </button>

        </form>

    </div>


    <!-- RESULTS TABLE -->

    <div class="card">

        <h2>Registered Results</h2>

        <table>

            <tr>

                <th>Student</th>
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
                <th>Action</th>

            </tr>

            <%

                List<Result> results =
                        (List<Result>)
                        request.getAttribute("results");

                for (Result result : results) {

            %>

            <tr>

                <td>
                    <%= result.getStudentName() %>
                    <br>
                    <small>
                        <%= result.getRegistrationNumber() %>
                    </small>
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
                    <strong>
                        <%= result.getTotalScore() %>
                    </strong>
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

                <td>

                    <a class="btn btn-warning"
                       href="results?action=edit&resultId=<%= result.getResultId() %>">
                        Edit
                    </a>

                    <br><br>

                    <form action="results"
                          method="post"
                          style="display:inline;">

                        <input type="hidden"
                               name="action"
                               value="delete">

                        <input type="hidden"
                               name="resultId"
                               value="<%= result.getResultId() %>">

                        <button type="submit"
                                class="btn-danger"
                                onclick="return confirm('Delete this result?');">

                            Delete

                        </button>

                    </form>

                </td>

            </tr>

            <%
                }
            %>

        </table>

    </div>

</div>

</body>

</html>