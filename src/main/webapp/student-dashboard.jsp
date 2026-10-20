<%@ page session="true" %>

<%
    String username =
            (String) session.getAttribute("username");

    String role =
            (String) session.getAttribute("role");

    String fullName =
            (String) request.getAttribute("fullName");

    String registrationNumber =
            (String) request.getAttribute("registrationNumber");

    String programme =
            (String) request.getAttribute("programme");

    String currentLevel =
            (String) request.getAttribute("currentLevel");

    String status =
            (String) request.getAttribute("status");

    if (username == null ||
            role == null ||
            !"Student".equals(role)) {

        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Student Dashboard</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f4f6f9;
            color: #333;
        }

        .header {
            background: #003366;
            color: white;
            padding: 20px 40px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 24px;
        }

        .user-info {
            text-align: right;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 30px auto;
        }

        .welcome {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 25px;

            box-shadow:
                    0 3px 10px rgba(0,0,0,0.08);
        }

        .welcome h2 {
            color: #003366;
            margin-bottom: 8px;
        }

        .profile {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 25px;

            box-shadow:
                    0 3px 10px rgba(0,0,0,0.08);
        }

        .profile h3 {
            color: #003366;
            margin-bottom: 20px;
        }

        .profile-grid {
            display: grid;
            grid-template-columns:
                    repeat(auto-fit, minmax(200px, 1fr));

            gap: 15px;
        }

        .profile-item {
            background: #f7f9fc;
            padding: 15px;
            border-radius: 8px;
        }

        .profile-item strong {
            display: block;
            color: #555;
            margin-bottom: 5px;
        }

        .cards {
            display: grid;

            grid-template-columns:
                    repeat(auto-fit, minmax(220px, 1fr));

            gap: 20px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;

            box-shadow:
                    0 3px 10px rgba(0,0,0,0.08);

            text-align: center;
        }

        .card h3 {
            color: #003366;
            margin-bottom: 10px;
        }

        .card p {
            color: #666;
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            text-decoration: none;

            background: #003366;
            color: white;

            padding: 10px 18px;
            border-radius: 6px;

            transition: 0.3s;
        }

        .btn:hover {
            background: #00509e;
        }

        .logout {
            background: #b30000;
        }

        .logout:hover {
            background: #d00000;
        }

        .status {
            color: green;
            font-weight: bold;
        }

    </style>

</head>

<body>

<div class="header">

    <h1>
        Student Result System
    </h1>

    <div class="user-info">

        <strong>
            <%= fullName %>
        </strong>

        <br>

        <small>
            Student
        </small>

    </div>

</div>


<div class="container">


    <div class="welcome">

        <h2>
            Welcome, <%= fullName %>!
        </h2>

        <p>
            Welcome to the Computer Science Department
            Student Result Management System.
        </p>

    </div>


    <!-- STUDENT INFORMATION -->

    <div class="profile">

        <h3>
            Student Information
        </h3>

        <div class="profile-grid">

            <div class="profile-item">

                <strong>
                    Full Name
                </strong>

                <%= fullName %>

            </div>


            <div class="profile-item">

                <strong>
                    Registration Number
                </strong>

                <%= registrationNumber %>

            </div>


            <div class="profile-item">

                <strong>
                    Programme
                </strong>

                <%= programme %>

            </div>


            <div class="profile-item">

                <strong>
                    Current Level
                </strong>

                <%= currentLevel %>

            </div>


            <div class="profile-item">

                <strong>
                    Status
                </strong>

                <span class="status">
                    <%= status %>
                </span>

            </div>

        </div>

    </div>


    <!-- DASHBOARD CARDS -->

    <div class="cards">


        <div class="card">

            <h3>
                My Result
            </h3>

            <p>
                View your semester examination result.
            </p>

            <a href="student-result"
               class="btn">

                View Result

            </a>

        </div>


        <div class="card">

            <h3>
                GPA / CGPA
            </h3>

            <p>
                View your GPA and cumulative academic
                performance.
            </p>

            <a href="student-gpa"
               class="btn">

                View GPA

            </a>

        </div>


        <div class="card">

            <h3>
                Print Result
            </h3>

            <p>
                Generate and print your academic result.
            </p>

            <a href="student-result"
               class="btn">

                Print Result

            </a>

        </div>


        <div class="card">

            <h3>
                Logout
            </h3>

            <p>
                Exit your student account securely.
            </p>

            <a href="logout"
               class="btn logout">

                Logout

            </a>

        </div>


    </div>

</div>

</body>

</html>