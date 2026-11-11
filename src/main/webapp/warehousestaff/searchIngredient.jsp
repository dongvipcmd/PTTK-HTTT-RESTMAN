<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.IngredientDAO, model.Ingredient, model.Supplier" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%
    request.setCharacterEncoding("UTF-8");

    Supplier supplier = (Supplier) session.getAttribute("supplier");
    if (supplier == null) {
        response.sendRedirect("searchSupplier.jsp");
        return;
    }

    IngredientDAO ingredientDAO = new IngredientDAO();

    String key = request.getParameter("key");
    if (key != null) {
        if (key.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập tên nguyên liệu");
        } else {
            request.setAttribute("ingredients",
                    ingredientDAO.searchIngredientByName(key.trim(), supplier.getId()));
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm nguyên liệu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <header class="header">
        <h1>Nhà hàng RestMan</h1>
    </header>

    <div class="search-container">
        <h2>Tìm kiếm nguyên liệu</h2>

        <p class="muted">
            Nhà cung cấp:
            <strong><c:out value="${sessionScope.supplier.name}"/></strong>
        </p>

        <c:if test="${not empty error}">
            <p class="error"><c:out value="${error}"/></p>
        </c:if>

        <form action="searchIngredient.jsp" method="get" class="search-form">
            <input type="text" name="key"
                   value="<c:out value='${param.key}'/>"
                   placeholder="Nhập tên nguyên liệu">
            <button type="submit" class="btn btn-search">Tìm kiếm</button>
        </form>

        <c:if test="${param.key != null && empty error}">
            <c:choose>
                <c:when test="${not empty ingredients}">
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Tên nguyên liệu</th>
                            <th>Đơn vị</th>
                            <th>Đơn giá/1 đơn vị</th>
                            <th>Ghi chú</th>
                            <th>Thao tác</th>
                        </tr>
                        <c:forEach var="i" items="${ingredients}" varStatus="st">
                            <tr>
                                <td>${st.index + 1}</td>
                                <td><c:out value="${i.name}"/></td>
                                <td><c:out value="${i.massUnits}"/></td>
                                <td><fmt:formatNumber value="${i.price}" pattern="#,##0.##"/></td>
                                <td><c:out value="${i.note}"/></td>
                                <td><a href="enterQuantity.jsp?id=${i.id}">Chọn</a></td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <p class="muted">Không tìm thấy nguyên liệu phù hợp.</p>
                </c:otherwise>
            </c:choose>
        </c:if>

        <div class="back-container" style="display:flex; gap:10px;">
            <a href="importIngredient.jsp" class="btn btn-back">Back</a>
            <a href="createIngredient.jsp" class="btn btn-search">Thêm nguyên liệu</a>
        </div>
    </div>
</div>
</body>
</html>