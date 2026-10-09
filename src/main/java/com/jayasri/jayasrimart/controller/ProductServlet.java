package com.jayasri.jayasrimart.controller;

import com.jayasri.jayasrimart.dao.ProductDAO;
import com.jayasri.jayasrimart.dao.ProductDAOImpl;
import com.jayasri.jayasrimart.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        // Initialize DAO implementation safely
        try {
            productDAO = new ProductDAOImpl();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String category = request.getParameter("category");
        List<Product> productList = new ArrayList<>();

        try {
            if (productDAO == null) {
                productDAO = new ProductDAOImpl();
            }

            // Fetch products based on category filter
            if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("All")) {
                productList = productDAO.getProductsByCategory(category);
            } else {
                productList = productDAO.getAllProducts();
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Error log print aagum, aana app crash aagathu (Empty list-oda page load aagum)
        }

        // Set attributes to pass to products.jsp
        request.setAttribute("productList", productList);
        request.setAttribute("selectedCategory", category);
        
        // Forward request and response to /products.jsp view
        request.getRequestDispatcher("/products.jsp").forward(request, response);
    }
}