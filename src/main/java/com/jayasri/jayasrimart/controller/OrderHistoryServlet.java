package com.jayasri.jayasrimart.controller;

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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/my-orders")
public class OrderHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Map<String, Object>> orderList = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE customer_id = ? ORDER BY id DESC";

        try (Connection conn = DBConnection.getDataSource().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getId());

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> order = new HashMap<>();
                    order.put("orderId", rs.getInt("id"));
                    order.put("totalAmount", rs.getDouble("total_amount"));
                    order.put("status", rs.getString("status"));
                    
                    // Column presence safe checks with fallbacks
                    try {
                        String cName = rs.getString("customer_name");
                        order.put("customerName", (cName != null && !cName.trim().isEmpty()) ? cName : user.getUsername());
                    } catch (SQLException e) {
                        order.put("customerName", user.getUsername());
                    }

                    try {
                        String phoneVal = rs.getString("phone");
                        order.put("phone", (phoneVal != null && !phoneVal.trim().isEmpty()) ? phoneVal : "N/A");
                    } catch (SQLException e) {
                        order.put("phone", "N/A");
                    }

                    try {
                        String addrVal = rs.getString("address");
                        order.put("address", (addrVal != null && !addrVal.trim().isEmpty()) ? addrVal : "N/A");
                    } catch (SQLException e) {
                        order.put("address", "N/A");
                    }

                    // Date parsing with fallback
                    String dateOnly = "N/A";
                    try {
                        Object dateVal = rs.getTimestamp("created_at");
                        if (dateVal != null) {
                            String tempDate = dateVal.toString();
                            dateOnly = tempDate.contains(" ") ? tempDate.split(" ")[0] : tempDate;
                        }
                    } catch (SQLException e) {
                        dateOnly = "Recent";
                    }
                    order.put("createdAt", dateOnly);

                    orderList.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}