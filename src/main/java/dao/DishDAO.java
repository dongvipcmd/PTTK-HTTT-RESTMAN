package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Statement;
import model.Dish;

public class DishDAO {

    public DishDAO() {
        
    }

    public List<Dish> searchDish(String keyword) {
        List<Dish> list = new ArrayList<>();
        String sql = "SELECT * FROM tblDish WHERE name LIKE ? ORDER BY name";
        try (Connection con = DAO.getConnection();
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

    public Dish getDishById(int id) {
        String sql = "SELECT * FROM tblDish WHERE id = ?";
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

    public Dish addDish(Dish d) {
        String sql = "INSERT INTO tblDish(name, price, note, image) VALUES (?, ?, ?, ?)";
        try (Connection con = DAO.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, d.getName());
            ps.setDouble(2, d.getPrice());
            ps.setString(3, d.getNote());
            ps.setString(4, d.getImage());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    d.setId(rs.getInt(1));
                    return d;
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