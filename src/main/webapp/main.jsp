<%-- 
    Document   : index
    Created on : Jul 5, 2024, 5:07:37 PM
    Author     : Acer
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Education Rating</title>
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
            href="https://cdn.datatables.net/2.0.7/css/dataTables.dataTables.css"
            />
        <!-- ======= Styles ====== -->
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
                background-color: var(--gray);
            }

            .container {
                position: relative;
                width: 100%;
                margin: 0 auto;
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

            .search {
                position: relative;
                width: 400px;
                margin: 0 10px;
            }

            .search label {
                position: relative;
                width: 100%;
            }

            .search label input {
                width: 100%;
                height: 40px;
                border-radius: 40px;
                padding: 5px 20px;
                padding-left: 35px;
                font-size: 18px;
                outline: none;
                border: 1px solid var(--black2);
            }

            .search label ion-icon {
                position: absolute;
                top: 0;
                left: 10px;
                font-size: 1.2rem;
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

            /* ============= Content Section ============= */
            .content {
                padding: 20px;
            }

            .header {
                margin-bottom: 20px;
            }

            .header h1 {
                font-size: 2rem;
                color: var(--blue);
            }

            .header p {
                font-size: 1.2rem;
                color: var(--black2);
            }

            .filter-section {
                display: flex;
                margin: 20px 0;
            }

            .filter-section ul {
                display: flex;
                list-style: none;
                background-color: var(--white);
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .filter-section ul li {
                padding: 10px 20px;
                cursor: pointer;
                transition: background-color 0.3s, color 0.3s;
            }

            .filter-section ul li.active {
                background-color: var(--blue);
                color: var(--white);
            }

            .filter-section ul li:not(.active):hover {
                background-color: var(--black2);
                color: var(--white);
            }

            .rating-cards {
                display: none;
                width: 80%;
                margin: 20px 0;
            }

            .rating-cards.active {
                display: block;
            }

            .rating-card {
                display: flex;
                align-items: center;
                padding: 20px;
                margin-bottom: 10px;
                border: 2px solid var(--gray);
                border-radius: 10px;
                background: var(--white);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .rating-card img {
                width: 100px;
                height: 100px;
                border-radius: 8px;
                margin-right: 20px;
                object-fit: cover;
            }

            .rating-details {
                display: flex;
                flex-direction: column;
            }

            .rating-details h2 {
                font-size: 1.5rem;
                color: var(--blue);
            }

            .rating-details .rating-score {
                display: flex;
                align-items: center;
                font-size: 16px;
                margin-top: 10px;
            }

            .rating-details .rating-score span {
                margin-left: 10px;
                font-size: 16px;
                font-weight: 700;
                color: #fff;
                background-color: #4cb648;
                padding: 5px 10px;
                border-radius: 5px;
            }

            .rating-details .rating-medium-score {
                display: flex;
                align-items: center;
                font-size: 16px;
                margin-top: 10px;
            }

            .rating-details .rating-medium-score span {
                margin-left: 10px;
                font-size: 16px;
                font-weight: 700;
                color: #fff;
                background-color: orange;
                padding: 5px 10px;
                border-radius: 5px;
            }

            .rating-details .rating-notgood-score {
                display: flex;
                align-items: center;
                font-size: 16px;
                margin-top: 10px;
            }

            .rating-details .rating-notgood-score span {
                margin-left: 10px;
                font-size: 16px;
                font-weight: 700;
                color: #fff;
                background-color: red;
                padding: 5px 10px;
                border-radius: 5px;
            }

            .rating-details .course-descriptions {
                font-size: 1rem;
                color: var(--black2);
                margin-top: 10px;
            }

            .rating {
                color: #4cb648;
                font-weight: 700;
                font-size: 20px;
            }

            .rating-medium {
                color: orange;
                font-weight: 700;
                font-size: 20px;
            }

            .rating-notgood {
                color: red;
                font-weight: 700;
                font-size: 20px;
            }
            .rating-container {
                width: 80%;
                margin: 50px auto;
                background-color: #ffffff;
                border: 1px solid #ddd;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 5px;
                text-align: center;
            }
            .fa-star {
                font-size: 36px;
                color: #a7a7a7;
                cursor: pointer;
                transition: color 0.2s;
            }
            .fa-star:hover,
            .fa-star.hover,
            .fa-star.selected {
                color: #2a2185;
            }
            #submitBtn {
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }
            .toast {
                position: fixed;
                top: 20px;
                left: 50%;
                transform: translateX(-50%);
                background-color: #28a745;
                color: white;
                padding: 15px;
                border-radius: 5px;
                display: none;
                z-index: 9999;
            }
            .error {
                position: fixed;
                top: 20px;
                left: 50%;
                transform: translateX(-50%);
                background-color: #dc3545;
                color: white;
                padding: 15px;
                border-radius: 5px;
                display: none;
                z-index: 9999;
            }
        </style>
    </head>

    <body>
        <sql:setDataSource var="conn"
                           driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
                           url="jdbc:sqlserver://ASUS3DK\\CHIBANG:1433;databaseName=EduReview;encrypt=true;trustServerCertificate=true;"
                           user="sa"
                           password="sa123" />
        <sql:query dataSource="${conn}" var="rsSchool">
            Select SchoolID, SchoolName, EstablishedDate, ReviewScore, 
            (p.ProvinceName + ', ' + d.DistrictName + ', ' + w.WardName) as [Address],
            st.[Type], Picture,Description
            from School s
            join Province p on s.ProvinceID = p.ProvinceID
            join District d on s.DistrictID = d.DistrictID
            join Ward w on s.WardID = w.WardID
            join SchoolType st on s.SchoolTypeID = st.TypeID
            where s.SchoolTypeID = 2
        </sql:query>
        <sql:query dataSource="${conn}" var="rsCollege">
            Select SchoolID, SchoolName, EstablishedDate, ReviewScore, 
            (p.ProvinceName + ', ' + d.DistrictName + ', ' + w.WardName) as [Address],
            st.[Type], Picture,Description
            from School s
            join Province p on s.ProvinceID = p.ProvinceID
            join District d on s.DistrictID = d.DistrictID
            join Ward w on s.WardID = w.WardID
            join SchoolType st on s.SchoolTypeID = st.TypeID
            where s.SchoolTypeID = 1
        </sql:query>

        <%
            String userRole = "";
            String user = (String) session.getAttribute("SessionName");
            UserDAO dao = new UserDAO();
            ResultSet rs = dao.getRole(user);
            if (rs.next()) {
                userRole = rs.getString("Role");
            }
        %>  
        <!-- =============== Navigation ================ -->
        <div class="container">
            <div class="navigation">
                <ul>
                    <li>
                        <a>
                            <span class="icon">
                                <ion-icon name="school"></ion-icon>
                            </span>
                            <span class="title">EDURATE</span>
                        </a>
                    </li>

                    <li>
                        <a href="/MainPage/Main">
                            <span class="icon">
                                <ion-icon name="home-outline"></ion-icon>
                            </span>
                            <span class="title">Home Page</span>
                        </a>
                    </li>

                    <li>
                        <a href="/UserInfo/User/<%=user%>">
                            <span class="icon">
                                <ion-icon name="person-outline"></ion-icon>
                            </span>
                            <span class="title">Profile</span>
                        </a>
                    </li>

                    <li>
                        <a href="statistic.jsp">
                            <span class="icon">
                                <ion-icon name="stats-chart-outline"></ion-icon>
                            </span>
                            <span class="title">Statistics</span>
                        </a>
                    </li>

                    <li>
                        <a href="/LoginServlet/Login">
                            <span class="icon">
                                <ion-icon name="log-in-outline"></ion-icon>
                            </span>
                            <span class="title">Log In</span>
                        </a>
                    </li>

                    <li>
                        <a href="/signout">
                            <span class="icon">
                                <ion-icon name="log-out-outline"></ion-icon>
                            </span>
                            <span class="title">Sign Out</span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- ========================= Main ==================== -->
            <div class="main">
                <div class="topbar">
                    <div class="toggle">
                        <ion-icon name="menu-outline"></ion-icon>
                    </div>
                    <!-- Search -->
                    <div class="search">
                        <label>
                            <input type="text" placeholder="Search here" id="searchInput" onkeyup="searchSchools()" />
                            <ion-icon name="search-outline"></ion-icon>
                        </label>
                    </div>
                    <!-- UserImg -->
                    <div class="user">
                        <ion-icon name="person-circle-outline"></ion-icon>
                    </div>
                </div>

                <!-- ================ Content ================ -->
                <div class="content">
                    <div class="header">
                        <h1>EduRate -University Ratings</h1>
                        <p>
                            Welcome to EduRate, where you can explore and rate universities
                        </p>
                    </div>

                    <div class="filter-section">
                        <ul>
                            <li class="active" data-content="university">University</li>
                            <li data-content="college">College</li>
                        </ul>
                    </div>

                    <div id="college" class="rating-cards">
                        <c:forEach var="college" items="${rsCollege.rows}">
                            <div class="rating-card" data-name="${college.SchoolName}">
                                <img src="${college.Picture}" alt="${college.SchoolName}" />
                                <div class="rating-details">
                                    <h2>${college.SchoolName}</h2>
                                    <p>${college.Description}</p>
                                    <div class="rating-score">Rating: <span>${college.ReviewScore}</span></div>
                                    <div class="rating-container">
                                        <i class="far fa-star" id="star1-${college.SchoolID}"></i>
                                        <i class="far fa-star" id="star2-${college.SchoolID}"></i>
                                        <i class="far fa-star" id="star3-${college.SchoolID}"></i>
                                        <i class="far fa-star" id="star4-${college.SchoolID}"></i>
                                        <i class="far fa-star" id="star5-${college.SchoolID}"></i>
                                        <button class="submitBtn" data-schoolid="${college.SchoolID}">Submit Rating</button>
                                    </div>
                                    <div class="toast" id="toast-${college.SchoolID}">Grade Successfully</div>
                                    <div class="error" id="error-${college.SchoolID}">Grade Failed</div>
                                </div>
                                <%
                                    if (userRole.equals("Admin")) {
                                %>    
                                <div><a href="">Edit</a></div>
                                <div><a href="">Delete</a></div>
                                <%
                                    }
                                %>
                            </div>
                        </c:forEach>
                    </div>

                    <div id="university" class="rating-cards active">
                        <c:forEach var="school" items="${rsSchool.rows}">
                            <div class="rating-card" data-name="${school.SchoolName}">
                                <img src="${school.Picture}" alt="${school.SchoolName}" />
                                <div class="rating-details">
                                    <h2>${school.SchoolName}</h2>
                                    <p>${school.Description}</p>
                                    <div class="rating-score">Rating: <span>${school.ReviewScore}</span></div>
                                    <div class="rating-container">
                                        <i class="far fa-star" id="star1-${school.SchoolID}"></i>
                                        <i class="far fa-star" id="star2-${school.SchoolID}"></i>
                                        <i class="far fa-star" id="star3-${school.SchoolID}"></i>
                                        <i class="far fa-star" id="star4-${school.SchoolID}"></i>
                                        <i class="far fa-star" id="star5-${school.SchoolID}"></i>
                                        <button class="submitBtn" data-schoolid="${school.SchoolID}">Submit Rating</button>
                                    </div>
                                    <div class="toast" id="toast-${school.SchoolID}">Grade Successfully</div>
                                    <div class="error" id="error-${school.SchoolID}">Grade Failed</div>
                                </div>
                                <%
                                    if (userRole.equals("Admin")) {
                                %>    
                                <div><a href="">Edit</a></div>
                                <div><a href="">Delete</a></div>
                                <%
                                    }
                                %>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <script type="module" src="https://cdn.jsdelivr.net/npm/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://cdn.jsdelivr.net/npm/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                                // Menu Toggle
                                let toggle = document.querySelector(".toggle");
                                let navigation = document.querySelector(".navigation");
                                let main = document.querySelector(".main");

                                toggle.onclick = function () {
                                    navigation.classList.toggle("active");
                                    main.classList.toggle("active");
                                };

                                // Add hovered class in selected list item
                                let list = document.querySelectorAll(".navigation li");

                                function activeLink() {
                                    list.forEach((item) => item.classList.remove("hovered"));
                                    this.classList.add("hovered");
                                }
                                list.forEach((item) => item.addEventListener("mouseover", activeLink));
        </script>

        <script>
            $(document).ready(function () {
                $(".fa-star").mouseenter(function () {
                    var id = $(this).attr("id").split('-')[0];
                    var schoolId = $(this).attr("id").split('-')[1];
                    $(".fa-star").each(function () {
                        if ($(this).attr("id").includes(schoolId)) {
                            $(this).removeClass("fas").addClass("far");
                        }
                    });
                    for (var i = 1; i <= id.replace('star', ''); i++) {
                        $("#star" + i + "-" + schoolId).removeClass("far").addClass("fas");
                    }
                });

                $(".fa-star").click(function () {
                    var id = $(this).attr("id").split('-')[0];
                    var schoolId = $(this).attr("id").split('-')[1];
                    var rating = id.replace('star', '');
                    $(".fa-star").each(function () {
                        if ($(this).attr("id").includes(schoolId)) {
                            $(this).removeClass("fas").addClass("far");
                        }
                    });
                    for (var i = 1; i <= rating; i++) {
                        $("#star" + i + "-" + schoolId).removeClass("far").addClass("fas");
                    }
                    $(".submitBtn[data-schoolid='" + schoolId + "']").attr("data-rating", rating);
                });

                $(".submitBtn").click(function () {
                    var schoolId = $(this).attr("data-schoolid");
                    var rating = $(this).attr("data-rating");

                    $.ajax({
                        type: "POST",
                        url: "MainPage",
                        data: {
                            schoolId: schoolId,
                            rating: rating
                        },
                        success: function (response) {
                            $("#toast-" + schoolId).fadeIn(400).delay(2000).fadeOut(400);
                        },
                        error: function () {
                            $("#error-" + schoolId).fadeIn(400).delay(2000).fadeOut(400);
                        }
                    });
                });

                // Tab switching
                $(".filter-section ul li").click(function () {
                    $(".filter-section ul li").removeClass("active");
                    $(this).addClass("active");

                    var content = $(this).attr("data-content");
                    $(".rating-cards").removeClass("active");
                    $("#" + content).addClass("active");
                });
            });

            // Search function
            function searchSchools() {
                var input, filter, cards, cardContainer, title, i;
                input = document.getElementById("searchInput");
                filter = input.value.toUpperCase();
                cardContainer = document.getElementsByClassName("rating-cards");
                for (var j = 0; j < cardContainer.length; j++) {
                    cards = cardContainer[j].getElementsByClassName("rating-card");
                    for (i = 0; i < cards.length; i++) {
                        title = cards[i].getAttribute("data-name");
                        if (title.toUpperCase().indexOf(filter) > -1) {
                            cards[i].style.display = "";
                        } else {
                            cards[i].style.display = "none";
                        }
                    }
                }
            }
        </script>
    </body>
</html>

