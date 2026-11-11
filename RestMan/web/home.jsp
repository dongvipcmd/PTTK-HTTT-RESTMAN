<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.user}"><c:redirect url="login.jsp"/></c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nhân viên kho</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <h2>Xin chào, <c:out value="${sessionScope.user.name}"/> (Nhân viên kho)</h2>
    <p>
        <a href="import?action=start" class="btn">Nhập nguyên liệu</a>
        <a href="logout" class="btn btn-gray">Đăng xuất</a>
    </p>
</div>
</body>
</html>
