<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jayasri.jayasrimart.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"SELLER".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard - JayasriMart</title>
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
            padding: 16px 32px;
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
            gap: 14px;
        }
        .user-welcome {
            color: #ccfbf1;
            font-size: 13.5px;
            font-weight: 500;
        }
        .user-welcome b { color: #fff; }

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

        .main-container {
            max-width: 1100px;
            margin: 110px auto 40px auto;
            padding: 0 20px;
        }
        .page-header h2 {
            font-size: 28px;
            font-weight: 700;
            color: #0f766e;
            margin-bottom: 6px;
        }
        .page-header p {
            font-size: 14.5px;
            color: #64748b;
            margin-bottom: 24px;
        }
        hr {
            border: none;
            border-top: 1px solid #e2e8f0;
            margin-bottom: 30px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
        }
        .dashboard-card {
            background: #fff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            border: 1px solid #e2e8f0;
            display: flex;
            flex-direction: column;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .dashboard-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.08);
        }
        .card-title-products {
            font-size: 20px;
            font-weight: 700;
            color: #0f766e;
            margin-bottom: 10px;
        }
        .card-title-orders {
            font-size: 20px;
            font-weight: 700;
            color: #0d9488;
            margin-bottom: 10px;
        }
        .card-desc {
            font-size: 14px;
            color: #64748b;
            line-height: 1.5;
            margin-bottom: 25px;
            flex: 1;
        }
        .card-btn-primary {
            background: #0f766e;
            color: #fff;
            text-align: center;
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.3s ease;
            display: block;
        }
        .card-btn-primary:hover { background: #115e59; color: #fff; }

        .card-btn-secondary {
            background: #14b8a6;
            color: #fff;
            text-align: center;
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.3s ease;
            display: block;
        }
        .card-btn-secondary:hover { background: #0d9488; color: #fff; }

        @media (max-width: 768px) {
            .topbar { padding: 14px 20px; flex-direction: column; gap: 10px; align-items: flex-start; }
            .main-container { margin-top: 140px; }
        }
    </style>
</head>
<body>
    <!-- Topbar Navbar -->
    <nav class="topbar">
        <a class="navbar-brand" href="<%= ctx %>/products">JayasriMart Seller Panel</a>
        <div class="nav-actions">
            <span class="user-welcome">Welcome, <b><%= user.getUsername() %></b></span>
            <a href="<%= ctx %>/logout" class="logout-btn">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header">
            <h2>Seller Dashboard</h2>
            <p>Welcome back! Here you can manage your products and view customer orders with ₹ currency support.</p>
        </div>
        <hr>

        <div class="dashboard-grid">
            <!-- Product Management Card -->
            <div class="dashboard-card">
                <h4 class="card-title-products">Product Management</h4>
                <p class="card-desc">Add new products, update pricing, or manage your inventory catalog effortlessly.</p>
                <a href="<%= ctx %>/seller/products" class="card-btn-primary">Manage Products</a>
            </div>

            <!-- Customer Orders Card -->
            <div class="dashboard-card">
                <h4 class="card-title-orders">Customer Orders</h4>
                <p class="card-desc">View all incoming customer orders, fulfillment updates, and delivery shipping details.</p>
                <a href="<%= ctx %>/seller/orders" class="card-btn-secondary">View Orders</a>
            </div>
        </div>
    </div>
</body>
</html>