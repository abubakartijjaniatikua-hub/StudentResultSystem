<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Academic Settings</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            background: #f4f6f9;
            padding: 25px;
            color: #333;
        }

        .container {
            max-width: 1250px;
            margin: auto;
        }

        /* HEADER */

        .header {
            background:
                linear-gradient(
                    135deg,
                    #0d47a1,
                    #1976d2
                );

            color: white;
            padding: 28px;
            border-radius: 14px;
            margin-bottom: 25px;

            box-shadow:
                0 5px 18px
                rgba(0,0,0,0.15);
        }

        .header-title {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .header-icon {
            width: 55px;
            height: 55px;

            background:
                rgba(255,255,255,0.18);

            border-radius: 12px;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 28px;
        }

        .header h1 {
            font-size: 28px;
            margin-bottom: 5px;
        }

        .header p {
            opacity: .9;
            font-size: 14px;
        }

        /* MAIN GRID */

        .grid {
            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 20px;
        }

        /* CARD */

        .card {
            background: white;

            padding: 22px;

            border-radius: 12px;

            box-shadow:
                0 3px 12px
                rgba(0,0,0,0.08);
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 12px;

            margin-bottom: 18px;
        }

        .card-icon {
            width: 42px;
            height: 42px;

            background: #e3f2fd;

            color: #0d47a1;

            border-radius: 10px;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 21px;
        }

        .card h2 {
            color: #0d47a1;
            font-size: 19px;
        }

        /* FORM */

        .add-form {
            display: flex;
            gap: 8px;
            margin-bottom: 20px;
        }

        .add-form input {
            flex: 1;
            min-width: 0;

            padding: 10px;

            border: 1px solid #ccc;
            border-radius: 6px;

            outline: none;
        }

        .add-form input:focus {
            border-color: #1976d2;

            box-shadow:
                0 0 4px
                rgba(25,118,210,.2);
        }

        .add-form button {
            padding: 10px 14px;

            background: #0d47a1;
            color: white;

            border: none;
            border-radius: 6px;

            cursor: pointer;
            font-weight: bold;
        }

        .add-form button:hover {
            background: #1565c0;
        }

        /* TABLE */

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #0d47a1;
            color: white;

            padding: 9px;

            text-align: left;
            font-size: 13px;
        }

        td {
            padding: 9px;

            border-bottom:
                1px solid #e5e5e5;

            font-size: 13px;
        }

        tr:hover td {
            background: #f8fbff;
        }

        /* BUTTONS */

        .edit-btn {
            background: #1976d2;
            color: white;

            border: none;

            padding: 6px 10px;

            border-radius: 5px;

            cursor: pointer;

            font-size: 12px;
        }

        .edit-btn:hover {
            background: #1565c0;
        }

        .delete-btn {
            background: #c62828;
            color: white;

            border: none;

            padding: 6px 10px;

            border-radius: 5px;

            cursor: pointer;

            font-size: 12px;
        }

        .delete-btn:hover {
            background: #b71c1c;
        }

        /* EDIT */

        .edit-box {
            margin-top: 25px;
            display: none;
        }

        .edit-box h2 {
            color: #0d47a1;
            margin-bottom: 15px;
        }

        .edit-input {
            width: 100%;

            padding: 12px;

            border: 1px solid #ccc;

            border-radius: 7px;

            outline: none;
        }

        .update-btn {
            margin-top: 15px;

            padding: 10px 22px;

            background: #0d47a1;

            color: white;

            border: none;

            border-radius: 6px;

            cursor: pointer;

            font-weight: bold;
        }

        .update-btn:hover {
            background: #1565c0;
        }

        /* BACK */

        .back {
            display: inline-flex;

            align-items: center;

            gap: 7px;

            margin-top: 25px;

            color: #0d47a1;

            text-decoration: none;

            font-weight: bold;

            font-size: 14px;
        }

        .back:hover {
            text-decoration: underline;
        }

        /* MOBILE */

        @media (max-width: 900px) {

            .grid {
                grid-template-columns: 1fr;
            }

        }

        @media (max-width: 500px) {

            body {
                padding: 15px;
            }

            .header {
                padding: 20px;
            }

            .header h1 {
                font-size: 22px;
            }

            .add-form {
                flex-direction: column;
            }

            .add-form button {
                width: 100%;
            }

            table {
                font-size: 12px;
            }

        }

    </style>

