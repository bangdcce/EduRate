package Models;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import static jdk.nashorn.tools.ShellFunctions.input;

public class MD5Hashing {

    // Method to hash a string into MD5 string
    public static String hash(String password) {
   try {
            // Tạo một đối tượng MessageDigest với thuật toán MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
            
            // Cập nhật message digest bằng dữ liệu byte của mật khẩu
            md.update(password.getBytes());
            
            // Chuyển đổi message digest thành một biểu diễn thập lục phân
               byte[] digest = md.digest();
            
            // Chuyển đổi mảng byte thành biểu diễn thập lục phân
                BigInteger no = new BigInteger(1, digest);

            
            // Convert biểu diễn thập lục phân thành một chuỗi hex
            String hashText = no.toString(16);
            
            // Thêm các số 0 đằng trước nếu cần
            while (hashText.length() < 32) {
                hashText = "0" + hashText;
            }
            
            return hashText;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}
