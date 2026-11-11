package controller;

import dao.MemberDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Member;

/** Dang nhap cho nhan vien kho. */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Member member = new MemberDAO().checkLogin(username, password);
        if (member == null) {
            req.setAttribute("error", "Sai tài khoản hoặc mật khẩu, hoặc bạn không phải nhân viên kho");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }
        req.getSession().setAttribute("user", member);
        resp.sendRedirect("home.jsp");
    }
}
