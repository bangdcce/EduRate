<%-- 
    Document   : Edit
    Created on : Jul 13, 2024, 9:16:08 AM
    Author     : Bang
--%>

<%@page import="DAOs.SchoolDAO"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit Schools</title>
       <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                width: 80%;
                max-width: 800px;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }
            .form-row {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
            }
            .form-group {
                width: 48%;
                margin-bottom: 15px;
            }
            .form-group.full-width {
                width: 100%;
            }
            label {
                display: block;
                margin-bottom: 5px;
                color: #333;
            }
            input[type="text"], input[type="date"], input[type="number"], select, textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
                margin-top: 5px;
            }
            input[type="file"] {
                border: none;
            }
            textarea {
                resize: vertical;
                height: 100px;
            }
            .form-actions {
                text-align: center;
                margin-top: 20px;
            }
            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin: 5px;
            }
            .btn-primary {
                background-color: #007bff;
                color: white;
            }
            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }
        </style>
    </head>
    <body>
        <sql:setDataSource var="conn"
                           driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
                           url="jdbc:sqlserver://ASUS3DK\\CHIBANG:1433;databaseName=EduReview;encrypt=true;trustServerCertificate=true;"
                           user="sa"
                           password="sa123"/>
        <sql:query var="rsProvince" dataSource="${conn}">
            SELECT ProvinceID, ProvinceName FROM Province
        </sql:query>
        <sql:query var="rsSchoolType" dataSource="${conn}">
            SELECT TypeID, [Type] FROM SchoolType
        </sql:query>
        <h1>Edit School Information</h1>
        <%
            String schoolID = (String) request.getAttribute("SchoolID");
            SchoolDAO schoolDAO = new SchoolDAO();
            ResultSet rs = schoolDAO.getSchoolByID(schoolID);
            if (rs.next()) {
                String SchoolName = rs.getString("SchoolName");
                Date EstablishedDate = rs.getDate("EstablishedDate");
                int TotalStudents = rs.getInt("TotalStudents");
                String Website = rs.getString("Website");
                float ReviewScore = rs.getInt("ReviewScore");
                int SchoolTypeID = rs.getInt("TypeID");
                String TypeName = rs.getString("Type");
                String picture=rs.getString("Picture");
                int ProvinceID = rs.getInt("ProvinceID");
                String ProvinceName = rs.getString("ProvinceName");
                int DistrictId = rs.getInt("DistrictID");
                String district = rs.getString("DistrictName");
                int WardId = rs.getInt("WardID");
                String WardName = rs.getString("WardName");
                String Description = rs.getString("Description");

                request.setAttribute("SchoolName", SchoolName);
                request.setAttribute("EstablishedDate", EstablishedDate);
                request.setAttribute("TotalStudents", TotalStudents);
                request.setAttribute("Website", Website);
                request.setAttribute("ReviewScore", ReviewScore);
                request.setAttribute("SchoolTypeID", SchoolTypeID);
                request.setAttribute("ProvinceID", ProvinceID);
                request.setAttribute("ProvinceName", ProvinceName);
                request.setAttribute("DistrictId", DistrictId);
                request.setAttribute("district", district);
                request.setAttribute("WardId", WardId);
                request.setAttribute("WardName", WardName);
                request.setAttribute("TypeName", TypeName);
                request.setAttribute("Description", Description);
                request.setAttribute("Picture", picture);
            } 
        %>
        <div class="tab-pane fade show active" id="general" role="tabpanel" aria-labelledby="general-tab">
            <form action="EditServlet" method="post" enctype="multipart/form-data" >
                <div class="form-row">
                    <div class="form-group">
                        <label for="SchoolID">School ID</label>
                        <input type="text" id="SchoolID" name="SchoolID" value="${SchoolID}" readonly   />
                    </div>
                    <div class="form-group">
                        <label for="SchoolName">School Name</label>
                        <input type="text" id="SchoolName" name="SchoolName" value="${SchoolName}"/>
                    </div>
                    <div class="form-group">
                        <label for="EstablishedDate">Established Date</label>
                        <input type="date" id="EstablishedDate" name="EstablishedDate" value="${EstablishedDate}"/>
                    </div>
                    <div class="form-group">
                        <label for="Website">Website</label>
                        <input type="text" id="Website" name="Website" value="${Website}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="TotalStudents">Total Students</label>
                        <input type="number" id="TotalStudents" name="TotalStudents" value="${TotalStudents}"/>
                    </div>
                      <div class="form-group">
                        <label for="Picture">Picture</label>
                        <img src="<%= request.getContextPath() %>/${Picture}" alt="${SchoolName}" width="200" />
                        <input type="file" id="Picture" name="Picture" />
                    </div>
                    <div class="form-group">
                        <label for="Description">Description</label>
                        <input type="text" id="TotalStudents" name="Description" value="${Description}"/>
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
                        <select id="DistrictID" name="DistrictId">
                            <option value="${DistrictId}">${district}</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="ward">Ward</label>
                        <select id="WardID" name="WardId">
                            <option value="${WardId}">${WardName}</option>
                        </select>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-primary" name="btnUp" >Update</button>
                    <button type="submit" class="btn-secondary" name="btnCancel">Cancel</button>
                </div>
            </form>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
