<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${empty sessionScope.user}"><c:redirect url="login.jsp"/></c:if>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nhập nguyên liệu</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <h2>Nhập nguyên liệu</h2>
    <c:if test="${not empty error}"><p class="error"><c:out value="${error}"/></p></c:if>

    <%-- BƯỚC 1: NHÀ CUNG CẤP --%>
    <div class="box">
        <h3>1. Nhà cung cấp</h3>
        <c:choose>
            <c:when test="${not empty sessionScope.receipt.supplier}">
                <p>
                    Đã chọn: <b><c:out value="${sessionScope.receipt.supplier.name}"/></b>
                    - <c:out value="${sessionScope.receipt.supplier.address}"/>
                    - <c:out value="${sessionScope.receipt.supplier.phoneNumber}"/>
                    <a href="import?action=changeSupplier">[Đổi]</a>
                </p>
            </c:when>
            <c:otherwise>
                <form action="import" method="get">
                    <input type="hidden" name="action" value="searchSupplier">
                    <input type="text" name="key" placeholder="Nhập tên nhà cung cấp" size="30">
                    <button type="submit">Tìm</button>
                </form>

                <c:if test="${not empty suppliers}">
                    <table>
                        <tr><th>Tên</th><th>Địa chỉ</th><th>SĐT</th><th></th></tr>
                        <c:forEach var="s" items="${suppliers}">
                            <tr>
                                <td><c:out value="${s.name}"/></td>
                                <td><c:out value="${s.address}"/></td>
                                <td><c:out value="${s.phoneNumber}"/></td>
                                <td><a href="import?action=selectSupplier&id=${s.id}">Chọn</a></td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>
                <c:if test="${empty suppliers && param.action == 'searchSupplier'}">
                    <p class="muted">Không tìm thấy nhà cung cấp. Hãy thêm mới bên dưới.</p>
                </c:if>

                <details <c:if test="${param.action == 'searchSupplier' && empty suppliers}">open</c:if>>
                    <summary>Thêm nhà cung cấp mới</summary>
                    <form action="import" method="post">
                        <input type="hidden" name="action" value="addSupplier">
                        <input type="text" name="name" placeholder="Tên *" required>
                        <input type="text" name="address" placeholder="Địa chỉ">
                        <input type="text" name="phone" placeholder="Số điện thoại">
                        <input type="text" name="note" placeholder="Ghi chú">
                        <button type="submit">Thêm và chọn</button>
                    </form>
                </details>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- BƯỚC 2: NGUYÊN LIỆU (chỉ hiện sau khi đã chọn NCC) --%>
    <c:if test="${not empty sessionScope.receipt.supplier}">
        <div class="box">
            <h3>2. Chọn nguyên liệu</h3>
            <form action="import" method="get">
                <input type="hidden" name="action" value="searchIngredient">
                <input type="text" name="key" placeholder="Nhập tên nguyên liệu" size="30">
                <button type="submit">Tìm</button>
            </form>

            <c:forEach var="i" items="${ingredients}">
                <form action="import" method="post" style="border-bottom:1px solid #eee; padding:4px 0">
                    <input type="hidden" name="action" value="addItem">
                    <input type="hidden" name="ingredientId" value="${i.id}">
                    <b><c:out value="${i.name}"/></b> (<c:out value="${i.massUnits}"/>)
                    &nbsp; Số lượng:
                    <input type="number" name="quantity" step="0.01" min="0.01" required style="width:90px">
                    Đơn giá:
                    <input type="number" name="price" step="1" min="0" required style="width:110px">
                    <button type="submit">Thêm vào phiếu</button>
                </form>
            </c:forEach>
            <c:if test="${empty ingredients && param.action == 'searchIngredient'}">
                <p class="muted">Không tìm thấy nguyên liệu. Hãy thêm mới bên dưới.</p>
            </c:if>

            <details <c:if test="${param.action == 'searchIngredient' && empty ingredients}">open</c:if>>
                <summary>Thêm nguyên liệu mới</summary>
                <form action="import" method="post">
                    <input type="hidden" name="action" value="addIngredient">
                    <input type="text" name="name" placeholder="Tên *" required>
                    <input type="text" name="unit" placeholder="Đơn vị (kg, bó...)">
                    <input type="text" name="note" placeholder="Ghi chú">
                    <button type="submit">Thêm</button>
                </form>
            </details>
        </div>

        <%-- BƯỚC 3: PHIẾU NHẬP HIỆN TẠI --%>
        <div class="box">
            <h3>3. Phiếu nhập hiện tại</h3>
            <c:choose>
                <c:when test="${not empty sessionScope.receipt.details}">
                    <table>
                        <tr>
                            <th>STT</th><th>Nguyên liệu</th><th>Số lượng</th>
                            <th>Đơn giá</th><th>Thành tiền</th><th></th>
                        </tr>
                        <c:forEach var="d" items="${sessionScope.receipt.details}" varStatus="st">
                            <tr>
                                <td>${st.index + 1}</td>
                                <td><c:out value="${d.ingredient.name}"/></td>
                                <td>${d.quantity} <c:out value="${d.ingredient.massUnits}"/></td>
                                <td><fmt:formatNumber value="${d.price}" pattern="#,##0"/></td>
                                <td><fmt:formatNumber value="${d.subTotal}" pattern="#,##0"/></td>
                                <td><a href="import?action=removeItem&index=${st.index}">Xóa</a></td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="4" class="right"><b>Tổng cộng</b></td>
                            <td colspan="2"><b><fmt:formatNumber value="${sessionScope.receipt.totalPrice}" pattern="#,##0"/> VNĐ</b></td>
                        </tr>
                    </table>
                    <form action="import" method="post">
                        <input type="hidden" name="action" value="confirm">
                        <button type="submit">Xác nhận &amp; thanh toán</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <p class="muted">Chưa có nguyên liệu nào trong phiếu.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <p>
        <a href="import?action=start" class="btn btn-danger">Làm lại phiếu mới</a>
        <a href="home.jsp" class="btn btn-gray">Về trang chủ</a>
    </p>
</div>
</body>
</html>
