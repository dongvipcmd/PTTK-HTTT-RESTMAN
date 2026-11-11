package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Member;

public class MemberDAO {
    public Member checkLogin(String username, String password){
        String sql = "SELECT m.id, m.username, m.name, m.dob, m.address, m.email, m.phoneNumber "
                + "FROM tblMember m "
                + "JOIN tblWareHouseStaff w ON w.tblStafftblMemberid = m.id "
                + "WHERE m.username = ? AND m.password = ?";
        try (Connection con = DAO.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)){
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Member m = new Member(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("name"),
                        rs.getString("dob"),
                        rs.getString("address"),
                        rs.getString("email"),
                        rs.getString("phoneNumber")
                    );
                    return m;
                }
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return null;
    }
}
