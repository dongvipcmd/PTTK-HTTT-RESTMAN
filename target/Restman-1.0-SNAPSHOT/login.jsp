<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.MemberDAO, model.Member" %>
<%
    String error = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Member member = new MemberDAO().checkLogin(username, password);
        if (member == null) {
            error = "Tài khoản hoặc mật khẩu không đúng";
        } else {
            session.setAttribute("user", member);
            response.sendRedirect("warehousestaff/warehousehome.jsp");
            return;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập nhân viên - RestMan</title>
    <link rel="stylesheet" href="css/style.css">
    <style>

        .login-page {
            display: flex;
            flex-direction: column;
        }
        .login-main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px 16px;
        }
        .login-card {
            width: 100%;
            max-width: 400px;
            background: #fff;
            padding: 36px 32px;
            border-radius: 14px;
            box-shadow: 0 8px 28px rgba(0, 0, 0, 0.12);
            border-top: 5px solid #8b2e20;
        }
        .login-card h2 {
            margin: 0 0 6px;
            text-align: center;
            color: #8b2e20;
            font-size: 24px;
        }
        .login-card .subtitle {
            margin: 0 0 24px;
            text-align: center;
            color: #888;
            font-size: 14px;
        }
        .login-card label {
            display: block;
            margin-bottom: 6px;
            font-size: 14px;
            font-weight: bold;
            color: #555;
        }
        .login-card input[type="text"],
        .login-card input[type="password"] {
            width: 100%;
            padding: 12px 14px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .login-card input:focus {
            outline: none;
            border-color: #8b2e20;
            box-shadow: 0 0 0 3px rgba(139, 46, 32, 0.15);
        }
        .login-card .btn-submit {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 8px;
            background: #8b2e20;
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }
        .login-card .btn-submit:hover {
            background: #692116;
        }
        .login-card .home-link {
            display: block;
            margin-top: 18px;
            text-align: center;
            font-size: 14px;
            color: #666;
            text-decoration: none;
        }
        .login-card .home-link:hover {
            color: #8b2e20;
            text-decoration: underline;
        }
        .login-error {
            margin: 0 0 18px;
            padding: 10px 14px;
            background: #fdecea;
            border: 1px solid #f5c2bd;
            border-radius: 8px;
            color: #b3261e;
            font-size: 14px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container login-page">
    <header class="header">
        <h1>Nhà hàng RestMan</h1>
    </header>

    <div class="login-main">
        <div class="login-card">
            <h2>Đăng nhập</h2>

            <% if (error != null) { %>
                <div class="login-error"><%= error %></div>
            <% } %>

            <form action="login.jsp" method="post">
                <label for="username">Tài khoản</label>
                <input type="text" id="username" name="username"
                       placeholder="Nhập tài khoản" required autofocus>

                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password"
                       placeholder="Nhập mật khẩu" required>

                <button type="submit" class="btn-submit">Đăng nhập</button>
                <a href="index.jsp" class="home-link">Quay về trang chủ</a>
            </form>
        </div>
    </div>
</div>
</body>
</html>
