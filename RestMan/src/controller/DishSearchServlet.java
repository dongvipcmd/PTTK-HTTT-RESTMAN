package controller;

import dao.DishDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** Module 1: khach hang tim mon an theo ten (khong can dang nhap). */
@WebServlet("/searchDish")
public class DishSearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String keyword = req.getParameter("key");
        if (keyword != null) {
            req.setAttribute("dishes", new DishDAO().searchDish(keyword.trim()));
        }
        req.getRequestDispatcher("searchDish.jsp").forward(req, resp);
    }
}
