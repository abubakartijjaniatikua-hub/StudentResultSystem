<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Login - Student Result Management System
    </title>

    <style>

        * {
            box-sizing: border-box;

            margin: 0;

            padding: 0;

            font-family: Arial, sans-serif;
        }


        body {

            min-height: 100vh;

            background-image:

                linear-gradient(
                    rgba(0,0,0,.62),
                    rgba(0,0,0,.62)
                ),

                url("images/school-background.jpg");

            background-size: cover;

            background-position: center;

            background-attachment: fixed;

            display: flex;

            justify-content: center;

            align-items: center;

            padding: 20px;
        }


        /* LOGIN CONTAINER */

        .login-container {

            width: 410px;

            max-width: 100%;

            background:
                rgba(255,255,255,.96);

            padding: 35px;

            border-radius: 16px;

            box-shadow:
                0 15px 40px
                rgba(0,0,0,.4);
        }


        /* LOGO */

        .logo {

            width: 85px;

            height: 85px;

            object-fit: contain;

            display: block;

            margin:
                0 auto 15px;

            background: white;

            padding: 5px;

            border-radius: 50%;

            box-shadow:
                0 4px 12px
                rgba(0,0,0,.2);
        }


        h1 {

            text-align: center;

            color: #0d47a1;

            font-size: 24px;

            margin-bottom: 8px;
        }


        .department {

            text-align: center;

            color: #1976d2;

            font-weight: bold;

            margin-bottom: 5px;

            font-size: 14px;
        }


        .subtitle {

            text-align: center;

            color: #666;

            font-size: 14px;

            margin-bottom: 28px;
        }


        /* FORM */

        .form-group {

            margin-bottom: 19px;
        }


        label {

            display: block;

            margin-bottom: 7px;

            color: #333;

            font-weight: bold;

            font-size: 14px;
        }


        input {

            width: 100%;

            padding: 13px;

            border:
                1px solid #ccc;

            border-radius: 8px;

            font-size: 15px;

            outline: none;

            transition: .2s;
        }


        input:focus {

            border-color: #1976d2;

            box-shadow:
                0 0 5px
                rgba(25,118,210,.25);
        }


        /* LOGIN BUTTON */

        .login-btn {

            width: 100%;

            padding: 13px;

            background: #0d47a1;

            color: white;

            border: none;

            border-radius: 8px;

            font-size: 16px;

            font-weight: bold;

            cursor: pointer;

            transition: .25s;
        }


        .login-btn:hover {

            background: #1565c0;

            transform:
                translateY(-1px);
        }


        /* ERROR */

        .error {

            background: #ffebee;

            color: #c62828;

            padding: 11px;

            border-radius: 7px;

            margin-bottom: 20px;

            text-align: center;

            font-size: 13px;
        }


        /* FOOTER */

        .footer {

            text-align: center;

            margin-top: 25px;

            color: #777;

            font-size: 12px;

            line-height: 1.6;
        }


        .back-home {

            display: block;

            text-align: center;

            margin-top: 15px;

            color: #0d47a1;

            text-decoration: none;

            font-size: 13px;

            font-weight: bold;
        }


        .back-home:hover {

            text-decoration: underline;
        }


        /* MOBILE */

        @media (max-width: 500px) {

            .login-container {

                padding: 28px 22px;
            }

            .logo {

                width: 75px;

                height: 75px;
            }

            h1 {

                font-size: 21px;
            }

        }

    </style>

</head>


<body>


<div class="login-container">


    <!-- SCHOOL LOGO -->

    <img
            src="images/kanopoly-logo.jpg"
            alt="Kano State Polytechnic Logo"
            class="logo">


    <h1>

        Student Result System

    </h1>


    <p class="department">

        Computer Science Department

    </p>


    <p class="subtitle">

        Kano State Polytechnic

    </p>


    <%
        String error =
                request.getParameter("error");

        if ("invalid".equals(error)) {
    %>

        <div class="error">

            Invalid username or password.

        </div>

    <%
        } else if ("database".equals(error)) {
    %>

        <div class="error">

            Database connection error.

        </div>

    <%
        } else if ("invalidrole".equals(error)) {
    %>

        <div class="error">

            User role is not recognized.

        </div>

    <%
        } else if ("studentnotlinked".equals(error)) {
    %>

        <div class="error">

            Student account is not linked
            to a student record.

        </div>

    <%
        }
    %>


    <!-- LOGIN FORM -->

    <form
            action="login"
            method="post">


        <div class="form-group">

            <label for="username">

                Username

            </label>

            <input
                    type="text"
                    id="username"
                    name="username"
                    placeholder="Enter your username"
                    required
                    autocomplete="username">

        </div>


        <div class="form-group">

            <label for="password">

                Password

            </label>

            <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Enter your password"
                    required
                    autocomplete="current-password">

        </div>


        <button
                type="submit"
                class="login-btn">

             Login

        </button>


    </form>


    <a
            href="index.jsp"
            class="back-home">

         Back to Home

    </a>


    <div class="footer">

        <p>
            Student Result Management System
        </p>

        <p>
            Department of Computer Science
        </p>

        <p>
            © 2026 Kano State Polytechnic
        </p>

    </div>


</div>


</body>

</html>