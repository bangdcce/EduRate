<%-- 
    Document   : forgotPassword
    Created on : Jul 14, 2024
    Author     : Bang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Forgot Password</title>
    <style>
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="email"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        button {
            padding: 10px 20px;
            background-color: blue;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: darkblue;
        }
        .message {
            margin-top: 20px;
            color: green;
        }
        .error {
            margin-top: 20px;
            color: red;
        }
    </style>
</head>
<body>
    <h1>Forgot Password</h1>
    <form action="ForgotPassServlet" method="post">
        <div class="form-group">
            <label for="email">Enter your email address:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <button type="submit" name="btnSearch">Search</button>
        <button type="button" onclick="redirectToHome()">Cancel</button>
    </form>
    <%-- Displaying any success or error messages --%>
    <script type="text/javascript">
        function redirectToHome() {
            window.location.href = "/LoginServlet/Login"; // Replace "home.jsp" with the actual home page URL
        }
    </script>
</body>
</html>
