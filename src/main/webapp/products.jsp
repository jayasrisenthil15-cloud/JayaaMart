<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jayasri.jayasrimart.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Catalog - JayasriMart</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', Arial, sans-serif; }
        body {
            background: #f4f7f6;
            min-height: 100vh;
            color: #1e293b;
        }
        .topbar {
            position: fixed;
            top: 0; left: 0; right: 0;
            background: #0f766e;
            color: #fff;
            padding: 14px 32px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar-brand {
            font-size: 20px;
            font-weight: 700;
            color: #fff;
            text-decoration: none;
            letter-spacing: 0.5px;
        }
        .nav-actions {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        .nav-btn {
            background: transparent;
            color: #ccfbf1;
            border: 1.5px solid #14b8a6;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .nav-btn:hover {
            background: #14b8a6;
            color: #fff;
        }
        .nav-btn-solid {
            background: #14b8a6;
            color: #fff;
            border: 1.5px solid #14b8a6;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.3s ease;
        }
        .nav-btn-solid:hover { background: #0d9488; }

        .logout-btn {
            background: #e11d48;
            color: #fff;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.3s ease;
        }
        .logout-btn:hover { background: #be123c; }

        .user-info {
            color: #ccfbf1;
            font-size: 13px;
            font-weight: 500;
            margin-right: 5px;
        }
        .user-info b { color: #fff; }

        .main-container {
            max-width: 1200px;
            margin: 100px auto 40px auto;
            padding: 0 20px;
        }
        .page-header {
            font-size: 26px;
            font-weight: 700;
            color: #0f766e;
            margin-bottom: 20px;
        }

        /* Category Filter Bar */
        .category-filter {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            margin-bottom: 24px;
        }
        .cat-btn {
            background: #fff;
            color: #475569;
            border: 1.5px solid #cbd5e1;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        .cat-btn:hover {
            border-color: #0f766e;
            color: #0f766e;
        }
        .cat-btn.active {
            background: #0f766e;
            color: #fff;
            border-color: #0f766e;
        }

        .category-indicator {
            font-size: 14px;
            color: #64748b;
            margin-bottom: 20px;
        }
        .category-indicator strong { color: #0f766e; }

        /* Product Grid */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 24px;
        }
        .product-card {
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
            display: flex;
            flex-direction: column;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.06);
        }
        .product-img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            background: #f1f5f9;
        }
        .product-body {
            padding: 18px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        .product-title {
            font-size: 16px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 6px;
        }
        .product-desc {
            font-size: 13px;
            color: #64748b;
            margin-bottom: 12px;
            line-height: 1.4;
        }
        .product-rating {
            font-size: 12px;
            color: #d97706;
            margin-bottom: 12px;
        }
        .product-rating span { color: #64748b; }

        .product-price {
            font-size: 18px;
            font-weight: 700;
            color: #0f766e;
            margin-top: auto;
        }
        .product-stock {
            font-size: 12px;
            color: #64748b;
            margin-bottom: 14px;
        }

        .card-actions {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .btn-cart {
            background: #1e293b;
            color: #fff;
            text-align: center;
            padding: 10px;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.2s;
        }
        .btn-cart:hover { background: #0f172a; color: #fff; }

        .btn-buynow {
            background: #0f766e;
            color: #fff;
            text-align: center;
            padding: 10px;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.2s;
        }
        .btn-buynow:hover { background: #115e59; color: #fff; }

        .alert-warning-custom {
            background: #fffbeb;
            color: #b45309;
            border: 1px solid #fde68a;
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            font-weight: 600;
            grid-column: 1 / -1;
        }

        @media (max-width: 768px) {
            .topbar { padding: 12px 16px; flex-direction: column; gap: 10px; align-items: flex-start; }
            .main-container { margin-top: 150px; }
            .nav-actions { width: 100%; justify-content: flex-start; }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="topbar">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/products">JayasriMart</a>
        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/cart?action=view" class="nav-db-btn nav-btn">🛒 View Cart</a>
            
            <% 
                User user = (User) session.getAttribute("user");
                if (user != null) { 
            %>
                <a href="${pageContext.request.contextPath}/my-orders" class="nav-btn">📦 My Orders</a>

                <% if ("SELLER".equals(user.getRole()) || "ADMIN".equals(user.getRole())) { %>
                    <a href="${pageContext.request.contextPath}/admin-dashboard.jsp" class="nav-btn">Dashboard</a>
                <% } %>

                <span class="user-info">Hello, <b><%= user.getUsername() %></b> (<%= user.getRole() %>)</span>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login.jsp" class="nav-btn">Login</a>
                <a href="${pageContext.request.contextPath}/register.jsp" class="nav-btn-solid">Register</a>
            <% } %>
        </div>
    </nav>

    <div class="main-container">
        <h2 class="page-header">Our Product Catalog</h2>
        
        <!-- Category Filter Bar -->
        <div class="category-filter">
            <a href="${pageContext.request.contextPath}/products" class="cat-btn ${empty selectedCategory ? 'active' : ''}">All Products</a>
            <a href="${pageContext.request.contextPath}/products?category=Men" class="cat-btn ${selectedCategory == 'Men' ? 'active' : ''}">Men</a>
            <a href="${pageContext.request.contextPath}/products?category=Women" class="cat-btn ${selectedCategory == 'Women' ? 'active' : ''}">Women</a>
            <a href="${pageContext.request.contextPath}/products?category=Kids" class="cat-btn ${selectedCategory == 'Kids' ? 'active' : ''}">Kids</a>
            <a href="${pageContext.request.contextPath}/products?category=Groceries" class="cat-btn ${selectedCategory == 'Groceries' ? 'active' : ''}">Groceries</a>
            <a href="${pageContext.request.contextPath}/products?category=Electronics" class="cat-btn ${selectedCategory == 'Electronics' ? 'active' : ''}">Electronics</a>
        </div>

        <c:if test="${not empty selectedCategory}">
            <p class="category-indicator">Showing category: <strong>${selectedCategory}</strong></p>
        </c:if>

        <!-- Product Grid -->
        <div class="product-grid">
            <c:choose>
                <c:when test="${not empty productList}">
                    <c:forEach var="product" items="${productList}">
                        <c:set var="prodId" value="${not empty product.id ? product.id : product.productId}" />
                        
                        <div class="product-card">
                            <img src="${product.imageUrl}" class="product-img" alt="${product.name}" onerror="this.src='https://via.placeholder.com/300x180?text=JayasriMart'">
                            
                            <div class="product-body">
                                <h5 class="product-title">${product.name}</h5>
                                <p class="product-desc">${product.description}</p>
                                
                                <div class="product-rating">
                                    ★★★★☆ <span>(4.0 / 5)</span>
                                </div>

                                <div class="product-price">₹${product.price}</div>
                                <div class="product-stock">Available Stock: ${product.stock}</div>
                                
                                <div class="card-actions">
                                    <a href="${pageContext.request.contextPath}/cart?action=add&id=${prodId}" class="btn-cart">Add to Cart</a>
                                    <a href="${pageContext.request.contextPath}/buy-now?productId=${prodId}&quantity=1" class="btn-buynow">Buy Now</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="alert-warning-custom">
                        No products found in this category!
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Include Floating Chatbot Fragment -->
    <jsp:include page="/chatbot.jsp" />
</body>
</html>