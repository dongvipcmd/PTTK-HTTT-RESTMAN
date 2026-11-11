<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.DishDAO, model.Dish" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    int id;
    try {
        id = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        response.sendRedirect("index.jsp");
        return;
    }

    Dish dish = new DishDAO().getDishById(id);
    if (dish == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    request.setAttribute("dish", dish);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết món ăn</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1>Nhà hàng RestMan</h1>
        </header>

        <div class="search-container">
            <c:choose>
                <c:when test="${not empty dish}">
                    <div class="dish-box">
                        <div class="dish-title">Thông tin món ăn</div>
                        <div class="dish-content">
                            <c:if test="${not empty dish.image}">
                                <div class="dish-image">
                                    <img src="${pageContext.request.contextPath}/images/<c:out value='${dish.image}'/>"
                                        alt="Hình món ăn">
                                </div>
                            </c:if>
                            <div class="dish-info">
                                <p><strong>Tên món:</strong> <c:out value="${dish.name}"/></p>
                                <p><strong>Giá:</strong> <fmt:formatNumber value="${dish.price}" pattern="#,##0"/> VNĐ</p>
                                <p><strong>Mô tả:</strong> <c:out value="${dish.note}"/></p>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="muted">Không tìm thấy thông tin món ăn.</p>
                </c:otherwise>
            </c:choose>

            <div class="back-container" style="margin-top: 20px;">
                <a href="javascript:history.back()" class="btn btn-back">Back</a>
            </div>
        </div>
    </div>
</body>
</html>