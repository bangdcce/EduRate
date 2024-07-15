/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAOs.SchoolDAO;
import DAOs.UserDAO;
import Models.School;
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
import java.time.LocalDate;

/**
 *
 * @author Bang
 */
@MultipartConfig
public class EditServlet extends HttpServlet {

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
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditServlet at " + request.getContextPath() + "</h1>");
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
        if (path.startsWith("/EditServlet/Edit/")) {
            String[] getId = path.split("/");
            String id = getId[getId.length - 1];
            request.setAttribute("SchoolID", id);
            request.getRequestDispatcher("/Edit.jsp").forward(request, response);
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
        if (request.getParameter("btnCancel") != null) {
            response.sendRedirect("/EduRate/Home");
            // Exit the method after redirection
        } else if (request.getParameter("btnUp") != null) {

            String SchoolID = request.getParameter("SchoolID");
            String SchoolName = request.getParameter("SchoolName");
            String EstablishedDate = request.getParameter("EstablishedDate");
            int TotalStudents = Integer.parseInt(request.getParameter("TotalStudents"));
            String Website = request.getParameter("Website");

            int ProvinceID = Integer.parseInt(request.getParameter("province"));

            int DistrictId = Integer.parseInt(request.getParameter("DistrictId"));

            int WardId = Integer.parseInt(request.getParameter("WardId"));

            String Description = request.getParameter("Description");
            int count = 0;

            //Luu anh
            Part filePart = request.getPart("Picture");

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
            School school = new School(SchoolID, SchoolName, Date.valueOf(EstablishedDate), TotalStudents, Website, ProvinceID, DistrictId, WardId,0, relativePath, Description, 0, 0, 0);
            SchoolDAO shDao = new SchoolDAO();
            count = shDao.updateSchoolByID(SchoolID, school);
            if (count > 0) {
                response.sendRedirect("/EditServlet/Edit/"+SchoolID);
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
