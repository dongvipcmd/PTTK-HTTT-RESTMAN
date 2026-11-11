package controller;

import dao.ImportReceiptDAO;
import dao.IngredientDAO;
import dao.SupplierDAO;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ImportReceipt;
import model.ImportReceiptDetail;
import model.Ingredient;
import model.Member;
import model.Supplier;

/**
 * Module 2: nhan vien kho nhap nguyen lieu.
 * Phieu nhap dang soan duoc giu trong session (thuoc tinh "receipt").
 */
@WebServlet("/import")
public class ImportServlet extends HttpServlet {

    private final SupplierDAO supplierDAO = new SupplierDAO();
    private final IngredientDAO ingredientDAO = new IngredientDAO();
    private final ImportReceiptDAO receiptDAO = new ImportReceiptDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        handle(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        handle(req, resp);
    }

    private void handle(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();

        // Chi nhan vien kho da dang nhap moi duoc vao
        Member user = (Member) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            action = "start";
        }

        ImportReceipt receipt = (ImportReceipt) session.getAttribute("receipt");
        if (receipt == null || "start".equals(action)) {
            receipt = new ImportReceipt();
            session.setAttribute("receipt", receipt);
        }

        switch (action) {
            case "searchSupplier":
                req.setAttribute("suppliers", supplierDAO.searchSupplier(param(req, "key")));
                break;

            case "addSupplier": {
                Supplier s = new Supplier();
                s.setName(param(req, "name"));
                s.setAddress(param(req, "address"));
                s.setPhoneNumber(param(req, "phone"));
                s.setNote(param(req, "note"));
                if (s.getName().isEmpty()) {
                    req.setAttribute("error", "Tên nhà cung cấp không được để trống");
                } else {
                    Supplier saved = supplierDAO.addSupplier(s);
                    if (saved != null) {
                        receipt.setSupplier(saved);
                    } else {
                        req.setAttribute("error", "Không thêm được nhà cung cấp");
                    }
                }
                break;
            }

            case "selectSupplier": {
                Integer id = parseInt(req.getParameter("id"));
                if (id != null) {
                    receipt.setSupplier(supplierDAO.getById(id));
                }
                break;
            }

            case "changeSupplier":
                receipt.setSupplier(null);
                break;

            case "searchIngredient":
                req.setAttribute("ingredients", ingredientDAO.searchIngredient(param(req, "key")));
                break;

            case "addIngredient": {
                Ingredient i = new Ingredient();
                i.setName(param(req, "name"));
                i.setMassUnits(param(req, "unit"));
                i.setNote(param(req, "note"));
                if (i.getName().isEmpty()) {
                    req.setAttribute("error", "Tên nguyên liệu không được để trống");
                } else if (ingredientDAO.addIngredient(i) != null) {
                    // Hien luon nguyen lieu vua them de chon
                    req.setAttribute("ingredients", ingredientDAO.searchIngredient(i.getName()));
                } else {
                    req.setAttribute("error", "Không thêm được nguyên liệu");
                }
                break;
            }

            case "addItem":
                addItem(req, receipt);
                break;

            case "removeItem": {
                Integer index = parseInt(req.getParameter("index"));
                if (index != null && index >= 0 && index < receipt.getDetails().size()) {
                    receipt.getDetails().remove((int) index);
                }
                break;
            }

            case "confirm":
                if (receipt.getSupplier() == null) {
                    req.setAttribute("error", "Vui lòng chọn nhà cung cấp");
                } else if (receipt.getDetails().isEmpty()) {
                    req.setAttribute("error", "Vui lòng thêm ít nhất một nguyên liệu");
                } else {
                    receipt.setStaff(user);
                    receipt.setImportDate(new Date(System.currentTimeMillis()));
                    if (receiptDAO.saveReceipt(receipt)) {
                        session.removeAttribute("receipt");
                        req.setAttribute("receipt", receipt);
                        req.getRequestDispatcher("receipt.jsp").forward(req, resp);
                        return;
                    }
                    req.setAttribute("error", "Lưu phiếu nhập thất bại, vui lòng thử lại");
                }
                break;

            default: // "start": chi hien trang nhap
                break;
        }
        req.getRequestDispatcher("import.jsp").forward(req, resp);
    }

    /** Them mot dong nguyen lieu (so luong, don gia) vao phieu nhap. */
    private void addItem(HttpServletRequest req, ImportReceipt receipt) {
        Integer ingredientId = parseInt(req.getParameter("ingredientId"));
        try {
            double quantity = Double.parseDouble(req.getParameter("quantity"));
            double price = Double.parseDouble(req.getParameter("price"));
            Ingredient ingredient = ingredientId == null ? null : ingredientDAO.getById(ingredientId);
            if (ingredient == null || quantity <= 0 || price < 0) {
                req.setAttribute("error", "Dữ liệu nguyên liệu, số lượng hoặc giá không hợp lệ");
                return;
            }
            ImportReceiptDetail d = new ImportReceiptDetail();
            d.setIngredient(ingredient);
            d.setQuantity(quantity);
            d.setPrice(price);
            receipt.getDetails().add(d);
        } catch (NumberFormatException | NullPointerException e) {
            req.setAttribute("error", "Số lượng hoặc giá không hợp lệ");
        }
    }

    private String param(HttpServletRequest req, String name) {
        String v = req.getParameter(name);
        return v == null ? "" : v.trim();
    }

    private Integer parseInt(String s) {
        try {
            return Integer.valueOf(s);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
