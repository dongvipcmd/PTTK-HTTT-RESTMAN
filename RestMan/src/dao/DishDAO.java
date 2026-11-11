package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Dish;

public class DishDAO {

    /** Tim cac mon an co ten chua tu khoa. */
    public List<Dish> searchDish(String keyword) {
        List<Dish> list = new ArrayList<>();
        String sql = "SELECT * FROM tblDish WHERE name LIKE ? ORDER BY name";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Lay chi tiet mon an theo id. Tra ve null neu khong co. */
    public Dish getDishById(int id) {
        String sql = "SELECT * FROM tblDish WHERE id = ?";
        try (Connection con = DBContext.getConnection();
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

    private Dish mapRow(ResultSet rs) throws SQLException {
        Dish d = new Dish();
        d.setId(rs.getInt("id"));
        d.setName(rs.getString("name"));
        d.setPrice(rs.getDouble("price"));
        d.setNote(rs.getString("note"));
        d.setImage(rs.getString("image"));
        return d;
    }
}
