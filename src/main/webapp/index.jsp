<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <style>
        @import url("https://fonts.googleapis.com/css2?family=Montserrat+Alternates:wght@700&display=swap");
        :root {
            --first-color: hsl(217, 75%, 80%);
            --body-color: hsl(211, 100%, 95%);
            --body-font: "Montserrat Alternates", sans-serif;
            --normal-font-size: 1.25rem;
        }
        * {
            box-sizing: border-box;
            padding: 0;
            margin: 0;
        }

        body {
            margin-top: 250px;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            font-family: var(--body-font);
            font-size: var(--normal-font-size);
            background: url('Images/background.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        a {
            text-decoration: none;
            margin-bottom: 30px;
        }

        .button {
            position: relative;
            background-color: var(--first-color);
            color: #fff;
            padding: 0.9rem 2.2rem;
            border-radius: 3rem;
            transition: 0.4s;
            width: 200px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .button::after {
            content: "";
            width: 80%;
            height: 40%;
            background: linear-gradient(
                80deg,
                hsl(217, 80%, 80%) 10%,
                hsl(217, 85%, 70%) 48%
            );
            position: absolute;
            left: 0;
            right: 0;
            bottom: -4px;
            margin: 0 auto;
            border-radius: 3rem;
            filter: blur(12px);
            z-index: -1;
            opacity: 0;
            transition: opacity 0.4s;
        }

        .button__text {
            position: relative;
            z-index: 10;
        }

        .button img {
            position: absolute;
            inset: 0;
            margin: auto;
            pointer-events: none;
            transition: 0.6s;
            opacity: 0;
        }

        .button__cone {
            width: 18px;
            transform: translate(-25px, -6px) rotate(55deg);
            filter: blur(0.5px);
        }

        .button__torus {
            width: 38px;
            transform: translate(7px, -14px) rotate(80deg);
        }

        .button__icosahedron {
            width: 36px;
            transform: translate(34px, -4px) rotate(-45deg);
            filter: blur(0.9px);
        }

        .button__sphere {
            width: 30px;
            transform: translate(-5px, 15px) rotate(40deg);
        }

        .button:hover::after {
            opacity: 1;
        }

        .button:hover {
            transform: scale(1.3);
        }

        .button:hover img {
            opacity: 1;
        }

        .button:hover .button__cone {
            transform: translate(-38px, -10px) scale(1.2);
        }

        .button:hover .button__torus {
            transform: translate(7px, -32px) scale(1.1);
        }

        .button:hover .button__icosahedron {
            transform: translate(50px, -20px) scale(1.1);
        }

        .button:hover .button__sphere {
            transform: translate(-14px, 20px) scale(1.1);
        }
    </style>

    <title>Education Rating</title>
</head>
<body>
    <a href="/LoginServlet/Login" class="button">
        <span class="button__text">Sign In</span>
        <img src="Images/cone.png" alt="" class="button__cone" />
        <img src="Images/torus.png" alt="" class="button__torus" />
        <img src="Images/icosahedron.png" alt="" class="button__icosahedron" />
        <img src="Images/sphere.png" alt="" class="button__sphere" />
    </a>
    <a href="/RegisterServlet/Register" class="button">
        <span class="button__text">Sign Up</span>
        <img src="Images/cone.png" alt="" class="button__cone" />
        <img src="Images/torus.png" alt="" class="button__torus" />
        <img src="Images/icosahedron.png" alt="" class="button__icosahedron" />
        <img src="Images/sphere.png" alt="" class="button__sphere" />
    </a>
</body>
</html>
