<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>

<head>

    <title>Manage Students</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
        }

        .header {
            background-color: #1f4e78;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .container {
            width: 92%;
            margin: 30px auto;
        }

        .form-box {
            background-color: white;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        input, select {
            padding: 10px;
            margin: 5px;
            width: 180px;
        }

        button {
            padding: 10px 20px;
            background-color: #1f4e78;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #1f4e78;
            color: white;
        }

        .delete {
            background-color: #c0392b;
        }

        .back {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            color: #1f4e78;
        }

    </style>

</head>

<body>

<div class="header">

    <h1>Student Result Management System</h1>

    <p>Student Management</p>

</div>


<div class="container">

    <a class="back" href="admin-dashboard.jsp">
         Back to Admin Dashboard
    </a>


    <div class="form-box">

        <h2>Register New Student</h2>

        <form action="students" method="post">

            <input type="hidden"
                   name="action"
                   value="add">

            <input type="text"
                   name="registrationNumber"
                   placeholder="Registration Number"
                   required>

            <input type="text"
                   name="fullName"
                   placeholder="Full Name"
                   required>

            <input type="text"
                   name="programme"
                   value="Computer Science"
                   readonly>

            <select name="currentLevel" required>

                <option value="">Select Level</option>
                <option value="ND I">ND I</option>
                <option value="ND II">ND II</option>

            </select>

            <select name="status" required>

                <option value="Active">Active</option>
                <option value="Inactive">Inactive</option>

            </select>

            <button type="submit">
                Add Student
            </button>

        </form>

    </div>


    <h2>Registered Students</h2>

    <table>

        <tr>

            <th>ID</th>
            <th>Registration Number</th>
            <th>Full Name</th>
            <th>Programme</th>
            <th>Level</th>
            <th>Status</th>
            <th>Action</th>

        </tr>


        <%
            List<com.studentresult.model.Student> students =
                    (List<com.studentresult.model.Student>)
                    request.getAttribute("students");

            if (students != null) {

                for (com.studentresult.model.Student student : students) {
        %>

        <tr>

            <td><%= student.getStudentId() %></td>

            <td>
                <%= student.getRegistrationNumber() %>
            </td>

            <td>
                <%= student.getFullName() %>
            </td>

            <td>
                <%= student.getProgramme() %>
            </td>

            <td>
                <%= student.getCurrentLevel() %>
            </td>

            <td>
                <%= student.getStatus() %>
            </td>

            <td>

               <a href="students?action=edit&studentId=<%= student.getStudentId() %>">
                   <button type="button">Edit</button>
               </a>

               <form action="students" method="post" style="display:inline;">

                   <input type="hidden"
                          name="action"
                          value="delete">

                   <input type="hidden"
                          name="studentId"
                          value="<%= student.getStudentId() %>">

                   <button type="submit"
                           onclick="return confirm('Are you sure you want to delete this student?');">
                       Delete
                   </button>

               </form>

                </form>

            </td>

        </tr>

        <%
                }

            }
        %>

    </table>

</div>

</body>

</html>