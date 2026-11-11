<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${empty sessionScope.user}"><c:redirect url="login.jsp"/></c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn nhập nguyên liệu</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <h2>HÓA ĐƠN NHẬP NGUYÊN LIỆU #${receipt.id}</h2>
    <p>Ngày nhập: <fmt:formatDate value="${receipt.importDate}" pattern="dd/MM/yyyy"/></p>
    <p>Nhà cung cấp: <b><c:out value="${receipt.supplier.name}"/></b>
       - <c:out value="${receipt.supplier.address}"/></p>
    <p>Nhân viên kho: <c:out value="${receipt.staff.name}"/></p>

    <table>
        <tr><th>STT</th><th>Nguyên liệu</th><th>Số lượng</th><th>Đơn giá</th><th>Thành tiền</th></tr>
        <c:forEach var="d" items="${receipt.details}" varStatus="st">
            <tr>
                <td>${st.index + 1}</td>
                <td><c:out value="${d.ingredient.name}"/></td>
                <td>${d.quantity} <c:out value="${d.ingredient.massUnits}"/></td>
                <td><fmt:formatNumber value="${d.price}" pattern="#,##0"/></td>
                <td><fmt:formatNumber value="${d.subTotal}" pattern="#,##0"/></td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="4" class="right"><b>Tổng thanh toán</b></td>
            <td><b><fmt:formatNumber value="${receipt.totalPrice}" pattern="#,##0"/> VNĐ</b></td>
        </tr>
    </table>

    <p class="no-print">
        <button onclick="window.print()">In hóa đơn</button>
        <a href="import?action=start" class="btn">Nhập phiếu mới</a>
        <a href="home.jsp" class="btn btn-gray">Về trang chủ</a>
    </p>
</div>
</body>
</html>
