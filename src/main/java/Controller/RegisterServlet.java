/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.UserDAO;
import Models.User;
import Models.VerifyCode;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.IOUtils;

/**
 *
 * @author Bang
 */
@MultipartConfig
public class RegisterServlet extends HttpServlet {

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
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
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
        if (path.endsWith("/Register")) {
            request.getSession().getAttribute("userNameError");
            request.getSession().getAttribute("emailError");
            request.getSession().getAttribute("phoneError");
            request.getSession().getAttribute("failNote");
            request.getSession().getAttribute("successNote");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            HttpSession session = request.getSession();
            session.removeAttribute("userNameError");
            session.removeAttribute("emailError");
            session.removeAttribute("phoneError");
            session.removeAttribute("failNote");
            session.removeAttribute("successNote");
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
        String firstname = request.getParameter("firstName");
        String lastname = request.getParameter("lastName");
        String username = request.getParameter("userName");
        String password = request.getParameter("passWord");
        String dateString = request.getParameter("birthDay");
        int count = 0;

        //Luu anh
        Part filePart = request.getPart("picture");

        // Trích xuất tên file
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Xác định đường dẫn thực sự của thư mục Images trong webapp
        String uploadDir = "C:/Users/Bang/Documents/NetBeansProjects/JSQL/src/main/webapp/Images";

        // Tạo thư mục nếu nó chưa tồn tại
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }

        // Xác định đường dẫn lưu file
        String uploadPath = uploadDir + File.separator + fileName;

        // Lưu file vào máy chủ
        try ( InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, Paths.get(uploadPath));
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Đường dẫn tương đối để lưu vào cơ sở dữ liệu
        String relativePath = "Images/" + fileName;

        // Đường dẫn tương đối để lưu vào cơ sở dữ liệu
        // Retrieve other form parameters
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        int TagId = Integer.parseInt(request.getParameter("tagId"));

        int GenderId = Integer.parseInt(request.getParameter("genderID"));

        int ProvinceId = Integer.parseInt(request.getParameter("provinceID"));
        int DistrictId = Integer.parseInt(request.getParameter("DistrictID"));
        int WardId = Integer.parseInt(request.getParameter("WardID"));

        User user = new User(firstname, lastname, username, password, Date.valueOf(dateString), TagId, GenderId, ProvinceId, DistrictId, WardId, relativePath);
        UserDAO account = new UserDAO();
        int check = 0;
        check = account.CheckExitsValue(user, phone, email);
       if (check == 1) {
            request.getSession().setAttribute("userNameError", "Username đã tồn tại");
            response.sendRedirect("/RegisterServlet/Register");
        } else if (check == 2) {
            request.getSession().setAttribute("phoneError", "Số điện thoại đã tồn tại");
            response.sendRedirect("/RegisterServlet/Register");
        } else if (check == 3) {
            request.getSession().setAttribute("emailError", "Email đã tồn tại");
            response.sendRedirect("/RegisterServlet/Register");
        } else {
            // Register the account if no errors
            count = account.addUser(user);
            if (count == 0) {
                request.getSession().setAttribute("failNote", "Tạo tài khoản thất bại ");
                response.sendRedirect("/RegisterServlet/Register");
            } else {
                if (email != null && phone != null) {
                    String userID = account.getUserId(username);
                    int checkEmail = account.addEmail(email, userID);
                    int checkPhone = account.addPhone(phone, userID);
                    if (checkEmail != 0 && checkPhone != 0) {
                        System.out.println("Add email and phone success");
                    } else {
                        System.out.println("Add fail");
                    }
                } else {
                    System.out.println("Error");
                }
                request.getSession().setAttribute("successNote", "Tạo tài khoản thành công ");
                response.sendRedirect("/RegisterServlet/Register");
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
