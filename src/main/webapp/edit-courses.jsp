<%@ page import="com.studentresult.model.Course" %>

<%
    Course course =
            (Course) request.getAttribute("course");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Edit Course</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            padding: 30px;
        }

        .container {
            width: 500px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
        }

        label {
            display: block;
            margin-top: 15px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        button {
            margin-top: 20px;
            padding: 10px 20px;
            cursor: pointer;
        }

        .back {
            display: inline-block;
            margin-top: 15px;
        }

    </style>

</head>


<body>

<div class="container">

    <h2>Edit Course</h2>


    <form action="courses" method="post">

        <input type="hidden"
               name="action"
               value="update">


        <input type="hidden"
               name="courseId"
               value="<%= course.getCourseId() %>">


        <label>Course Code:</label>

        <input type="text"
               name="courseCode"
               value="<%= course.getCourseCode() %>"
               required>


        <label>Course Title:</label>

        <input type="text"
               name="courseTitle"
               value="<%= course.getCourseTitle() %>"
               required>


        <label>Credit Unit:</label>

        <input type="number"
               name="creditUnit"
               value="<%= course.getCreditUnit() %>"
               min="1"
               max="6"
               required>


        <label>Programme:</label>

        <input type="text"
               name="programme"
               value="<%= course.getProgramme() %>"
               readonly>


        <button type="submit">

            Update Course

        </button>

    </form>


    <a class="back"
       href="courses">

         Back to Courses

    </a>

</div>

</body>

</html>