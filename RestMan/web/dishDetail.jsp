<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết món ăn</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <h2>Chi tiết món ăn</h2>
    <table>
        <tr><th style="width:150px">Tên món</th><td><c:out value="${dish.name}"/></td></tr>
        <tr><th>Giá</th><td><fmt:formatNumber value="${dish.price}" pattern="#,##0"/> VNĐ</td></tr>
        <tr><th>Mô tả</th><td><c:out value="${dish.note}"/></td></tr>
        <c:if test="${not empty dish.image}">
            <tr><th>Hình ảnh</th><td><img src="<c:out value='${dish.image}'/>" width="250" alt="Hình món ăn"></td></tr>
        </c:if>
    </table>
    <p>
        <a href="javascript:history.back()" class="btn btn-gray">&laquo; Quay lại</a>
        <a href="index.jsp" class="btn">Trang chủ</a>
    </p>
</div>
</body>
</html>
