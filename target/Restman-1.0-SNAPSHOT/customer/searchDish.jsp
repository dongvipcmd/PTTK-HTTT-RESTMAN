<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.DishDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    request.setCharacterEncoding("UTF-8");
    String keyword = request.getParameter("key");
    if (keyword != null) {
        if (keyword.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập tên món ăn");
        } else {
            request.setAttribute("dishes", new DishDAO().searchDish(keyword.trim()));
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm món ăn - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <header class="header">
        <h1>Nhà hàng RestMan</h1>
    </header>

    <div class="search-container">
        <h2>Tìm kiếm món ăn</h2>

        <c:if test="${not empty error}">
            <p class="error"><c:out value="${error}"/></p>
        </c:if>

        <form action="searchDish.jsp" method="get" class="search-form">
            <input type="text" name="key"
                   value="<c:out value='${param.key}'/>"
                   placeholder="Nhập tên món ăn">
            <button type="submit" class="btn btn-search">Tìm kiếm</button>
        </form>

        <c:if test="${param.key != null && empty error}">
            <c:choose>
                <c:when test="${not empty dishes}">
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Tên món</th>
                            <th>Giá (VNĐ)</th>
                            <th>Hình ảnh</th>
                            <th>Thao tác</th>
                        </tr>

                        <c:forEach var="d" items="${dishes}" varStatus="st">
                            <tr>
                                <td>${st.index + 1}</td>
                                <td><c:out value="${d.name}"/></td>
                                <td>
                                    <fmt:formatNumber value="${d.price}" pattern="#,##0"/>
                                </td>
                                <td>
                                    <c:if test="${not empty d.image}">
                                        <img src="${pageContext.request.contextPath}/images/<c:out value='${d.image}'/>"
                                             alt="Hình món ăn" width="100">
                                    </c:if>
                                </td>
                                <td>
                                    <a href="dishDetail.jsp?id=${d.id}">Xem chi tiết</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <p class="muted">Không tìm thấy món ăn nào chứa từ khóa này.</p>
                </c:otherwise>
            </c:choose>
        </c:if>

        <div class="back-container">
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-back">Back</a>
        </div>
    </div>
</div>
</body>
</html>