package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import model.ImportReceipt;
import model.ImportReceiptDetail;

public class ImportReceiptDAO {

    /**
     * Luu phieu nhap va cac dong chi tiet trong mot transaction:
     * hoac luu het, hoac khong luu gi (rollback khi loi).
     * Dong thoi cong so luong vao ton kho cua nguyen lieu.
     */
    public boolean saveReceipt(ImportReceipt receipt) {
        String sqlReceipt = "INSERT INTO tblImportReceipt"
                + "(importDate, totalPrice, tblWareHouseStafftblStafftblMemberid, Supplierid) "
                + "VALUES (?, ?, ?, ?)";
        String sqlDetail = "INSERT INTO tblImportReceiptDetail"
                + "(quantity, price, tblImportReceiptid, tblIngredientid) VALUES (?, ?, ?, ?)";
        String sqlStock = "UPDATE tblIngredient SET quantity = quantity + ? WHERE id = ?";

        try (Connection con = DBContext.getConnection()) {
            con.setAutoCommit(false);
            try {
                try (PreparedStatement ps = con.prepareStatement(sqlReceipt, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setDate(1, receipt.getImportDate());
                    ps.setDouble(2, receipt.getTotalPrice());
                    ps.setInt(3, receipt.getStaff().getId());
                    ps.setInt(4, receipt.getSupplier().getId());
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (!rs.next()) {
                            throw new SQLException("Khong lay duoc id phieu nhap");
                        }
                        receipt.setId(rs.getInt(1));
                    }
                }

                try (PreparedStatement psDetail = con.prepareStatement(sqlDetail);
                     PreparedStatement psStock = con.prepareStatement(sqlStock)) {
                    for (ImportReceiptDetail d : receipt.getDetails()) {
                        psDetail.setDouble(1, d.getQuantity());
                        psDetail.setDouble(2, d.getPrice());
                        psDetail.setInt(3, receipt.getId());
                        psDetail.setInt(4, d.getIngredient().getId());
                        psDetail.addBatch();

                        psStock.setDouble(1, d.getQuantity());
                        psStock.setInt(2, d.getIngredient().getId());
                        psStock.addBatch();
                    }
                    psDetail.executeBatch();
                    psStock.executeBatch();
                }

                con.commit();
                return true;
            } catch (SQLException e) {
                con.rollback();
                e.printStackTrace();
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
