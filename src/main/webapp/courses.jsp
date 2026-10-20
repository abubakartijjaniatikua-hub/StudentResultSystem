<%@ page import="java.util.List" %>
<%@ page import="com.studentresult.model.Course" %>

<%
    List<Course> courses =
            (List<Course>) request.getAttribute("courses");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Course Management</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 30px;
        }

        .container {
            width: 95%;
            margin: auto;
        }

        h1 {
            text-align: center;
        }

        .form-box {
            background: white;
            padding: 25px;
            margin-bottom: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .form-row {
            display: grid;
            grid-template-columns:
                repeat(4, 1fr);

            gap: 15px;
        }

        input {
            padding: 10px;
            width: 100%;
            box-sizing: border-box;
        }

        button {
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        .add-button {
            margin-top: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th,
        td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #f0f0f0;
        }

        .action-button {
            text-decoration: none;
        }

        .delete-form {
            display: inline;
        }

        .back {
            display: inline-block;
            margin-top: 20px;
        }

    </style>

</head>


<body>

<div class="container">

    <h1>Course Management</h1>


    <!-- ADD COURSE -->

    <div class="form-box">

        <h2>Add New Course</h2>

        <form action="courses" method="post">

            <input type="hidden"
                   name="action"
                   value="add">


            <div class="form-row">

                <input type="text"
                       name="courseCode"
                       placeholder="Course Code"
                       required>


                <input type="text"
                       name="courseTitle"
                       placeholder="Course Title"
                       required>


                <input type="number"
                       name="creditUnit"
                       placeholder="Credit Unit"
                       min="1"
                       max="6"
                       required>


                <input type="text"
                       name="programme"
                       value="Computer Science"
                       readonly>

            </div>


            <button class="add-button"
                    type="submit">

                Add Course

            </button>

        </form>

    </div>


    <!-- COURSE TABLE -->

    <h2>Registered Courses</h2>


    <table>

        <tr>

            <th>ID</th>

            <th>Course Code</th>

            <th>Course Title</th>

            <th>Credit Unit</th>

            <th>Programme</th>

            <th>Action</th>

        </tr>


        <%

            if (courses != null) {

                for (Course course : courses) {

        %>

        <tr>

            <td>
                <%= course.getCourseId() %>
            </td>

            <td>
                <%= course.getCourseCode() %>
            </td>

            <td>
                <%= course.getCourseTitle() %>
            </td>

            <td>
                <%= course.getCreditUnit() %>
            </td>

            <td>
                <%= course.getProgramme() %>
            </td>

            <td>

                <a class="action-button"
                   href="courses?action=edit&courseId=<%= course.getCourseId() %>">

                    <button type="button">
                        Edit
                    </button>

                </a>


                <form class="delete-form"
                      action="courses"
                      method="post">

                    <input type="hidden"
                           name="action"
                           value="delete">

                    <input type="hidden"
                           name="courseId"
                           value="<%= course.getCourseId() %>">


                    <button type="submit"
                            onclick="return confirm('Are you sure you want to delete this course?');">

                        Delete

                    </button>

                </form>

            </td>

        </tr>

        <%

                }

            }

        %>

    </table>


    <a class="back"
       href="admin-dashboard.jsp">

         Back to Admin Dashboard

    </a>

</div>

</body>

</html>