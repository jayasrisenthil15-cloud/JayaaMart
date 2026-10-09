package com.jayasri.jayasrimart.controller;

import com.jayasri.jayasrimart.dao.ProductDAO;
import com.jayasri.jayasrimart.dao.ProductDAOImpl;
import com.jayasri.jayasrimart.model.Product;
import com.jayasri.jayasrimart.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/seller/products")
public class SellerProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"SELLER".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Product> productList = productDAO.getAllProducts();
        request.setAttribute("productList", productList);
        
        // Forward to product management JSP page
        request.getRequestDispatcher("/seller-products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}