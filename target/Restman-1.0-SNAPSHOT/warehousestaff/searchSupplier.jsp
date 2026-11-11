<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.SupplierDAO, model.Supplier" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    request.setCharacterEncoding("UTF-8");
    SupplierDAO supplierDAO = new SupplierDAO();

    session.removeAttribute("supplier");
    session.removeAttribute("items");

    String key = request.getParameter("key");
    if (key != null) {
        if (key.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập tên nhà cung cấp");
        } else {
            request.setAttribute("suppliers", supplierDAO.searchSupplier(key.trim()));
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tìm nhà cung cấp - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <header class="header">
        <h1>Nhà hàng RestMan</h1>
    </header>

    <div class="search-container">
        <h2>Tìm kiếm nhà cung cấp</h2>

        <c:if test="${not empty error}">
            <p class="error"><c:out value="${error}"/></p>
        </c:if>

        <form action="searchSupplier.jsp" method="get" class="search-form">
            <input type="text" name="key"
                   value="<c:out value='${param.key}'/>"
                   placeholder="Nhập tên nhà cung cấp">
            <button type="submit" class="btn btn-search">Tìm kiếm</button>
        </form>

        <c:if test="${param.key != null && empty error}">
            <c:choose>
                <c:when test="${not empty suppliers}">
                    <table>
                        <tr>
                            <th>STT</th>
                            <th>Tên nhà cung cấp</th>
                            <th>Địa chỉ</th>
                            <th>Số điện thoại</th>
                            <th>Thao tác</th>
                        </tr>
                        <c:forEach var="s" items="${suppliers}" varStatus="st">
                            <tr>
                                <td>${st.index + 1}</td>
                                <td><c:out value="${s.name}"/></td>
                                <td><c:out value="${s.address}"/></td>
                                <td><c:out value="${s.phoneNumber}"/></td>
                                <td><a href="importIngredient.jsp?id=${s.id}">Chọn</a></td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <p class="muted">Không tìm thấy nhà cung cấp nào.</p>
                </c:otherwise>
            </c:choose>
        </c:if>

        <div class="back-container" style="display:flex; gap:10px;">
            <a href="warehousehome.jsp" class="btn btn-back">Back</a>
            <a href="createSupplier.jsp" class="btn btn-search">Thêm nhà cung cấp</a>
        </div>
    </div>
</div>
</body>
</html>