<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nhà hàng RestMan</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <h1>Chào mừng đến nhà hàng RestMan</h1>
    <h3>Tìm kiếm món ăn</h3>
    <form action="searchDish" method="get">
        <input type="text" name="key" placeholder="Nhập tên món ăn" size="35" required>
        <button type="submit">Tìm</button>
    </form>
    <hr>
    <a href="login.jsp" class="muted">Đăng nhập nhân viên</a>
</div>
</body>
</html>
