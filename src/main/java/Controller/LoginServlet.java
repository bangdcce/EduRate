/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DBConnect.DBConnect;
import Models.MD5Hashing;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Bang
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI();
        if (path.endsWith("/Login")) {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else if (path.endsWith("/LoginFailed")) {
            request.setAttribute("err", "Vui lòng nhập đúng mật khẩu !");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("btn-Login") != null) {
            String user = request.getParameter("txtUsername");
            String pass = request.getParameter("txtPassword");

            String enCodePass = MD5Hashing.hash(pass);

            DBConnect db = new DBConnect();
            Connection conn = db.getConnection();
            try {
                String sql = "Select * from [User] where UserName=? AND Password=? ";
                PreparedStatement st = conn.prepareStatement(sql);
                st.setString(1, user);
                st.setString(2, enCodePass);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    int TimeOutDate = 3 * 24 * 3600;

                    HttpSession session = request.getSession();
                    request.getSession().setAttribute("SessionName", user);
                    session.setMaxInactiveInterval(TimeOutDate);

                    Cookie cookie = new Cookie("CookieName", user);
                    cookie.setMaxAge(TimeOutDate);
                    response.addCookie(cookie);

                    response.sendRedirect("/EduRate/Home");

                } else {
                    response.sendRedirect("/LoginServlet/LoginFailed");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
