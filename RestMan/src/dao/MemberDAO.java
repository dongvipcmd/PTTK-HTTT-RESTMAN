package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Member;

public class MemberDAO {

    /** Dang nhap cho nhan vien kho. Tra ve null neu sai thong tin hoac khong phai nhan vien kho. */
    public Member checkLogin(String username, String password) {
        String sql = "SELECT m.id, m.username, m.name "
                + "FROM tblMember m "
                + "JOIN tblWareHouseStaff w ON w.tblStafftblMemberid = m.id "
                + "WHERE m.username = ? AND m.password = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Member m = new Member();
                    m.setId(rs.getInt("id"));
                    m.setUsername(rs.getString("username"));
                    m.setName(rs.getString("name"));
                    return m;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
