<%@page import="java.util.ArrayList"%>
<%@page import="Models.Statistic"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.StatisticDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Education Rating</title>
            <link rel="stylesheet" href="https://cdn.datatables.net/2.0.7/css/dataTables.dataTables.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <script src="https://cdn.datatables.net/2.0.7/js/dataTables.js"></script>
            <script>
            $(document).ready(function () {
                $('#table1').DataTable({
                    "paging": false,      
                    "ordering": false,    
                    "info": false         
                });
            });
        </script>
        <style>
            /* =========== Google Fonts ============ */
            @import url("https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap");

            /* =============== Globals ============== */
            * {
                font-family: "Ubuntu", sans-serif;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            :root {
                --blue: #2a2185;
                --white: #fff;
                --gray: #f5f5f5;
                --black1: #222;
                --black2: #999;
            }

            body {
                min-height: 100vh;
                overflow-x: hidden;
            }

            .container {
                position: relative;
                width: 100%;
            }

            /* =============== Navigation ================ */
            .navigation {
                position: fixed;
                width: 300px;
                height: 100%;
                background: var(--blue);
                border-left: 10px solid var(--blue);
                transition: 0.5s;
                overflow: hidden;
            }
            .navigation.active {
                width: 80px;
            }

            .navigation ul {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
            }

            .navigation ul li {
                position: relative;
                width: 100%;
                list-style: none;
                border-top-left-radius: 30px;
                border-bottom-left-radius: 30px;
            }

            .navigation ul li:hover,
            .navigation ul li.hovered {
                background-color: var(--white);
            }

            .navigation ul li:nth-child(1) {
                margin-bottom: 40px;
pointer-events: none;
            }

            .navigation ul li a {
                position: relative;
                display: block;
                width: 100%;
                display: flex;
                text-decoration: none;
                color: var(--white);
            }
            .navigation ul li:hover a,
            .navigation ul li.hovered a {
                color: var(--blue);
            }

            .navigation ul li a .icon {
                position: relative;
                display: block;
                min-width: 60px;
                height: 60px;
                line-height: 75px;
                text-align: center;
            }
            .navigation ul li a .icon ion-icon {
                font-size: 1.75rem;
            }

            .navigation ul li a .title {
                position: relative;
                display: block;
                padding: 0 10px;
                height: 60px;
                line-height: 60px;
                text-align: start;
                white-space: nowrap;
            }

            /* --------- curve outside ---------- */
            .navigation ul li:hover a::before,
            .navigation ul li.hovered a::before {
                content: "";
                position: absolute;
                right: 0;
                top: -50px;
                width: 50px;
                height: 50px;
                background-color: transparent;
                border-radius: 50%;
                box-shadow: 35px 35px 0 10px var(--white);
                pointer-events: none;
            }
            .navigation ul li:hover a::after,
            .navigation ul li.hovered a::after {
                content: "";
                position: absolute;
                right: 0;
                bottom: -50px;
                width: 50px;
                height: 50px;
                background-color: transparent;
                border-radius: 50%;
                box-shadow: 35px -35px 0 10px var(--white);
                pointer-events: none;
            }

            /* ===================== Main ===================== */
            .main {
                position: absolute;
                width: calc(100% - 300px);
                left: 300px;
                min-height: 100vh;
                background: var(--white);
                transition: 0.5s;
                padding: 0 10px;
            }
            .main.active {
                width: calc(100% - 80px);
                left: 80px;
            }

            .topbar {
                width: 100%;
                height: 60px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 10px;
                margin-bottom: 50px;
            }

            .toggle {
                position: relative;
                width: 60px;
                height: 60px;
                display: flex;
justify-content: center;
                align-items: center;
                font-size: 2.5rem;
                cursor: pointer;
            }

            .content{
                font-size: 30px;
                color:#2a2185;
            }

            .user {
                position: relative;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                overflow: hidden;
                cursor: pointer;
            }

            .user ion-icon {
                position: absolute;
                top: 0;
                left: 0px;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            /* ====================== Responsive Design ========================== */
            @media (max-width: 991px) {
                .navigation {
                    left: -300px;
                }
                .navigation.active {
                    width: 300px;
                    left: 0;
                }
                .main {
                    width: 100%;
                    left: 0;
                }
                .main.active {
                    left: 300px;
                }
                .cardBox {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

            @media (max-width: 480px) {
                .user {
                    min-width: 40px;
                }
                .navigation {
                    width: 100%;
                    left: -100%;
                    z-index: 1000;
                }
                .navigation.active {
                    width: 100%;
                    left: 0;
                }
                .toggle {
                    z-index: 10001;
                }
                .main.active .toggle {
                    color: #fff;
                    position: fixed;
                    right: 0;
                    left: initial;
                }
            }
            #filter {
                margin: 20px;
            }

            #table1 {
                width: 80%;
                margin: 0 auto;
                border-collapse: collapse;
            }

            #table1 th,
            #table1 td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
            }

            #table1 th {
                background-color: #2a2185;
                color: white;
            }

            #search {
                padding: 10px;
                width: 200px;
                margin-right: 10px;
                margin-left: -20px;
            }

            canvas {
                display: block;
                margin: 0 auto;
                max-width: 80%;
                height: auto;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <div class="navigation">
                <ul>
<li><a href="index.jsp"><span class="icon"><ion-icon name="school"></ion-icon></span><span class="title">EDURATE</span></a></li>
                    <li><a href="index.jsp"><span class="icon"><ion-icon name="home-outline"></ion-icon></span><span class="title">Home Page</span></a></li>
                    <li><a href="profile.jsp"><span class="icon"><ion-icon name="person-outline"></ion-icon></span><span class="title">Profile</span></a></li>
                    <li><a href="statistic.jsp"><span class="icon"><ion-icon name="stats-chart-outline"></ion-icon></span><span class="title">Statistics</span></a></li>
                    <li><a href="login.jsp"><span class="icon"><ion-icon name="log-in-outline"></ion-icon></span><span class="title">Log In</span></a></li>
                    <li><a href="#"><span class="icon"><ion-icon name="log-out-outline"></ion-icon></span><span class="title">Sign Out</span></a></li>
                </ul>
            </div>
        </div>
        <div class="main">
            <div class="topbar">
                <div class="toggle"><ion-icon name="menu-outline"></ion-icon></div>
                <div class="content">
                        <h2>Ranking of University</h2>
                </div>
                <div class="user"><ion-icon name="person-circle-outline"></ion-icon></div>
            </div>
            <table id="table1">
                <thead>
                    <tr>
                        <th>Rank</th>
                        <th>ID School</th>
                        <th>School Name</th>
                        <th>Points</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        StatisticDAO dao = new StatisticDAO();
                        ResultSet rs = dao.getAll();
                        ArrayList<String> schoolNames = new ArrayList<>();
                        ArrayList<Integer> reviewScores = new ArrayList<>();
                        if (rs != null) {
                            int index = 0;
                            while (rs.next()) {
                                schoolNames.add(rs.getString("SchoolName"));
                                reviewScores.add(rs.getInt("ReviewScore"));
                    %>
                    <tr>
                        <td><%= index + 1%></td>
                        <td><%= rs.getString("SchoolID")%></td>
                        <td><%= rs.getString("SchoolName")%></td>
                        <td><%= rs.getString("ReviewScore")%></td>
                    </tr>
                    <%
                                index++;
                            }
                        } else {
                            out.println("<tr><td colspan='4'>No data found</td></tr>");
                        }
                    %>
                </tbody>
            </table>
            <canvas id="university-chart" width="400" height="200"></canvas>
        </div>
        <script>
let list = document.querySelectorAll(".navigation li");
            function activeLink() {
                list.forEach((item) => item.classList.remove("hovered"));
                this.classList.add("hovered");
            }
            list.forEach((item) => item.addEventListener("mouseover", activeLink));

            let toggle = document.querySelector(".toggle");
            let navigation = document.querySelector(".navigation");
            let main = document.querySelector(".main");
            toggle.onclick = function () {
                navigation.classList.toggle("active");
                main.classList.toggle("active");
            };
        </script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const ctx = document.getElementById("university-chart").getContext("2d");

                // Chuyá»n dá»¯ liá»u tá»« JSP sang JavaScript
                const schoolNames = <%= new com.google.gson.Gson().toJson(schoolNames) %>;
                const reviewScores = <%= new com.google.gson.Gson().toJson(reviewScores) %>;

                const chart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: schoolNames,
                        datasets: [{
                            label: 'Points',
                            data: reviewScores,
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            });
        </script>
        <!-- ====== ionicons ======= -->
        <script 
            type="module"
            src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"
        ></script>
        <script
            nomodule
            src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"
        ></script>
    </body>
</html>