package model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class ImportReceipt {
    private int id;
    private Date importDate;
    private Supplier supplier;
    private Member staff;
    private final List<ImportReceiptDetail> details = new ArrayList<>();

    public ImportReceipt() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Date getImportDate() { return importDate; }
    public void setImportDate(Date importDate) { this.importDate = importDate; }

    public Supplier getSupplier() { return supplier; }
    public void setSupplier(Supplier supplier) { this.supplier = supplier; }

    public Member getStaff() { return staff; }
    public void setStaff(Member staff) { this.staff = staff; }

    public List<ImportReceiptDetail> getDetails() { return details; }

    /** Tong tien = tong thanh tien cua cac dong chi tiet. */
    public double getTotalPrice() {
        double total = 0;
        for (ImportReceiptDetail d : details) {
            total += d.getSubTotal();
        }
        return total;
    }
}
