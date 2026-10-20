<!DOCTYPE html>
<html>
<head>

    <title>Admin Dashboard - Student Result Management System</title>

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="css/all.min.css">

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        .header {
            background-color: #1f4e78;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .header h1 {
            margin: 0;
        }

        .header p {
            margin: 8px 0 0;
        }

        .container {
            width: 90%;
            margin: 30px auto;
        }

        .welcome {
            background-color: white;
            padding: 20px;
            margin-bottom: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .welcome h2 {
            margin-top: 0;
            color: #1f4e78;
        }

        .menu {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .card {
            background-color: white;
            padding: 30px;
            text-align: center;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .card-icon {
            width: 55px;
            height: 55px;

            margin: 0 auto 15px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #e3f2fd;
            color: #0d47a1;

            border-radius: 12px;

            font-size: 25px;
        }

        .card-icon i {
            font-size: 25px;
        }

        .card h3 {
            color: #1f4e78;
        }

        .card p {
            color: #555;
            line-height: 1.5;
        }

        .card a {
            display: inline-block;

            margin-top: 10px;

            padding: 10px 20px;

            background-color: #1f4e78;
            color: white;

            text-decoration: none;

            border-radius: 5px;
        }

        .card a:hover {
            background-color: #163a5c;
        }

        /* Logout Button */
        .logout-btn {
            background-color: #c0392b !important;
        }

        .logout-btn:hover {
            background-color: #922b21 !important;
        }

        /* Responsive Design */
        @media (max-width: 900px) {

            .menu {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 600px) {

            .menu {
                grid-template-columns: 1fr;
            }

            .container {
                width: 92%;
            }

        }

    </style>

</head>

<body>


<!-- ================= HEADER ================= -->

<div class="header">

    <h1>Student Result Management System</h1>

    <p>Admin Dashboard</p>

</div>


<!-- ================= MAIN CONTAINER ================= -->

<div class="container">


    <!-- ================= WELCOME ================= -->

    <div class="welcome">

        <h2>Welcome, Administrator </h2>

        <p>
            Manage students, courses and academic results
            from this dashboard.
        </p>

    </div>


    <!-- ================= DASHBOARD CARDS ================= -->

    <div class="menu">


        <!-- STUDENTS -->

        <div class="card">

            <div class="card-icon">
                <i class="fa-solid fa-user-graduate"></i>
            </div>

            <h3>Students</h3>

            <p>
                Manage student information
                and academic records.
            </p>

            <a href="students">
                Open
            </a>

        </div>


        <!-- COURSES -->

        <div class="card">

            <div class="card-icon">
                <i class="fa-solid fa-book"></i>
            </div>

            <h3>Courses</h3>

            <p>
                Manage Computer Science
                courses and credit units.
            </p>

            <a href="courses">
                Open
            </a>

        </div>


        <!-- RESULTS -->

        <div class="card">

            <div class="card-icon">
                <i class="fa-solid fa-file-lines"></i>
            </div>

            <h3>Results</h3>

            <p>
                Enter, update and manage
                student academic results.
            </p>

            <a href="results">
                Open
            </a>

        </div>


        <!-- GPA / CGPA -->

        <div class="card">

            <div class="card-icon">
                <i class="fa-solid fa-chart-line"></i>
            </div>

            <h3>GPA / CGPA</h3>

            <p>
                Calculate and view GPA
                and cumulative CGPA.
            </p>

            <a href="gpa">
                Open
            </a>

        </div>


        <!-- SEARCH RESULTS -->

        <div class="card">

            <div class="card-icon">
                <i class="fa-solid fa-magnifying-glass"></i>
            </div>

            <h3>Search Results</h3>

            <p>
                Search and view student
                academic results.
            </p>

            <a href="search-results">
                Open
            </a>

        </div>


        <!-- REPORTS -->

        <div class="card">

            <div class="card-icon">
                <i class="fa-solid fa-file-pdf"></i>
            </div>

            <h3>Reports</h3>

            <p>
                Generate and print
                student result reports.
            </p>

            <a href="report">
                Open
            </a>

        </div>


        <!-- ACADEMIC SETTINGS -->

        <div class="card">

            <div class="card-icon">
                <i class="fa-solid fa-gear"></i>
            </div>

            <h3>Academic Settings</h3>

            <p>
                Manage sessions, levels
                and semesters.
            </p>

            <a href="academic-settings">
                Open
            </a>

        </div>


        <!-- LOGOUT -->

        <div class="card">

            <div class="card-icon">
                <i class="fa-solid fa-right-from-bracket"></i>
            </div>

            <h3>Logout</h3>

            <p>
                Exit the administrator
                account securely.
            </p>

            <a href="logout" class="logout-btn">
                Logout
            </a>

        </div>


    </div>

</div>


</body>
</html>