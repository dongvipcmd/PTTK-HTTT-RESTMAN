<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.IngredientDAO, model.Ingredient, model.Supplier" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    request.setCharacterEncoding("UTF-8");

    Supplier supplier = (Supplier) session.getAttribute("supplier");
    if (supplier == null) {
        response.sendRedirect("searchSupplier.jsp");
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name  = request.getParameter("name");
        String unit  = request.getParameter("massUnits");
        String price = request.getParameter("price");
        String note  = request.getParameter("note");

        name  = name  == null ? "" : name.trim();
        unit  = unit  == null ? "" : unit.trim();
        price = price == null ? "" : price.trim().replace(',', '.');
        note  = note  == null ? "" : note.trim();

        double priceValue = -1;
        try {
            priceValue = Double.parseDouble(price);
        } catch (NumberFormatException e) {
            priceValue = -1;
        }

        String error = null;
        if (name.isEmpty()) {
            error = "Vui lòng nhập tên nguyên liệu.";
        } else if (unit.isEmpty()) {
            error = "Vui lòng nhập đơn vị tính.";
        } else if (Double.isNaN(priceValue) || Double.isInfinite(priceValue) || priceValue <= 0) {
            error = "Đơn giá phải là số lớn hơn 0.";
        } else {
            Ingredient ing = new Ingredient();
            ing.setName(name);
            ing.setMassUnits(unit);
            ing.setPrice(priceValue);
            ing.setNote(note);

            int newId = new IngredientDAO().addIngredient(ing);
            if (newId > 0) {
                // Thêm xong: sang luôn trang nhập số lượng cho nguyên liệu vừa tạo
                response.sendRedirect("enterQuantity.jsp?id=" + newId);
                return;
            }
            error = "Thêm nguyên liệu thất bại, vui lòng thử lại.";
        }
        request.setAttribute("error", error);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm nguyên liệu - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <header class="header">
        <h1>Nhà hàng RestMan</h1>
    </header>

    <div class="search-container">
        <h2>Thêm nguyên liệu mới</h2>

        <p class="muted">
            Nhà cung cấp:
            <strong><c:out value="${sessionScope.supplier.name}"/></strong>
        </p>

        <c:if test="${not empty error}">
            <p class="error"><c:out value="${error}"/></p>
        </c:if>

        <form action="createIngredient.jsp" method="post">
            <p>
                <label>Tên nguyên liệu (*)</label><br>
                <input type="text" name="name" value="<c:out value='${param.name}'/>" required>
            </p>
            <p>
                <label>Đơn vị tính (*)</label><br>
                <input type="text" name="massUnits" value="<c:out value='${param.massUnits}'/>"
                       placeholder="kg, lít, gói..." required>
            </p>
            <p>
                <label>Đơn giá / 1 đơn vị (*)</label><br>
                <input type="text" name="price" value="<c:out value='${param.price}'/>"
                       inputmode="decimal" required>
            </p>
            <p>
                <label>Ghi chú</label><br>
                <input type="text" name="note" value="<c:out value='${param.note}'/>">
            </p>

            <div style="display:flex; gap:10px;">
                <a href="searchIngredient.jsp" class="btn btn-back">Back</a>
                <button type="submit" class="btn btn-search">Lưu</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
