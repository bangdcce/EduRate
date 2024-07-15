<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Education Rating</title>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <style>
        /* Resetting default styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        /* Style for body */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            flex-direction: column;
            background: linear-gradient(1135deg, #000000, #004e92);
        }

        /* Style for the box container */
        .box {
            position: relative;
            width: 700px;
            padding: 2px;
            background: #1c1c1c;
            border-radius: 8px;
            overflow: hidden;
        }

        /* Animation for background */
        .box::before
        {
            content: '';
            z-index: 1;
            position: absolute;
            top: -50%;
            left: -50%;
            width: 700px;
            height: 1000px;
            transform-origin: bottom right;
            background: linear-gradient(0deg,transparent,#45f3ff,#45f3ff);
            animation: animate 6s linear infinite;
        }
        .box::after
        {
            content: '';
            z-index: 1;
            position: absolute;
            top: -50%;
            left: -50%;
            width: 700px;
            height: 1000px;
            transform-origin: bottom right;
            background: linear-gradient(0deg,transparent,#45f3ff,#45f3ff);
            animation: animate 6s linear infinite;
            animation-delay: -3s;
        }

        .box::after {
            animation-delay: -3s;
        }

        @keyframes animate {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }

        /* Form styling */
        form {
            position: relative;
            background: #28292d;
            padding: 40px;
            border-radius: 8px;
            z-index: 2;
            display: flex;
            flex-direction: column;
        }

        /* Title styling */
        h2 {
            color: #45f3ff;
            font-weight: 500;
            text-align: center;
            letter-spacing: 0.1em;
            margin-bottom: 30px;
        }

        /* Input box styling */
        .inputBox {
            position: relative;
            width: 100%;
margin-bottom: 20px;
        }

        .inputBox input, .inputBox select {
            width: 100%;
            padding: 15px;
            background: transparent;
            border: 2px solid #45f3ff;
            border-radius: 4px;
            color: #ffffff;
            font-size: 1em;
            letter-spacing: 0.05em;
            transition: 0.5s;
            outline: none;
            box-shadow: none;
        }

        .inputBox select {
            background: #1c1c1c;
        }

        .inputBox span {
            position: absolute;
            left: 15px;
            top: 15px;
            font-size: 1em;
            color: #8f8f8f;
            transition: 0.5s;
        }

        .inputBox input:focus ~ span, .inputBox select:focus ~ span {
            color: #45f3ff;
            top: -14px;
            font-size: 0.75em;
        }

        input[type="submit"] {
            border: none;
            padding: 12px 25px;
            background: #45f3ff;
            cursor: pointer;
            border-radius: 4px;
            font-weight: 600;
            color: #28292D;
            font-size: 1em;
            transition: 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #8f8f8f;
            transform: scale(1.05);
        }

        /* Link styling */
        .links {
            display: flex;
            justify-content: space-between;
        }

        .links a {
            font-size: 0.75em;
            color: #8f8f8f;
            text-decoration: none;
            transition: color 0.3s;
        }

        .links a:hover {
            color: #45f3ff;
        }
        .inputBox label {
            color: #45f3ff;
            display: block;
            margin-bottom: 5px;
        }
        .inputBox input[type="date"]::-webkit-calendar-picker-indicator {
            filter: invert(1);
        }
        .redirect-btn {
            border: none;
            margin-top: 10px;
            padding: 5px 10px;
            background: #45f3ff;
            cursor: pointer;
            border-radius: 4px;
            font-weight: 200;
            color: #28292D;
            font-size: 0.9em;
            transition: 0.3s;
        }

        .redirect-btn:hover {
            background-color: #8f8f8f;
            transform: scale(1.05);
        }


    </style>
    <body>
        <a href="/">Back</a>
        <sql:setDataSource var="conn"
                           driver="com.microsoft.sqlserver.jdbc.SQLServerDriver"
                           url="jdbc:sqlserver://ASUS3DK\\CHIBANG:1433;databaseName=EduReview;encrypt=true;trustServerCertificate=true;"
                           user="sa"
                           password="sa123" />
        <sql:query dataSource="${conn}" var="rsTag">
            SELECT TagID, TagCategory FROM TagCategory
        </sql:query>

        <sql:query var="rsGender" dataSource="${conn}">
SELECT GenderID, Gender FROM Gender
        </sql:query>

        <sql:query var="rsProvince" dataSource="${conn}">
            SELECT ProvinceID, ProvinceName FROM Province
        </sql:query>
        <div class="box">
            <form action="RegisterServlet" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">
                <h2>Register</h2>
                <div class="inputBox">
                    <label for="firstName">First Name</label>
                    <input type="text" id="firstName" name="firstName" required>
                    <i></i>
                </div>
                <div class="inputBox">
                    <label for="lastName">Last Name</label>
                    <input type="text" id="lastName" name="lastName" required>
                    <i></i>
                </div>
                <div class="inputBox">
                    <label for="userName">User Name</label>
                    <input type="text" name="userName" required>
                    <i></i>
                </div>
                <div class="inputBox">
                    <label for="passWord">Password</label>
                    <input type="password" name="passWord" required>
                    <i></i>
                </div>
                <div class="inputBox">
                    <label for="confirmPassword">Repeat Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                    <i></i>
                </div>
                <div class="inputBox">
                    <label for="birthDay">Birthday</label>
                    <input type="date" name="birthDay" required>
                    <i></i>
                </div>
                <div class="inputBox">
                    <label for="picture">Avarta</label>
                    <input type="file" name="picture">
                    <i></i>
                </div>
                <div class="inputBox">
                    <label for="email">Email</label>
                    <input type="email" name="email" required>
                    <i></i>
                </div>
                <div class="inputBox">
                    <label for="phone">Phone</label>
                    <input type="tel" id="phone" name="phone" required>
                    <i></i>
                </div>

                <div class="inputBox">
                    <select name="tagId" required>
                        <option value="" disabled selected>Tag</option>
                        <c:forEach var="row" items="${rsTag.rows}">
                            <option value="${row.TagID}">${row.TagCategory}</option>
                        </c:forEach>
                    </select>
                    <i></i>
                </div>
                <div class="inputBox">
                    <select name="genderID" required>
<option value="" disabled selected>Gender</option>
                        <c:forEach var="row" items="${rsGender.rows}">
                            <option value="${row.GenderID}">${row.Gender}</option>
                        </c:forEach>
                    </select>
                    <i></i>
                </div>
                <div class="inputBox">
                    <select id="provinceID" name="provinceID" required>
                        <option value="" disabled selected>Province</option>
                        <c:forEach var="row" items="${rsProvince.rows}">
                            <option value="${row.ProvinceID}">${row.ProvinceName}</option>
                        </c:forEach>
                    </select>
                    <i></i>
                </div>
                <div class="inputBox">
                    <select id="DistrictID" name="DistrictID" required>
                        <option value="" disabled selected>District</option>
                    </select>
                    <i></i>
                </div>
                <div class="inputBox">
                    <select id="WardID" name="WardID" required>
                        <option value="" disabled selected>Ward</option>
                    </select>
                    <i></i>
                </div>
                <input type="submit" value="Register">
                <button type="button" class="redirect-btn" onclick="location.href = '/LoginServlet/Login';">Back to Login</button>
            </form>
        </div>

        <script>
            $(document).ready(function () {
                var userNameError = '${userNameError}';
                var emailError = '${emailError}';
                var phoneError = '${phoneError}';
                var successNote = '${successNote}';
                var failNote = '${failNote}';

                if (userNameError) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: userNameError
                    });
                }
                if (emailError) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: emailError
                    });
                }
                if (phoneError) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: phoneError
                    });
                }
                if (successNote) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success',
                        text: "${successNote}"
                    }).then(function () {
                        setTimeout(function () {
window.location.href = '/LoginServlet/Login';
                        }, 1000);
                    });
                }
                if (failNote) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: failNote
                    });
                }

                // Cập nhật dropdown cho quận/huyện và xã/phường dựa vào lựa chọn của người dùng
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

            function validateForm() {
                var firstName = document.getElementById('firstName').value.trim();
                var lastName = document.getElementById('lastName').value.trim();
                var password = document.getElementById('passWord').value;
                var confirmPassword = document.getElementById('confirmPassword').value;
                var phoneNumber = document.getElementById('phone').value.trim();
                var namePattern = /[A-Z][a-zA-Z]+/;
                var phonePattern = /^$|(09|08|07|05|03)\d{8}$/;

                if (!namePattern.test(firstName) || !namePattern.test(lastName)) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Tên và họ chỉ được chứa chữ cái, và chữ cái đầu tiên phải viết hoa.'
                    });
                    return false;
                }

                if (!phonePattern.test(phoneNumber)) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Số điện thoại không hợp lệ. Vui lòng nhập số điện thoại di động Việt Nam đúng định dạng.'
                    });
                    return false;
                }

                if (password !== confirmPassword) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
text: 'Mật khẩu nhập lại không khớp.'
                    });
                    return false;
                }

                var provinceID = document.getElementById('provinceID').value;
                var districtID = document.getElementById('DistrictID').value;
                var wardID = document.getElementById('WardID').value;

                if (!provinceID || provinceID === "" || provinceID === "Province" ||
                        !districtID || districtID === "" || districtID === "District" ||
                        !wardID || wardID === "" || wardID === "Ward") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Vui lòng chọn đầy đủ Tỉnh/Thành phố, Quận/Huyện và Xã/Phường.'
                    });
                    return false;
                }

                return true; // Submit the form if all validations pass
            }
        </script>


    </body>
</html>