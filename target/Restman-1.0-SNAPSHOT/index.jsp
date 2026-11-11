<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nhà hàng RestMan</title>
    <link rel="stylesheet" href="css/style.css?v=2">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1>Nhà Hàng RestMan</h1>

            <div class="header-auth">
                <a href="login.jsp" class="btn btn-login">Đăng nhập</a>
                <a href="register.jsp" class="btn btn-register">Đăng ký</a>
            </div>
        </header>

        <main class="discover-wrap">
            <div class="discover-box">
                <h2>Khám phá thực đơn</h2>
                <p>Khám phá những món ăn hấp dẫn tại nhà hàng.</p>
                <a href="customer/searchDish.jsp" class="btn btn-search">Tìm kiếm món ăn</a>
            </div>
        </main>

        <footer>
            <p>Chào mừng bạn đến với Nhà hàng!</p>
        </footer>
    </div>
</body>
</html>