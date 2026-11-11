package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Supplier;

public class SupplierDAO {
    public List<Supplier> searchSupplier(String name){
       List<Supplier> list = new ArrayList<>();
       String sql = "SELECT * FROM tblSupplier WHERE name LIKE ? ORDER BY name";
       try(Connection con = DAO.getConnection(); 
           PreparedStatement ps = con.prepareStatement(sql)){
           ps.setString(1, "%" + name +"%");
           try(ResultSet rs = ps.executeQuery()){
               while(rs.next()){
                   list.add(mapRow(rs));
               }
           }
           
       }
       catch(SQLException e){
           e.printStackTrace();
       }
        return list;
    }
    
    public Supplier getSupplierById(int id){
        String sql = "SELECT * FROM tblSupplier WHERE id = ?";
        try (Connection con = DAO.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addSupplier(Supplier s) {
    String sql = "INSERT INTO tblSupplier(name, address, phoneNumber, note) VALUES (?, ?, ?, ?)";
    try (Connection con = DAO.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, s.getName());
        ps.setString(2, s.getAddress());
        ps.setString(3, s.getPhoneNumber());
        ps.setString(4, s.getNote());
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
    
   private Supplier mapRow(ResultSet rs) throws SQLException {
        Supplier s = new Supplier();
        s.setId(rs.getInt("id"));
        s.setName(rs.getString("name"));
        s.setAddress(rs.getString("address"));
        s.setPhoneNumber(rs.getString("phoneNumber"));
        s.setNote(rs.getString("note"));
        return s;
    }
    
}
