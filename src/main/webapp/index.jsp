<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Student Result Management System
    </title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {

            font-family:
                Arial,
                Helvetica,
                sans-serif;

            min-height: 100vh;

            background-image:
                linear-gradient(
                    rgba(0, 0, 0, 0.65),
                    rgba(0, 0, 0, 0.65)
                ),
                url("images/school-background.jpg");

            background-size: cover;

            background-position: center;

            background-attachment: fixed;

            color: white;
        }


        .container {

            width: 90%;

            max-width: 1200px;

            margin: auto;
        }


        /* HEADER */

        header {

            padding: 25px 0;

            display: flex;

            align-items: center;

            gap: 18px;
        }


        .logo {

            width: 75px;

            height: 75px;

            object-fit: contain;

            background: white;

            border-radius: 50%;

            padding: 5px;

            box-shadow:
                0 4px 15px
                rgba(0,0,0,0.4);
        }


        .school-name {

            font-size: 21px;

            font-weight: bold;

            letter-spacing: .5px;
        }


        .department {

            font-size: 14px;

            margin-top: 5px;

            opacity: .9;
        }


        /* HERO */

        .hero {

            min-height: 68vh;

            display: flex;

            align-items: center;

            justify-content: center;

            text-align: center;
        }


        .hero-content {

            max-width: 850px;

            padding: 45px 35px;

            background:
                rgba(0,0,0,0.42);

            border-radius: 18px;

            backdrop-filter: blur(5px);

            box-shadow:
                0 10px 35px
                rgba(0,0,0,0.35);
        }


        .hero h1 {

            font-size: 46px;

            line-height: 1.2;

            margin-bottom: 15px;
        }


        .hero h2 {

            font-size: 23px;

            font-weight: normal;

            margin-bottom: 20px;
        }


        .hero p {

            font-size: 17px;

            line-height: 1.7;

            max-width: 720px;

            margin: auto;

            opacity: .95;

            margin-bottom: 30px;
        }


        /* BUTTON */

        .btn {

            display: inline-block;

            padding: 14px 35px;

            background: white;

            color: #123b5d;

            text-decoration: none;

            border-radius: 7px;

            font-weight: bold;

            font-size: 15px;

            transition: .25s;

            box-shadow:
                0 5px 15px
                rgba(0,0,0,0.3);
        }


        .btn:hover {

            transform:
                translateY(-3px);

            box-shadow:
                0 8px 20px
                rgba(0,0,0,0.4);
        }


        /* FEATURES */

        .features {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 20px;

            margin-bottom: 35px;
        }


        .feature {

            background:
                rgba(0,0,0,0.45);

            padding: 22px;

            border-radius: 12px;

            text-align: center;

            backdrop-filter: blur(4px);
        }


        .feature h3 {

            margin-bottom: 8px;

            font-size: 18px;
        }


        .feature p {

            font-size: 14px;

            line-height: 1.6;

            opacity: .9;
        }


        /* FOOTER */

        footer {

            text-align: center;

            padding: 20px;

            font-size: 13px;

            opacity: .85;
        }


        /* MOBILE */

        @media (max-width: 700px) {

            .school-name {

                font-size: 17px;
            }


            .logo {

                width: 60px;

                height: 60px;
            }


            .hero {

                min-height: 60vh;
            }


            .hero-content {

                padding: 35px 20px;
            }


            .hero h1 {

                font-size: 30px;
            }


            .hero h2 {

                font-size: 19px;
            }


            .hero p {

                font-size: 15px;
            }


            .features {

                grid-template-columns: 1fr;
            }

        }

    </style>

</head>


<body>


<div class="container">


    <!-- HEADER -->

    <header>

        <img
            src="images/kanopoly-logo.jpg"
            alt="Kano State Polytechnic Logo"
            class="logo"
        >


        <div>

            <div class="school-name">

                KANO STATE POLYTECHNIC

            </div>


            <div class="department">

                Department of Computer Science

            </div>

        </div>

    </header>



    <!-- HERO -->

    <section class="hero">

        <div class="hero-content">


            <h1>

                Student Result
                Management System

            </h1>


            <h2>

                Department of Computer Science

            </h2>


            <p>

                A web-based system designed to
                manage student academic results,
                process grades, calculate GPA and
                CGPA, generate result reports and
                provide secure access to academic
                records.

            </p>


            <a
                href="login.jsp"
                class="btn"
            >

                Get Started

            </a>


        </div>

    </section>



    <!-- FEATURES -->

    <section class="features">


        <div class="feature">

            <h3>

                Student Management

            </h3>

            <p>

                Manage student information,
                registration numbers, levels
                and academic status.

            </p>

        </div>



        <div class="feature">

            <h3>

                Result Processing

            </h3>

            <p>

                Process CA and examination
                scores and automatically
                calculate total, grade,
                grade point and CUP.

            </p>

        </div>



        <div class="feature">

            <h3>

                GPA &amp; CGPA

            </h3>

            <p>

                Calculate semester GPA and
                cumulative CGPA from student
                academic results.

            </p>

        </div>


    </section>



    <!-- FOOTER -->

    <footer>

        © 2026 Kano State Polytechnic
        — Department of Computer Science

    </footer>


</div>


</body>

</html>