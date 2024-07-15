<%-- 
    Document   : Verify
    Created on : Jul 14, 2024, 8:49:31 PM
    Author     : Bang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify Code</title>
    </head>
    <body>
        <% String usEmail = (String) request.getAttribute("UserEmail");%>
        <h1>Verify Your Code</h1>
        <form action="VerifyServlet" method="post">
            <label for="verificationCode">Enter Verification Code:</label>
            <input type="text" id="verificationCode" name="verificationCode" required>
            <input type="hidden" name="usEmail" value="<%=usEmail%>">
            <button type="submit" name="Yes">Verify</button>
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
