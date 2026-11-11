<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.IngredientDAO, dao.SupplierDAO, model.Supplier, model.Member,
                model.Ingredient, model.ImportReceiptDetail, java.util.List, java.util.ArrayList,
                dao.ImportReceiptDAO, model.ImportReceipt, java.sql.Date, java.time.LocalDate" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    request.setCharacterEncoding("UTF-8");
    
    String supplierIdParam = request.getParameter("id");

    if (supplierIdParam != null) {
        try {
            int supplierId = Integer.parseInt(supplierIdParam);

            Supplier supplier = new SupplierDAO().getSupplierById(supplierId);

            session.setAttribute("supplier", supplier);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            return;
        }
    }
    
    if ("POST".equalsIgnoreCase(request.getMethod())
            && request.getParameter("quantity") != null) {

        Ingredient ingredient = (Ingredient) session.getAttribute("ingredient");
        if (ingredient == null) {
            response.sendRedirect("searchIngredient.jsp");
            return;
        }

        double quantity = Double.parseDouble(request.getParameter("quantity"));

        @SuppressWarnings("unchecked")
        List<ImportReceiptDetail> items = (List<ImportReceiptDetail>) session.getAttribute("items");
        if (items == null) {
            items = new ArrayList<>();
            session.setAttribute("items", items);
        }

        ImportReceiptDetail detail = new ImportReceiptDetail();
        detail.setIngredient(ingredient);
        detail.setQuantity(quantity);
        detail.setPrice(ingredient.getPrice());
        items.add(detail);

        session.removeAttribute("ingredient");  

        response.sendRedirect("importIngredient.jsp");
        return;
    }
    
    if (session.getAttribute("supplier") == null) {
        response.sendRedirect("searchSupplier.jsp");
        return;
    }
    
    //xóa ingredient
    if (request.getParameter("removeIndex") != null) {

        @SuppressWarnings("unchecked")
        List<ImportReceiptDetail> list = (List<ImportReceiptDetail>) session.getAttribute("items");

        try {
            int idx = Integer.parseInt(request.getParameter("removeIndex"));
            if (list != null && idx >= 0 && idx < list.size()) {
                list.remove(idx);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
       
        response.sendRedirect("importIngredient.jsp");
        return;
    }
    

    //xac nhan nhap nguyen lieu
    if ("POST".equalsIgnoreCase(request.getMethod())
            && "save".equals(request.getParameter("action"))) {

        Supplier supplier = (Supplier) session.getAttribute("supplier");

        Member staff = (Member) session.getAttribute("user");

        @SuppressWarnings("unchecked")
        List<ImportReceiptDetail> items =
                (List<ImportReceiptDetail>) session.getAttribute("items");

        if (supplier == null || staff == null || items == null || items.isEmpty()) {
            session.setAttribute("saveError",
                    "Thiếu thông tin nhà cung cấp, nhân viên hoặc nguyên liệu!");
            response.sendRedirect("importIngredient.jsp");
            return;
        }

        try {
            ImportReceipt receipt = new ImportReceipt();

            receipt.setImportDate(Date.valueOf(LocalDate.now()));
            receipt.setSupplier(supplier);
            receipt.setStaff(staff);

            // Sao chép danh sách nguyên liệu vào phiếu nhập
            receipt.getDetails().addAll(items);

            ImportReceiptDAO dao = new ImportReceiptDAO();

            if (dao.saveReceipt(receipt)) {

                // Giữ phiếu nhập vừa lưu để hiển thị và in hóa đơn
                session.setAttribute("lastReceipt", receipt);

                session.setAttribute("saveSuccess",
                        "Nhập nguyên liệu thành công!");

            } else {
                session.setAttribute("saveError",
                        "Lưu phiếu nhập thất bại!");
            }

        } catch (Exception e) {
            e.printStackTrace();

            session.setAttribute("saveError",
                    "Có lỗi xảy ra khi lưu phiếu nhập!");
        }

        response.sendRedirect("importIngredient.jsp");
        return;
    }


%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Phiếu nhập nguyên liệu - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<c:if test="${not empty sessionScope.saveSuccess}">
    <dialog id="successDialog">
        <h3>✓ <c:out value="${sessionScope.saveSuccess}"/></h3>
        <button type="button" onclick="this.closest('dialog').close()">OK</button>
    </dialog>
    <script>document.getElementById('successDialog').showModal();</script>
    <c:remove var="saveSuccess" scope="session"/>
</c:if>
<body>
<div class="container">
    <header class="header">
        <h1>Nhà hàng RestMan</h1>
    </header>

    <div class="search-container">
        <h2>Nhập nguyên liệu</h2>

        <c:if test="${not empty error}">
            <p class="error"><c:out value="${error}"/></p>
        </c:if>

        <p><strong>Nhân viên kho:</strong> <c:out value="${sessionScope.user.name}"/></p>
        <p>
            <strong>Nhà cung cấp:</strong>
            <c:out value="${sessionScope.supplier.name}"/>
            - <c:out value="${sessionScope.supplier.address}"/>
            - <c:out value="${sessionScope.supplier.phoneNumber}"/> 
        </p>

        <h3>Danh sách nguyên liệu nhập</h3>
        <c:choose>
            <c:when test="${not empty sessionScope.items}">
                <c:set var="total" value="0"/>
                <table>
                    <tr>
                        <th>STT</th>
                        <th>Nguyên liệu</th>
                        <th>Số lượng</th>
                        <th>Đơn giá</th>
                        <th>Thành tiền</th>
                        <c:if test="${empty sessionScope.lastReceipt}">
                            <th>Thao tác</th>
                        </c:if>
                    </tr>
                    <c:forEach var="d" items="${sessionScope.items}" varStatus="st">
                        <c:set var="total" value="${total + d.subTotal}"/>
                        <tr>
                            <td>${st.index + 1}</td>
                            <td><c:out value="${d.ingredient.name}"/></td>
                            <td>${d.quantity} <c:out value="${d.ingredient.massUnits}"/></td>
                            <td><fmt:formatNumber value="${d.price}" pattern="#,##0"/></td>
                            <td><fmt:formatNumber value="${d.subTotal}" pattern="#,##0"/></td>
                            <c:if test="${empty sessionScope.lastReceipt}">
                                <td>
                                    <a href="importIngredient.jsp?removeIndex=${st.index}">Xóa</a>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="4" style="text-align:left"><strong>Tổng cộng</strong></td>
                        <td colspan="2">
                            <strong><fmt:formatNumber value="${total}" pattern="#,##0"/> VNĐ</strong>
                        </td>
                    </tr>
                </table>
            </c:when>
            <c:otherwise>
                <p class="muted">Chưa có nguyên liệu nào. Bấm "Tìm kiếm nguyên liệu" để thêm.</p>
            </c:otherwise>
        </c:choose>

        <div class="import-buttons">
            
            <a href="searchIngredient.jsp" class="btn btn-search">
                Tìm kiếm nguyên liệu
            </a>

            <c:if test="${empty sessionScope.lastReceipt}">
                <c:if test="${not empty sessionScope.items}">
                    <form action="importIngredient.jsp" method="POST">
                        <input type="hidden" name="action" value="save">
                        <button type="submit" class="btn btn-search">
                            Xác nhận nhập
                        </button>
                    </form>
                </c:if>
            </c:if>

            <c:if test="${not empty sessionScope.lastReceipt}">
                <a href="viewInvoice.jsp" class="btn btn-search">In hóa đơn</a>
            </c:if>

        </div>

        <div class="back-container">
            <a href="searchSupplier.jsp" class="btn btn-back">Back</a>
        </div>
    </div>
</div>
</body>
</html>