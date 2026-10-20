<%@ page import="com.studentresult.model.Student" %>

<%
    Student student = (Student) request.getAttribute("student");
%>

<!DOCTYPE html>
<html>
<head>

    <title>Edit Student</title>

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

        input, select {
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

    <h2>Edit Student</h2>

    <form action="students" method="post">

        <input type="hidden"
               name="action"
               value="update">

        <input type="hidden"
               name="studentId"
               value="<%= student.getStudentId() %>">

        <label>Registration Number:</label>

        <input type="text"
               name="registrationNumber"
               value="<%= student.getRegistrationNumber() %>"
               required>


        <label>Full Name:</label>

        <input type="text"
               name="fullName"
               value="<%= student.getFullName() %>"
               required>


        <label>Programme:</label>

        <input type="text"
               name="programme"
               value="<%= student.getProgramme() %>"
               readonly>


        <label>Current Level:</label>

        <select name="currentLevel">

            <option value="ND I"
                <%= "ND I".equals(student.getCurrentLevel()) ? "selected" : "" %>>
                ND I
            </option>

            <option value="ND II"
                <%= "ND II".equals(student.getCurrentLevel()) ? "selected" : "" %>>
                ND II
            </option>

        </select>


        <label>Status:</label>

        <select name="status">

            <option value="Active"
                <%= "Active".equals(student.getStatus()) ? "selected" : "" %>>
                Active
            </option>

            <option value="Inactive"
                <%= "Inactive".equals(student.getStatus()) ? "selected" : "" %>>
                Inactive
            </option>

        </select>


        <button type="submit">
            Update Student
        </button>

    </form>

    <a class="back" href="students">
         Back to Students
    </a>

</div>

</body>
</html>