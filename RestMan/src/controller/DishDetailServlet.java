package controller;

import dao.DishDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Dish;

/** Module 1: xem chi tiet mot mon an. */
@WebServlet("/dishDetail")
public class DishDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NumberFormatException e) {
            resp.sendRedirect("index.jsp");
            return;
        }
        Dish dish = new DishDAO().getDishById(id);
        if (dish == null) {
            resp.sendRedirect("index.jsp");
            return;
        }
        req.setAttribute("dish", dish);
        req.getRequestDispatcher("dishDetail.jsp").forward(req, resp);
    }
}
