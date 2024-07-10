/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
/**
 *
 * @author thong
 */
@WebServlet("/SignOut")
public class SignOutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Hủy phiên làm việc
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        // Get all cookies from the request
            Cookie[] cookies = request.getCookies();
            // Iterate through all cookies and set their max age to 0 to delete them
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }

            // Redirect the user to the login page
            response.sendRedirect("index.jsp");
    }
}
