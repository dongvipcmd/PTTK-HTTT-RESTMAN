<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm món ăn</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <h2>Tìm kiếm món ăn</h2>
    <form action="searchDish" method="get">
        <input type="text" name="key" value="<c:out value='${param.key}'/>" placeholder="Nhập tên món ăn" size="35" required>
        <button type="submit">Tìm</button>
    </form>

    <c:if test="${param.key != null}">
        <c:choose>
            <c:when test="${not empty dishes}">
                <table>
                    <tr>
                        <th>STT</th><th>Tên món</th><th>Giá (VNĐ)</th><th>Mô tả</th><th></th>
                    </tr>
                    <c:forEach var="d" items="${dishes}" varStatus="st">
                        <tr>
                            <td>${st.index + 1}</td>
                            <td><c:out value="${d.name}"/></td>
                            <td><fmt:formatNumber value="${d.price}" pattern="#,##0"/></td>
                            <td><c:out value="${d.note}"/></td>
                            <td><a href="dishDetail?id=${d.id}">Xem chi tiết</a></td>
                        </tr>
                    </c:forEach>
                </table>
            </c:when>
            <c:otherwise>
                <p class="muted">Không tìm thấy món ăn nào chứa từ khóa này.</p>
            </c:otherwise>
        </c:choose>
    </c:if>

    <p><a href="index.jsp">&laquo; Về trang chủ</a></p>
</div>
</body>
</html>
