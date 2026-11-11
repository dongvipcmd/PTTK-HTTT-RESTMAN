<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập nhân viên</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container" style="max-width:420px">
    <h2>Đăng nhập nhân viên kho</h2>
    <c:if test="${not empty error}"><p class="error"><c:out value="${error}"/></p></c:if>
    <form action="login" method="post">
        <label>Tài khoản</label><br>
        <input type="text" name="username" required style="width:100%"><br>
        <label>Mật khẩu</label><br>
        <input type="password" name="password" required style="width:100%"><br><br>
        <button type="submit">Đăng nhập</button>
        <a href="index.jsp" class="btn btn-gray">Trang chủ</a>
    </form>
</div>
</body>
</html>
