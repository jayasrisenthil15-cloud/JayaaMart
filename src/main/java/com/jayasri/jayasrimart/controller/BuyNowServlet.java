package com.jayasri.jayasrimart.controller;

import com.jayasri.jayasrimart.dao.ProductDAO;
import com.jayasri.jayasrimart.dao.ProductDAOImpl;
import com.jayasri.jayasrimart.model.CartItem;
import com.jayasri.jayasrimart.model.Product;
import com.jayasri.jayasrimart.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/buy-now")
public class BuyNowServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // 1. User login check
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String productIdStr = request.getParameter("productId");
        if (productIdStr == null || productIdStr.isEmpty()) {
            productIdStr = request.getParameter("id");
        }

        String quantityStr = request.getParameter("quantity");
        int quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Integer.parseInt(quantityStr) : 1;

        if (productIdStr != null && !productIdStr.isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdStr);
                Product product = productDAO.getProductById(productId);

                if (product != null) {
                    // 2. Single item buyNowMap create panradhu
                    Map<String, Object> buyNowMap = new HashMap<>();
                    buyNowMap.put("id", product.getId());
                    buyNowMap.put("name", product.getName());
                    buyNowMap.put("price", product.getPrice());
                    buyNowMap.put("quantity", quantity);
                    buyNowMap.put("product", product);

                    session.setAttribute("buyNowItem", buyNowMap);

                    // 3. CheckoutServlet access panna 'cart' session list-um create panradhu
                    List<CartItem> buyNowCart = new ArrayList<>();
                    buyNowCart.add(new CartItem(product, quantity));
                    session.setAttribute("cart", buyNowCart);

                    // 4. Directly redirect to /checkout servlet
                    response.sendRedirect(request.getContextPath() + "/checkout");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/products");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}