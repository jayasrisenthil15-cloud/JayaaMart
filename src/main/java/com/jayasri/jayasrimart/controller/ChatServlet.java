package com.jayasri.jayasrimart.controller;

import com.google.gson.Gson;
import com.jayasri.jayasrimart.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/chat")
public class ChatServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> jsonResponse = new HashMap<>();
        try {
            StringBuilder sb = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }
            
            @SuppressWarnings("unchecked")
            Map<String, String> body = gson.fromJson(sb.toString(), Map.class);
            String userMessage = body != null ? body.get("message") : "";

            if (userMessage == null || userMessage.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("success", false);
                jsonResponse.put("data", null);
                Map<String, String> error = new HashMap<>();
                error.put("code", "VALIDATION_ERROR");
                error.put("message", "Message cannot be empty");
                jsonResponse.put("error", error);
                response.getWriter().write(gson.toJson(jsonResponse));
                return;
            }

            // Dynamic Response Generation
            String reply = generateSmartResponse(userMessage);

            jsonResponse.put("success", true);
            Map<String, String> data = new HashMap<>();
            data.put("reply", reply);
            jsonResponse.put("data", data);
            jsonResponse.put("error", null);
            response.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("success", false);
            jsonResponse.put("data", null);
            Map<String, String> error = new HashMap<>();
            error.put("code", "SERVER_ERROR");
            error.put("message", "Chatbot service temporarily unavailable.");
            jsonResponse.put("error", error);
        }
        response.getWriter().write(gson.toJson(jsonResponse));
    }

    private String generateSmartResponse(String msg) {
        String input = msg.toLowerCase().trim();

        // Greetings
        if (input.matches(".*(hi|hello|hey|greetings|good morning|good evening).*")) {
            return "Hello! 👋 Welcome to JayasriMart. How can I assist you with products or orders today?";
        }

        // Product Catalog / Search Querying Database
        if (input.contains("product") || input.contains("item") || input.contains("price") 
                || input.contains("stock") || input.contains("available") || input.contains("buy")) {
            String dbProductInfo = searchProductsInDB(input);
            if (dbProductInfo != null) {
                return dbProductInfo;
            }
            return "🛍️ You can browse our product catalog directly on the Products page and add items to your cart!";
        }
        
        // Orders & Tracking
        if (input.contains("order") || input.contains("track") || input.contains("status")) {
            return "📦 You can check all your active and past orders under the 'My Orders' tab in the top navigation bar.";
        }

        // Shipping & Delivery
        if (input.contains("shipping") || input.contains("delivery") || input.contains("time")) {
            return "🚚 JayasriMart delivers orders standard within 3 to 5 business days.";
        }

        // Returns & Refunds
        if (input.contains("return") || input.contains("refund") || input.contains("cancel")) {
            return "🔄 We offer a 7-day hassle-free return policy directly from your 'My Orders' page.";
        }

        // Payments
        if (input.contains("payment") || input.contains("pay") || input.contains("card") || input.contains("upi")) {
            return "💳 We support Credit/Debit cards, NetBanking, and UPI payments during checkout.";
        }

        // Seller queries
        if (input.contains("seller") || input.contains("vendor") || input.contains("shop")) {
            return "🏪 Registered sellers can list new products, update pricing, and manage inventory from their Seller Panel.";
        }

        // Default Fallback
        return "🤖 I'm your JayasriMart assistant! Ask me about product availability, prices, order tracking, shipping, or return policies.";
    }

    private String searchProductsInDB(String userQuery) {
        String sql = "SELECT name, price, stock FROM products LIMIT 5";
        List<String> items = new ArrayList<>();

        try (Connection conn = DBConnection.getDataSource().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                int stock = rs.getInt("stock");

                items.add("• " + name + " - ₹" + price + " (" + (stock > 0 ? stock + " in stock" : "Out of stock") + ")");
            }

            if (!items.isEmpty()) {
                return "🛍️ Here are some products from our catalog:\n" + String.join("\n", items);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}