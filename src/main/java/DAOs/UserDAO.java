package DAOs;

import DBConnect.DBConnect;
import Models.MD5Hashing;
import Models.User;
import static Models.VerifyCode.generateVerificationCode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO extends DBConnect {

    public int addUser(User user) {
        String insertUserSQL = "INSERT INTO [User] (FirstName, LastName, UserName, Password, BirthDay, TagID, GenderID, ProvinceID, DistrictID, WardID, Picture, RoleID) "
                + "VALUES (?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, 1)";
        try ( Connection conn = getConnection();  PreparedStatement insert = conn.prepareStatement(insertUserSQL)) {
            String endCodePass = MD5Hashing.hash(user.getPassword());
            insert.setString(1, user.getFirstName());
            insert.setString(2, user.getLastName());
            insert.setString(3, user.getUserName());
            insert.setString(4, endCodePass);
            insert.setDate(5, user.getBirthDay());
            insert.setInt(6, user.getTagID());
            insert.setInt(7, user.getGenderID());
            insert.setInt(8, user.getProvinceID());
            insert.setInt(9, user.getDistrictID());
            insert.setInt(10, user.getWardID());
            insert.setString(11, user.getPicture());

            return insert.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public String getUserId(String userName) {
        String selectUserSQL = "SELECT UserID FROM [User] WHERE username = ?";
        try ( Connection conn = getConnection();  PreparedStatement selectID = conn.prepareStatement(selectUserSQL)) {

            selectID.setString(1, userName);
            try ( ResultSet rs = selectID.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("UserID");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int addEmail(String email, String userId) {
        String insertEmailSQL = "INSERT INTO Email (EmailAddress, UserID) VALUES (?, ?)";
        try ( Connection conn = getConnection();  PreparedStatement insertEmail = conn.prepareStatement(insertEmailSQL)) {

            insertEmail.setString(1, email);
            insertEmail.setString(2, userId);// Assuming you have a method to generate a verification code
            return insertEmail.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int addPhone(String phone, String userId) {
        String insertPhoneSQL = "INSERT INTO Phone (PhoneNum, UserID) VALUES (?, ?)";
        try ( Connection conn = getConnection();  PreparedStatement insertPhone = conn.prepareStatement(insertPhoneSQL)) {

            insertPhone.setString(1, phone);
            insertPhone.setString(2, userId);
            return insertPhone.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int CheckExitsValue(User user, String phone, String email) {
        if (checkExistUserName(user.getUserName())) {
            return 1;
        }
        if (checkExistPhone(phone)) {
            return 2;
        }
        if (checkExistEmail(email)) {
            return 3;
        }
        return 0;
    }

    public ResultSet getUserbyId(String userid) throws SQLException {
        ResultSet rs = null;
        String sql = "Select us.FirstName,us.LastName,us.BirthDay,tc.TagID,tc.TagCategory,g.GenderID,g.Gender,p.ProvinceID,p.ProvinceName,ds.DistrictID,ds.DistrictName,w.WardID,w.WardName,us.Picture,ph.PhoneNum,e.EmailAddress from [User] us join Province p on us.ProvinceID=p.ProvinceID\n"
                + "                        Join District ds on us.DistrictID= ds.DistrictID\n"
                + "						join Ward w on  us.WardID=w.WardID\n"
                + "						Join Gender g on us.GenderID=g.GenderID\n"
                + "						join TagCategory tc on us.TagID=tc.TagID\n"
                + "						Left Join Phone ph on us.UserID =ph.UserID\n"
                + "                                             left Join Email e on us.UserID=e.UserID\n"
                + "                                              where us.UserName=?";
        Connection conn = DBConnect.getConnection();
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, userid);
        rs = st.executeQuery();
        return rs;
    }

    public ResultSet getRole(String username) throws SQLException {
        ResultSet rs = null;
        String sql = "Select rl.Role From [User] us join [Role] rl on us.RoleID=rl.RoleID\n"
                + "where UserName=?";
        Connection conn = DBConnect.getConnection();
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, username);
        rs = st.executeQuery();
        return rs;
    }

    public int updatePicture(String userId, String file) {
        DBConnect db = new DBConnect();
        int count = 0;
        String sql = "UPDATE [User]\n"
                + "SET Picture = ? \n"
                + "WHERE UserName=?;";
        try {
            Connection conn = db.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, file);
            stmt.setString(2, userId);
            count = stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean checkExistUserName(String userName) {
        DBConnect db = new DBConnect();
        String selectUserName = "SELECT UserName FROM [User] WHERE UserName = ?";
        try ( Connection conn = db.getConnection();  PreparedStatement stUserName = conn.prepareStatement(selectUserName)) {
            stUserName.setString(1, userName);
            try ( ResultSet userRS = stUserName.executeQuery()) {
                return userRS.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkExistPhone(String phone) {
        DBConnect db = new DBConnect();
        String selectPhone = "SELECT PhoneNum FROM Phone WHERE PhoneNum = ?";
        try ( Connection conn = db.getConnection();  PreparedStatement stPhone = conn.prepareStatement(selectPhone)) {
            stPhone.setString(1, phone);
            try ( ResultSet phoneRS = stPhone.executeQuery()) {
                return phoneRS.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkExistEmail(String email) {
        DBConnect db = new DBConnect();
        String selectEmail = "SELECT EmailAddress FROM Email WHERE EmailAddress = ?";
        try ( Connection conn = db.getConnection();  PreparedStatement stEmail = conn.prepareStatement(selectEmail)) {
            stEmail.setString(1, email);
            try ( ResultSet emailRS = stEmail.executeQuery()) {
                return emailRS.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int updateUser(User user) {
        DBConnect db = new DBConnect();
        String updateUserSQL = "UPDATE [User] SET FirstName = ?, LastName = ?, BirthDay = ?, TagID = ?, GenderID = ?, ProvinceID = ?, DistrictID = ?, WardID = ? WHERE UserName = ?";
        try ( Connection conn = db.getConnection();  PreparedStatement update = conn.prepareStatement(updateUserSQL)) {
            update.setString(1, user.getFirstName());
            update.setString(2, user.getLastName());
            update.setDate(3, user.getBirthDay());
            update.setInt(4, user.getTagID());
            update.setInt(5, user.getGenderID());
            update.setInt(6, user.getProvinceID());
            update.setInt(7, user.getDistrictID());
            update.setInt(8, user.getWardID());
            update.setString(9, user.getUserName());  // Assuming username is used to identify the user

            return update.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int updatePhone(String phone, String userId) {
        String updatePhoneSQL = "UPDATE Phone SET PhoneNum = ? WHERE UserID = (Select UserID from [User] where UserName=?)";
        try ( Connection conn = getConnection();  PreparedStatement updatePhone = conn.prepareStatement(updatePhoneSQL)) {
            updatePhone.setString(1, phone);
            updatePhone.setString(2, userId);

            return updatePhone.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int updateEmail(String email, String userId) {
        String updateEmailSQL = "UPDATE Email SET EmailAddress = ? WHERE UserID = (Select UserID from [User] where UserName=?)";
        try ( Connection conn = getConnection();  PreparedStatement updateEmail = conn.prepareStatement(updateEmailSQL)) {
            updateEmail.setString(1, email);
            updateEmail.setString(2, userId);

            return updateEmail.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public String getVerificationCodeByEmail(String email) {
        String selectVerificationCodeSQL = "SELECT VerificationCode FROM Email WHERE EmailAddress = ?";
        try ( Connection conn = getConnection();  PreparedStatement selectVerificationCode = conn.prepareStatement(selectVerificationCodeSQL)) {
            selectVerificationCode.setString(1, email);
            try ( ResultSet rs = selectVerificationCode.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("VerificationCode");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int updateVerificationCode(String email, String newVerificationCode) {
        String updateVerificationSQL = "UPDATE Email SET VerificationCode = ? WHERE EmailAddress = ?";
        try ( Connection conn = getConnection();  PreparedStatement updateVerification = conn.prepareStatement(updateVerificationSQL)) {
            updateVerification.setString(1, newVerificationCode);
            updateVerification.setString(2, email);

            return updateVerification.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int updatePasswordByEmail(String email, String newPassword) {
        String updatePasswordSQL = "UPDATE [User] "
                + "SET Password = ? "
                + "WHERE UserID = (SELECT UserID FROM Email WHERE EmailAddress = ?)";
        try ( Connection conn = getConnection();  PreparedStatement updatePassword = conn.prepareStatement(updatePasswordSQL)) {
            String hashedPassword = MD5Hashing.hash(newPassword);
            updatePassword.setString(1, hashedPassword);
            updatePassword.setString(2, email);

            return updatePassword.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}

