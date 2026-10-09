<%@ page import="com.jayasri.jayasrimart.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JayasriMart - Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body { font-family: 'Plus Jakarta Sans', Arial, sans-serif; background: #f4f7f6; }
        .navbar-brand-custom { font-weight: 700; color: #0f766e !important; font-size: 24px; }
        .btn-custom-primary { background: #0f766e; color: #fff; border-color: #0f766e; }
        .btn-custom-primary:hover { background: #115e59; color: #fff; border-color: #115e59; }
        .btn-outline-custom-primary { color: #0f766e; border-color: #0f766e; }
        .btn-outline-custom-primary:hover { background: #0f766e; color: #fff; }
        .jumbotron { border-radius: 12px; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.03); }
    </style>
</head>
<body>
    <div class="container mt-4">
        <!-- Header / Navigation Section -->
        <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
            <h1 class="navbar-brand-custom">JayasriMart</h1>
            <div>
                <% 
                    User user = (User) session.getAttribute("user");
                    if (user != null) { 
                %>
                    <span class="mr-3 text-secondary">Hello, <b><%= user.getUsername() %></b> (<%= user.getRole() %>)</span>
                    <a href="logout" class="btn btn-outline-danger btn-sm">Logout</a>
                <% } else { %>
                    <a href="login.jsp" class="btn btn-outline-custom-primary btn-sm">Login</a> | 
                    <a href="register.jsp" class="btn btn-custom-primary btn-sm">Register</a>
                <% } %>
            </div>
        </div>

        <!-- Quick Navigation / Action Bar -->
        <div class="mb-4">
            <a href="products" class="btn btn-dark">Browse All Products Catalog</a>
            <c:if test="${not empty sessionScope.cart}">
                <a href="cart?action=view" class="btn btn-outline-success float-right">View Cart</a>
            </c:if>
        </div>

        <!-- Welcome Banner -->
        <div class="jumbotron bg-white text-center py-5">
            <h2 class="display-4 font-weight-bold text-dark">Your One-Stop Shop!</h2>
            <p class="lead text-muted">Explore our wide range of products across Men, Women, Kids, Groceries, and Electronics.</p>
            <hr class="my-4">
            <a class="btn btn-custom-primary btn-lg px-4" href="products" role="button">Shop Now</a>
        </div>
    </div>
</body>
</html>