</head>


<body>


<div class="container">


    <!-- HEADER -->

    <div class="header">

        <div class="header-title">

            <div class="header-icon">

            </div>

            <div>

                <h1>
                    Academic Settings
                </h1>

                <p>
                    Manage academic sessions,
                    levels and semesters
                </p>

            </div>

        </div>

    </div>


    <div class="grid">


        <!-- ACADEMIC SESSIONS -->

        <div class="card">

            <div class="card-header">

                <div class="card-icon">

                </div>

                <h2>
                    Academic Sessions
                </h2>

            </div>


            <form
                    action="academic-settings"
                    method="post"
                    class="add-form">

                <input
                        type="hidden"
                        name="action"
                        value="add">

                <input
                        type="hidden"
                        name="type"
                        value="session">

                <input
                        type="text"
                        name="name"
                        placeholder="e.g. 2026/2027"
                        required>

                <button type="submit">
                     Add
                </button>

            </form>


            <table>

                <thead>

                <tr>
                    <th>Session</th>
                    <th>Action</th>
                </tr>

                </thead>

                <tbody>

                <%
                    List<Map<String, Object>> sessions =
                            (List<Map<String, Object>>)
                            request.getAttribute("sessions");

                    if (sessions != null) {

                        for (Map<String, Object> item :
                                sessions) {
                %>

                <tr>

                    <td>
                        <%= item.get("name") %>
                    </td>

                    <td>

                        <button
                                class="edit-btn"
                                onclick="editRecord(
                                    'session',
                                    '<%= item.get("id") %>',
                                    '<%= item.get("name") %>'
                                )">

                             Edit

                        </button>


                        <form
                                action="academic-settings"
                                method="post"
                                style="display:inline;">

                            <input
                                    type="hidden"
                                    name="action"
                                    value="delete">

                            <input
                                    type="hidden"
                                    name="type"
                                    value="session">

                            <input
                                    type="hidden"
                                    name="id"
                                    value="<%= item.get("id") %>">

                            <button
                                    class="delete-btn"
                                    type="submit"
                                    onclick="return confirm(
                                        'Delete this session?'
                                    )">

                                 Delete

                            </button>

                        </form>

                    </td>

                </tr>

                <%
                        }
                    }
                %>

                </tbody>

            </table>

        </div>


        <!-- LEVELS -->

        <div class="card">

            <div class="card-header">

                <div class="card-icon">

                </div>

                <h2>
                    Levels
                </h2>

            </div>


            <form
                    action="academic-settings"
                    method="post"
                    class="add-form">

                <input
                        type="hidden"
                        name="action"
                        value="add">

                <input
                        type="hidden"
                        name="type"
                        value="level">

                <input
                        type="text"
                        name="name"
                        placeholder="e.g. ND II"
                        required>

                <button type="submit">
                     Add
                </button>

            </form>


            <table>

                <thead>

                <tr>
                    <th>Level</th>
                    <th>Action</th>
                </tr>

                </thead>

                <tbody>

                <%
                    List<Map<String, Object>> levels =
                            (List<Map<String, Object>>)
                            request.getAttribute("levels");

                    if (levels != null) {

                        for (Map<String, Object> item :
                                levels) {
                %>

                <tr>

                    <td>
                        <%= item.get("name") %>
                    </td>

                    <td>

                        <button
                                class="edit-btn"
                                onclick="editRecord(
                                    'level',
                                    '<%= item.get("id") %>',
                                    '<%= item.get("name") %>'
                                )">

                             Edit

                        </button>


                        <form
                                action="academic-settings"
                                method="post"
                                style="display:inline;">

                            <input
                                    type="hidden"
                                    name="action"
                                    value="delete">

                            <input
                                    type="hidden"
                                    name="type"
                                    value="level">

                            <input
                                    type="hidden"
                                    name="id"
                                    value="<%= item.get("id") %>">

                            <button
                                    class="delete-btn"
                                    type="submit"
                                    onclick="return confirm(
                                        'Delete this level?'
                                    )">

                                 Delete

                            </button>

                        </form>

                    </td>

                </tr>

                <%
                        }
                    }
                %>

                </tbody>

            </table>

        </div>


        <!-- SEMESTERS -->

        <div class="card">

            <div class="card-header">

                <div class="card-icon">

                </div>

                <h2>
                    Semesters
                </h2>

            </div>


            <form
                    action="academic-settings"
                    method="post"
                    class="add-form">

                <input
                        type="hidden"
                        name="action"
                        value="add">

                <input
                        type="hidden"
                        name="type"
                        value="semester">

                <input
                        type="text"
                        name="name"
                        placeholder="e.g. First Semester"
                        required>

                <button type="submit">
                     Add
                </button>

            </form>


            <table>

                <thead>

                <tr>
                    <th>Semester</th>
                    <th>Action</th>
                </tr>

                </thead>

                <tbody>

                <%
                    List<Map<String, Object>> semesters =
                            (List<Map<String, Object>>)
                            request.getAttribute("semesters");

                    if (semesters != null) {

                        for (Map<String, Object> item :
                                semesters) {
                %>

                <tr>

                    <td>
                        <%= item.get("name") %>
                    </td>

                    <td>

                        <button
                                class="edit-btn"
                                onclick="editRecord(
                                    'semester',
                                    '<%= item.get("id") %>',
                                    '<%= item.get("name") %>'
                                )">

                             Edit

                        </button>


                        <form
                                action="academic-settings"
                                method="post"
                                style="display:inline;">

                            <input
                                    type="hidden"
                                    name="action"
                                    value="delete">

                            <input
                                    type="hidden"
                                    name="type"
                                    value="semester">

                            <input
                                    type="hidden"
                                    name="id"
                                    value="<%= item.get("id") %>">

                            <button
                                    class="delete-btn"
                                    type="submit"
                                    onclick="return confirm(
                                        'Delete this semester?'
                                    )">

                                 Delete

                            </button>

                        </form>

                    </td>

                </tr>

                <%
                        }
                    }
                %>

                </tbody>

            </table>

        </div>


    </div>


    <!-- EDIT FORM -->

    <div
            id="editBox"
            class="card edit-box">

        <div class="card-header">

            <div class="card-icon">

            </div>

            <h2>
                Edit Academic Setting
            </h2>

        </div>


        <form
                action="academic-settings"
                method="post">

            <input
                    type="hidden"
                    name="action"
                    value="update">

            <input
                    type="hidden"
                    name="type"
                    id="editType">

            <input
                    type="hidden"
                    name="id"
                    id="editId">

            <input
                    type="text"
                    name="name"
                    id="editName"
                    class="edit-input"
                    required>

            <button
                    type="submit"
                    class="update-btn">

                 Update

            </button>

        </form>

    </div>


    <a
            href="admin-dashboard.jsp"
            class="back">

         Back to Admin Dashboard

    </a>


</div>


<script>

    function editRecord(type, id, name) {

        document.getElementById(
            "editBox"
        ).style.display = "block";

        document.getElementById(
            "editType"
        ).value = type;

        document.getElementById(
            "editId"
        ).value = id;

        document.getElementById(
            "editName"
        ).value = name;

        document.getElementById(
            "editBox"
        ).scrollIntoView({
            behavior: "smooth"
        });

    }

</script>


</body>

</html>