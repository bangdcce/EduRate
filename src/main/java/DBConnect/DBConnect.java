/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBConnect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Bang
 */
public class DBConnect {


  public static Connection getConnection() {
        Connection connection;
        try {
            String url = "jdbc:sqlserver://ASUS3DK\\CHIBANG:1433;databaseName=EduReview;encrypt=true;trustServerCertificate=true;";
            String username = "sa";
            String password = "sa123";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
            connection = null;
        }
        return connection;
    }
}
