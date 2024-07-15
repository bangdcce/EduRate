/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.UserDAO;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;

/**
 *
 * @author Bang
 */
@MultipartConfig
public class UserServlet extends HttpServlet {

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
            out.println("<title>Servlet UserInfo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserInfo at " + request.getContextPath() + "</h1>");
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
        if (path.startsWith("/EduRate/Profile/")) {
            String[] getUsId = path.split("/");
            String id = getUsId[getUsId.length - 1];
            request.setAttribute("UserId", id);
            request.getRequestDispatcher("/user.jsp").forward(request, response);
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
        if (request.getParameter("btnUpdate") != null) {
            int count = 0;
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String birthDate = request.getParameter("birthday");
            int tagId = Integer.parseInt(request.getParameter("tag"));
            int genderId = Integer.parseInt(request.getParameter("gender"));
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            int Province = Integer.parseInt(request.getParameter("province"));
            int District = Integer.parseInt(request.getParameter("district"));
            int Ward = Integer.parseInt(request.getParameter("ward"));

            String userID = request.getParameter("userId");

            User us = new User(firstName, lastName, userID, "", Date.valueOf(birthDate), tagId, genderId, Province, District, Ward, phone);
            UserDAO usDao = new UserDAO();
            count = usDao.updateUser(us);
            boolean checkEmail = usDao.checkExistEmail(email);
            boolean checkPhone = usDao.checkExistPhone(phone);
            if (count > 0 && !checkEmail && !checkPhone) {
                int checkUpdateEmail = usDao.updateEmail(email, userID);
                int checkUpdatePhone = usDao.updatePhone(phone, userID);

                if (checkUpdateEmail > 0 && checkUpdatePhone > 0 && count > 0) {
                    request.getSession().setAttribute("Success", "Update success");
                    response.sendRedirect("/EduRate/Profile/" + userID);
                } else {
                    request.getSession().setAttribute("Fail", "Update failed");
                    response.sendRedirect("/EduRate/Profile/" + userID);
                }
            } else if (checkEmail) {
                request.getSession().setAttribute("FailEmail", "Email was existed");
                response.sendRedirect("/EduRate/Profile/" + userID);
                // Add your failure response or redirection logic here
            } else if (checkPhone) {
                request.getSession().setAttribute("FailPhone", "Phone was existed");
                response.sendRedirect("/EduRate/Profile/" + userID);
            } else {
                request.getSession().setAttribute("Fail", "Update failed");
                response.sendRedirect("/EduRate/Profile/" + userID);
            }
        } else if (request.getParameter("btnUpload") != null) {
            int count = 0;
            String userID = request.getParameter("userId");
            //Luu anh
            Part filePart = request.getPart("file");

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
            UserDAO dao = new UserDAO();
            count = dao.updatePicture(userID, relativePath);
            if (count > 0) {
                request.getSession().setAttribute("Success", "Picture updated successfully");
                response.sendRedirect("/EduRate/Profile/" + userID);
            } else {
                request.getSession().setAttribute("Fail", "Picture update failed");
                response.sendRedirect("/EduRate/Profile/" + userID);
            }

        }else if(request.getParameter("btnCancel")!=null){
            response.sendRedirect("/EduRate/Home");
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
