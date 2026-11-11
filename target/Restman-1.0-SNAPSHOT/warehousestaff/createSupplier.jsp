<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.SupplierDAO, model.Supplier, java.net.URLEncoder" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    request.setCharacterEncoding("UTF-8");

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name    = request.getParameter("name");
        String address = request.getParameter("address");
        String phone   = request.getParameter("phoneNumber");
        String note    = request.getParameter("note");

        name    = name    == null ? "" : name.trim();
        address = address == null ? "" : address.trim();
        phone   = phone   == null ? "" : phone.trim();
        note    = note    == null ? "" : note.trim();

        String error = null;
        if (name.isEmpty()) {
            error = "Vui lòng nhập tên nhà cung cấp.";
        } else if (!phone.matches("[0-9+ ]{8,15}")) {
            error = "Số điện thoại không hợp lệ (8 đến 15 chữ số).";
        } else {
            Supplier s = new Supplier();
            s.setName(name);
            s.setAddress(address);
            s.setPhoneNumber(phone);
            s.setNote(note);

            if (new SupplierDAO().addSupplier(s)) {
                // Thêm xong: quay về trang tìm kiếm, điền sẵn tên vừa tạo
                response.sendRedirect("searchSupplier.jsp?key="
                        + URLEncoder.encode(name, "UTF-8"));
                return;
            }
            error = "Thêm nhà cung cấp thất bại, vui lòng thử lại.";
        }
        request.setAttribute("error", error);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm nhà cung cấp - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <header class="header">
        <h1>Nhà hàng RestMan</h1>
    </header>

    <div class="search-container">
        <h2>Thêm nhà cung cấp mới</h2>

        <c:if test="${not empty error}">
            <p class="error"><c:out value="${error}"/></p>
        </c:if>

        <form action="createSupplier.jsp" method="post"  class="create-form">
            <p>
                <label>Tên nhà cung cấp (*)</label><br>
                <input type="text" name="name" value="<c:out value='${param.name}'/>" required>
            </p>
            <p>
                <label>Địa chỉ</label><br>
                <input type="text" name="address" value="<c:out value='${param.address}'/>">
            </p>
            <p>
                <label>Số điện thoại (*)</label><br>
                <input type="text" name="phoneNumber" value="<c:out value='${param.phoneNumber}'/>" required>
            </p>
            <p>
                <label>Ghi chú</label><br>
                <input type="text" name="note" value="<c:out value='${param.note}'/>">
            </p>

            <div style="display:flex; gap:10px;">
                <a href="searchSupplier.jsp" class="btn btn-back">Back</a>
                <button type="submit" class="btn btn-search">Lưu</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
