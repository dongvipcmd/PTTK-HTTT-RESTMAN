<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.ImportReceipt, model.ImportReceiptDetail, java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%!
    private static final String[] DIGITS = {"không", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín"};
    private static final String[] UNITS = {"", "nghìn", "triệu", "tỷ", "nghìn tỷ", "triệu tỷ"};

    private String readThree(int n, boolean full) {
        int h = n / 100, t = (n % 100) / 10, u = n % 10;
        StringBuilder sb = new StringBuilder();

        if (h > 0 || full) {
            sb.append(DIGITS[h]).append(" trăm ");
        }
        if (t > 1) {
            sb.append(DIGITS[t]).append(" mươi ");
        } else if (t == 1) {
            sb.append("mười ");
        } else if (u > 0 && (h > 0 || full)) {
            sb.append("lẻ ");
        }
        if (u > 0) {
            if (u == 1 && t > 1) {
                sb.append("mốt ");
            } else if (u == 5 && t > 0) {
                sb.append("lăm ");
            } else {
                sb.append(DIGITS[u]).append(" ");
            }
        }
        return sb.toString();
    }

    private String numberToWords(long number) {
        if (number == 0) return "Không đồng";

        int[] groups = new int[UNITS.length];
        int count = 0;
        long tmp = number;
        while (tmp > 0 && count < groups.length) {
            groups[count++] = (int) (tmp % 1000);
            tmp /= 1000;
        }

        StringBuilder sb = new StringBuilder();
        for (int i = count - 1; i >= 0; i--) {
            if (groups[i] == 0) continue;
            boolean full = (i != count - 1);
            sb.append(readThree(groups[i], full));
            if (!UNITS[i].isEmpty()) sb.append(UNITS[i]).append(" ");
        }

        String result = sb.toString().trim().replaceAll("\\s+", " ");
        result = Character.toUpperCase(result.charAt(0)) + result.substring(1);
        return result + " đồng.";
    }
%>
<%
    ImportReceipt receipt = (ImportReceipt) session.getAttribute("lastReceipt");
    if (receipt == null) {
        response.sendRedirect("importIngredient.jsp");
        return;
    }

    List<ImportReceiptDetail> details = receipt.getDetails();

    double total = 0;
    for (ImportReceiptDetail d : details) {
        total += d.getSubTotal();
    }

    int emptyRows = Math.max(0, 15 - details.size());

    request.setAttribute("receipt", receipt);
    request.setAttribute("details", details);
    request.setAttribute("total", total);
    request.setAttribute("emptyRows", emptyRows);
    request.setAttribute("totalWords", numberToWords(Math.round(total)));
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn nhập hàng - RestMan</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style2.css">
</head>
<body>

<div class="invoice">

    <div class="top">
        <div class="left">
            <div class="store-name">RestMan</div>
            <div class="info" style="margin-top:5px;">
                <strong>Địa chỉ: Hà Đông - Hà Nội</strong> ...
            </div>
        </div>
        <div class="right">
            <p class="title">Hóa đơn nhập hàng</p>
            <div class="subtitle">Mặt hàng nhập (Nguyên liệu chế biến món ăn)</div>
        </div>
    </div>

    <div class="info-row">
        <div class="info-col">
            <div><strong>Nhân viên kho:</strong> <c:out value="${receipt.staff.name}"/></div>
            <div>Mã nhân viên: <c:out value="${'NV0'}${receipt.staff.id}"/></div>
            <div>SĐT: <c:out value="${receipt.staff.phoneNumber}"/></div>
            <div>Mã phiếu nhập: <c:out value="${'DNH-'}${receipt.id}"/></div>
        </div>
        <div class="info-col">
            <div><strong>Nhà cung cấp:</strong> <c:out value="${receipt.supplier.name}"/></div>
            <div>Địa chỉ: <c:out value="${receipt.supplier.address}"/></div>
            <div>SĐT: <c:out value="${receipt.supplier.phoneNumber}"/></div>
        </div>
    </div>

    <table class="items">
        <tr>
            <th style="width:6%">TT</th>
            <th style="width:34%">TÊN HÀNG</th>
            <th style="width:18%">SỐ LƯỢNG</th>
            <th style="width:20%">ĐƠN GIÁ</th>
            <th style="width:22%">THÀNH TIỀN</th>
        </tr>

        <c:forEach var="d" items="${details}" varStatus="st">
            <tr>
                <td class="center">${st.index + 1}</td>
                <td><c:out value="${d.ingredient.name}"/></td>
                <td class="center">
                    <fmt:formatNumber value="${d.quantity}" pattern="#,##0.##"/>
                    <c:out value="${d.ingredient.massUnits}"/>
                </td>
                <td class="right"><fmt:formatNumber value="${d.price}" pattern="#,##0"/></td>
                <td class="right"><fmt:formatNumber value="${d.subTotal}" pattern="#,##0"/></td>
            </tr>
        </c:forEach>

        <c:forEach begin="1" end="${emptyRows}" varStatus="e">
            <tr>
                <td class="center">${fn:length(details) + e.index}</td>
                <td></td>
                <td></td>
                <td></td>
                <td class="right">-</td>
            </tr>
        </c:forEach>

        <tr class="total-row">
            <td colspan="2" class="center">TỔNG CỘNG</td>
            <td class="center">-</td>
            <td></td>
            <td class="right"><fmt:formatNumber value="${total}" pattern="#,##0"/></td>
        </tr>
    </table>

    <div class="words">
        Thành tiền (viết bằng chữ): <strong><c:out value="${totalWords}"/>.</strong>
    </div>

    <div class="sign">
        <div class="col">
            <div class="date">&nbsp;</div>
            <div class="name">NGƯỜI NHẬN HÀNG</div>
            <div>(Nhân viên kho)</div>
            <div class="space"></div>
            <div><c:out value="${receipt.staff.name}"/></div>
        </div>
        <div class="col">
            <div class="date">
                Ngày <fmt:formatDate value="${receipt.importDate}" pattern="dd"/>
                tháng <fmt:formatDate value="${receipt.importDate}" pattern="MM"/>
                năm <fmt:formatDate value="${receipt.importDate}" pattern="yyyy"/>
            </div>
            <div class="name">NGƯỜI BÁN HÀNG</div>
            <div>(Nhà cung cấp)</div>
            <div class="space"></div>
            <div><c:out value="${receipt.supplier.name}"/></div>
        </div>
    </div>

</div>

<div class="buttons">
    <a href="importIngredient.jsp">Quay lại</a>
    <a href="warehousehome.jsp">In hóa đơn</a>
</div>

</body>
</html>
