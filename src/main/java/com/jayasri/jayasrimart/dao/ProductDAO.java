package com.jayasri.jayasrimart.dao;

import com.jayasri.jayasrimart.model.Product;
import java.util.List;

public interface ProductDAO {
    boolean addProduct(Product product);
    List<Product> getAllProducts();
    List<Product> getProductsByCategory(String category);
    List<Product> getProductsBySeller(int sellerId);
    Product getProductById(int id);
    boolean updateProduct(Product product);
    boolean deleteProduct(int id);
}