<%-- 
    Document   : ChangePassword
    Created on : Jul 14, 2024, 9:58:32 PM
    Author     : Bang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Change Password</title>
    </head>
    <body>
        <h1>Change Password</h1>
        <% String usEmail = (String) request.getAttribute("UserEmail");%>
        <form action="ChangePassword" method="post">
            <div>
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" required>
            </div>
            <div>
                <label for="repeatPassword">Repeat Password:</label>
                <input type="password" id="repeatPassword" name="repeatPassword" required>
                <input type="hidden" name="usEmail" value="<%=usEmail%>">
            </div>
            <button type="submit" name="btnChange">Change Password</button>
             <button type="button" onclick="redirectToHome()">Cancel</button>
        </form>

        <%-- Display error messages if any --%>
    <c:if test="${not empty errorMessage}">
        <p style="color: red">${errorMessage}</p>
    </c:if>
    <script type="text/javascript">
        function redirectToHome() {
            window.location.href = "/LoginServlet/Login"; // Replace "home.jsp" with the actual home page URL
        }
    </script>
</body>
</html>
