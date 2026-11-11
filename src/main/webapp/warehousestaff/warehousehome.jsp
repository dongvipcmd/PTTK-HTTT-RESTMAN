<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.user}"><c:redirect url="login.jsp"/></c:if>
<%
    session.removeAttribute("lastReceipt");
    session.removeAttribute("items");
    session.removeAttribute("supplier");
    session.removeAttribute("ingredient");
    session.removeAttribute("saveSuccess");
    session.removeAttribute("saveError");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ nhân viên kho - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <header class="header">
        <h1>Nhà hàng RestMan</h1>
    </header>

    <div class="search-container">
        <h2>Xin chào, <c:out value="${sessionScope.user.name}"/></h2>
        <p class="muted">Bạn đang đăng nhập với vai trò nhân viên kho.</p>

        <div style="margin: 20px 0;">
            <a href="searchSupplier.jsp" class="btn btn-search">Nhập nguyên liệu</a>
        </div>

        <div class="back-container">
             <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-back">Đăng xuất</a>
        </div>
        
    </div>
</div>
</body>
</html>