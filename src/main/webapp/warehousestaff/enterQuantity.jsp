<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.IngredientDAO, model.Ingredient" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%
    request.setCharacterEncoding("UTF-8");

    String idParam = request.getParameter("id");

    if (idParam != null) {
        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            id = 0;
        }

        Ingredient found = new IngredientDAO().getById(id);
        if (found != null) {
            session.setAttribute("ingredient", found);   
        }
    }
    // Không có nguyên liệu thì quay về trang tìm kiếm
    if (session.getAttribute("ingredient") == null) {
        response.sendRedirect("searchIngredient.jsp");
        return;
    }

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nhập số lượng - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <header class="header">
        <h1>Nhà hàng RestMan</h1>
    </header>

    <div class="search-container">
        <h2>Nhập số lượng nguyên liệu</h2>

        <c:if test="${not empty error}">
            <p class="error"><c:out value="${error}"/></p>
        </c:if>

        <form action="importIngredient.jsp" method="post">
            <p><strong>Nguyên liệu:</strong> <c:out value="${sessionScope.ingredient.name}"/></p>
            <p>
                <strong>Đơn giá:</strong>
                <fmt:formatNumber value="${sessionScope.ingredient.price}" pattern="#,##0"/> VNĐ
                / <c:out value="${sessionScope.ingredient.massUnits}"/>
            </p>
            <p>
                <label>Số lượng (<c:out value="${sessionScope.ingredient.massUnits}"/>)</label><br>
                <input type="number" name="quantity" step="any" min = "1"
                       value="<c:out value='${param.quantity}'/>" required>
            </p>
            <button type="submit" class="btn btn-search">OK</button>
        </form>

        <div class="back-container">
            <a href="searchIngredient.jsp" class="btn btn-back">Back</a>
        </div>
    </div>
</div>
</body>
</html>