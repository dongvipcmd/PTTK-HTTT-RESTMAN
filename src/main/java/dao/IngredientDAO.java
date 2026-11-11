
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Ingredient;

public class IngredientDAO {
    
    public List<Ingredient> searchIngredientByName(String name, int supplierId){
        List<Ingredient> list = new ArrayList<>();
        String sql = "SELECT DISTINCT i.* FROM tblIngredient i "
                + "JOIN tblImportReceiptDetail d ON d.tblIngredientid = i.id "
                + "JOIN tblImportReceipt r ON r.id = d.tblImportReceiptid "
                + "WHERE r.Supplierid = ? AND i.name LIKE ? "
                + "ORDER BY i.name";
        try(Connection con = DAO.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1, supplierId);
            ps.setString(2, "%"+name+"%");
            try(ResultSet rs = ps.executeQuery()){
                while(rs.next()){
                    list.add(mapRow(rs));
                }
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return list;
    }
    
    public Ingredient getById(int id) {
        String sql = "SELECT * FROM tblIngredient WHERE id = ?";
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
    
    public int addIngredient(Ingredient ing) {
    String sql = "INSERT INTO tblIngredient(name, massUnits, price, quantity, note) "
               + "VALUES (?, ?, ?, 0, ?)";
    try (Connection con = DAO.getConnection();
         PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
        ps.setString(1, ing.getName());
        ps.setString(2, ing.getMassUnits());
        ps.setDouble(3, ing.getPrice());
        ps.setString(4, ing.getNote());
        if (ps.executeUpdate() > 0) {
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return -1;
    }
    
    private Ingredient mapRow(ResultSet rs) throws SQLException {
        Ingredient i = new Ingredient();
        i.setId(rs.getInt("id"));
        i.setName(rs.getString("name"));
        i.setMassUnits(rs.getString("massUnits"));
        i.setPrice(rs.getDouble("price"));
        i.setNote(rs.getString("note"));
        return i;
    }
    
}
