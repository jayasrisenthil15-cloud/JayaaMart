package com.jayasri.jayasrimart.controller;

import com.jayasri.jayasrimart.model.CartItem;
import com.jayasri.jayasrimart.model.Product;
import com.jayasri.jayasrimart.model.User;
import com.jayasri.jayasrimart.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<CartItem> cart = getCartFromSession(session, request);

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?action=view");
            return;
        }

        request.setAttribute("cartItems", cart);
        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Form data capture
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (fullName == null || fullName.trim().isEmpty()) {
            fullName = user.getUsername();
        }

        List<CartItem> cart = getCartFromSession(session, request);

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?action=view");
            return;
        }

        double grandTotal = 0;
        for (CartItem item : cart) {
            grandTotal += item.getProduct().getPrice() * item.getQuantity();
        }

        // Phone and Address values insert query
        String orderSql = "INSERT INTO orders (customer_id, total_amount, status, customer_name, phone, address) VALUES (?, ?, ?, ?, ?, ?)";
        String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";

        int orderId = 0;

        try (Connection conn = DBConnection.getDataSource().getConnection()) {
            try (PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                orderStmt.setInt(1, user.getId());
                orderStmt.setDouble(2, grandTotal);
                orderStmt.setString(3, "CONFIRMED");
                orderStmt.setString(4, fullName);
                orderStmt.setString(5, phone);
                orderStmt.setString(6, address);
                
                orderStmt.executeUpdate();

                try (ResultSet generatedKeys = orderStmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        orderId = generatedKeys.getInt(1);
                    }
                }
            }

            if (orderId > 0) {
                try (PreparedStatement itemStmt = conn.prepareStatement(itemSql)) {
                    for (CartItem item : cart) {
                        itemStmt.setInt(1, orderId);
                        itemStmt.setInt(2, item.getProduct().getId());
                        itemStmt.setInt(3, item.getQuantity());
                        itemStmt.setDouble(4, item.getProduct().getPrice());
                        itemStmt.addBatch();
                    }
                    itemStmt.executeBatch();
                }
            }

            // Session cart clear
            if (session != null) {
                session.removeAttribute("cart");
                session.removeAttribute("cartList");
                session.removeAttribute("cartItems");
                session.removeAttribute("buyNowItem");
            }

            request.setAttribute("orderId", orderId > 0 ? orderId : "SUCCESS");
            request.getRequestDispatcher("/order-success.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/cart?action=view");
        }
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getCartFromSession(HttpSession session, HttpServletRequest request) {
        List<CartItem> cart = null;

        if (session != null) {
            cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
                cart = (List<CartItem>) session.getAttribute("cartList");
            }
            if (cart == null || cart.isEmpty()) {
                cart = (List<CartItem>) session.getAttribute("cartItems");
            }

            if (cart == null || cart.isEmpty()) {
                Map<String, Object> buyNowItem = (Map<String, Object>) session.getAttribute("buyNowItem");
                if (buyNowItem != null && !buyNowItem.isEmpty()) {
                    cart = new ArrayList<>();
                    Product p = new Product();
                    p.setId((Integer) buyNowItem.get("id"));
                    p.setName((String) buyNowItem.get("name"));
                    p.setPrice((Double) buyNowItem.get("price"));
                    
                    int qty = (Integer) buyNowItem.get("quantity");
                    cart.add(new CartItem(p, qty));
                }
            }
        }

        return cart;
    }
}