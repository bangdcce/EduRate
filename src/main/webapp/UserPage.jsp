<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.UserDAO"%>
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Account Settings</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"/>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: linear-gradient(to right, #2a2185, #2a2185);
                margin: 0;
                padding: 0;
            }

            .container {
                display: flex;
                width: 100%;
                max-width: 1200px;
                margin: 20px auto;
                background: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .sidebar {
                width: 250px;
                background: #f8f8f8;
                padding: 20px;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            }

            .profile {
                text-align: center;
            }

            .profile img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                margin-bottom: 10px;
            }

            .profile h3 {
                margin: 0;
                font-size: 1.2em;
            }

            nav ul {
                list-style: none;
                padding: 0;
            }

            nav ul li {
                margin: 20px 0;
            }

            nav ul li a {
                text-decoration: none;
                color: #333;
                font-weight: bold;
            }

            nav ul li.active a {
                color: #007bff;
            }

            .content {
                flex: 1;
                padding: 20px;
            }

            h2 {
                margin-top: 0;
                text-align: center;
            }

            .form-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 15px;
            }

            .form-group {
                flex: 1;
                margin-right: 40px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            .form-group input,
            .form-group textarea,
            .form-group select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            .form-group textarea {
                resize: vertical;
            }

            .form-actions {
                margin-top: 20px;
                display: flex;
                justify-content: flex-end;
            }

            .btn {
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn-primary {
                background: #007bff;
                color: white;
            }

            .btn-secondary {
                background: #6c757d;
                color: white;
                margin-left: 10px;
            }

            .nav-item {
                margin-bottom: 0px;
            }

            .custom-file-upload {
                display: inline-block;
                padding: 10px 20px;
                cursor: pointer;
                color: #fff;
                background-color: #28a745;
                border-radius: 5px;
                font-size: 16px;
                margin-right: 10px;
            }

            .custom-file-upload:hover {
                background-color: #28a745;
            }

            input[type="file"] {
                display: none;
            }
        </style>
    </head>
    <body>
        <sql:setDataSource var="conn"
                           driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
                           url="jdbc:sqlserver://MSI\MSSQLSERVER02:1433;databaseName=EduReview;encrypt=true;trustServerCertificate=true;"
                           user="sa"
                           password="An0354768872"/>
        <sql:query dataSource="${conn}" var="rsTag">
            SELECT TagID, TagCategory FROM TagCategory
        </sql:query>

        <sql:query var="rsGender" dataSource="${conn}">
            SELECT GenderID, Gender FROM Gender
        </sql:query>

        <sql:query var="rsProvince" dataSource="${conn}">
            SELECT ProvinceID, ProvinceName FROM Province
        </sql:query>

        <%
            UserDAO us = new UserDAO();
            String userid = (String) request.getAttribute("UserId");
            ResultSet rs = us.getUserbyId(userid);
            if (rs.next()) {
                String firsName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                int TagId = rs.getInt("TagID");
                String TagCate = rs.getString("TagCategory");
                int genderId = rs.getInt("GenderID");
                String gender = rs.getString("Gender");
                int ProvinceID = rs.getInt("ProvinceID");
                String ProvinceName = rs.getString("ProvinceName");
                int DistrictId = rs.getInt("DistrictID");
                String district = rs.getString("DistrictName");
                int WardId = rs.getInt("WardID");
                String WardName = rs.getString("WardName");
                Date birthDay = rs.getDate("BirthDay");
                String email = rs.getString("EmailAddress");
                String phone = rs.getString("PhoneNum");

                request.setAttribute("firsName", firsName);
                request.setAttribute("lastName", lastName);
                request.setAttribute("TagId", TagId);
                request.setAttribute("TagCate", TagCate);
                request.setAttribute("genderId", genderId);
                request.setAttribute("gender", gender);
                request.setAttribute("ProvinceID", ProvinceID);
                request.setAttribute("ProvinceName", ProvinceName);
                request.setAttribute("DistrictId", DistrictId);
                request.setAttribute("district", district);
                request.setAttribute("WardId", WardId);
                request.setAttribute("WardName", WardName);
                request.setAttribute("birthDay", birthDay);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
            }
        %>


        <a href="${pageContext.request.contextPath}/index.jsp">Back to Home</a>
        <div class="container">
            <div class="sidebar">
                <div class="profile">
                    <img src="FPT.jpg" alt="Profile Picture"/>
                    <form action="/upload" method="post" enctype="multipart/form-data">
                        <label for="file-upload" class="custom-file-upload">
                            <i class="fas fa-cloud-upload-alt"></i> Upload Photo
                        </label>
                        <input id="file-upload" type="file" name="file"/>
                    </form>
                    <h3>Phuc Nguyen</h3>
                </div>
                <nav>
                    <ul class="nav flex-column nav-pills" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="general-tab" data-toggle="pill" href="#general" role="tab"
                               aria-controls="general" aria-selected="true">General</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="password-tab" data-toggle="pill" href="#account-change-password" role="tab"
                               aria-controls="account-change-password" aria-selected="false">Password</a>
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="content">
                <h2>ACCOUNT INFORMATION</h2>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="general" role="tabpanel" aria-labelledby="general-tab">
                        <form action="UserInfo" method="post" >
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input type="text" id="firstName" name="firstName" value="${firsName}"/>
                                </div>
                                <div class="form-group">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" id="lastName" name="lastName" value="${lastName}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="tag">Tag</label>
                                    <select name="tag">
                                        <c:forEach var="row" items="${rsTag.rows}">
                                            <option value="${row.TagID}" ${row.TagID==TagId ? 'selected': ' '}>${row.TagCategory}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="birthday">Birthday</label>
                                    <input type="date" id="birthday" name="birthday" value="${birthDay}"/>
                                </div>
                                <div class="form-group">
                                    <label for="gender">Gender</label>
                                    <select id="gender" name="gender">
                                        <c:forEach var="row" items="${rsGender.rows}">
                                            <option value="${row.GenderID}" <c:if test="${row.GenderID == genderId}">selected</c:if>>${row.Gender}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" id="email" name="email" value="${email}"/>
                                </div>
                                <div class="form-group">
                                    <label for="phone">Phone number</label>
                                    <input type="tel" id="phone" name="phone" value="${phone}"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="province">Province</label>
                                    <select id="provinceID" name="province">
                                        <option value="${ProvinceID}">${ProvinceName}</option>
                                        <c:forEach var="row" items="${rsProvince.rows}">
                                            <option value="${row.ProvinceID}" <c:if test="${row.ProvinceID == ProvinceID}">selected</c:if>>${row.ProvinceName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="district">District</label>
                                    <select id="DistrictID" name="district">
                                        <option value="${DistrictId}">${district}</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="ward">Ward</label>
                                    <select id="WardID" name="ward">
                                        <option value="${WardId}">${WardName}</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">Update</button>
                                <button type="button" class="btn btn-secondary">Cancel</button>
                            </div>
                        </form>
                    </div>

                    <div class="tab-pane fade" id="account-change-password" role="tabpanel" aria-labelledby="password-tab">
                        <form>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="currentPassword">Current password</label>
                                    <input type="password" id="currentPassword" name="currentPassword"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="newPassword">New password</label>
                                    <input type="password" id="newPassword" name="newPassword"/>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="confirmPassword">Repeat new password</label>
                                    <input type="password" id="confirmPassword" name="confirmPassword"/>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">
                                    Change Password
                                </button>
                                <button type="button" class="btn btn-secondary">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <script>
            $(document).ready(function () {
                $('#provinceID').change(function () {
                    var provinceId = $(this).val();
                    fillOptions('DistrictID', provinceId);
                });
                $('#DistrictID').change(function () {
                    var districtId = $(this).val();
                    fillOptions('WardID', districtId);
                });
            });

            function fillOptions(ddId, parentId) {
                var dd = $('#' + ddId);
                $.getJSON('/GetDistrict', {dd: ddId, val: parentId}, function (opts) {
                    dd.empty(); // Clear old options first.
                    if (opts) {
                        $.each(opts, function (key, value) {
                            dd.append($('<option/>').val(key).text(value));
                        });
                    } else {
                        dd.append($('<option/>').text("Please select parent"));
                    }
                });
            }
        </script>
    </body>
</html>
