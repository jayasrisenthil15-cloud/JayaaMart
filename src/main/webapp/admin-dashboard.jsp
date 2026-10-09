<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Security check: Ensure only authenticated ADMIN users can access this page
    com.jayasri.jayasrimart.model.User authUser = (com.jayasri.jayasrimart.model.User) session.getAttribute("user");
    if (authUser == null || !"ADMIN".equalsIgnoreCase(authUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - JayasriMart</title>
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
            font-weight: 700;
            font-size: 20px;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .user-info {
            font-size: 14px;
            font-weight: 500;
            color: #ccfbf1;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .logout-btn {
            background: #e11d48;
            color: #fff;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.3s ease;
        }
        .logout-btn:hover { background: #be123c; }

        .dashboard-container {
            max-width: 1000px;
            margin: 110px auto 40px auto;
            padding: 0 20px;
        }
        .header-section {
            margin-bottom: 30px;
        }
        .header-section h2 {
            font-size: 28px;
            font-weight: 700;
            color: #0f766e;
            margin-bottom: 8px;
        }
        .header-section p {
            font-size: 14px;
            color: #64748b;
        }
        
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 24px;
        }
        .card {
            background: #fff;
            border-radius: 12px;
            padding: 35px 30px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            border-top: 4px solid #0f766e;
        }
        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.08);
        }
        .card h4 {
            font-size: 20px;
            font-weight: 700;
            color: #0f766e;
            margin-bottom: 12px;
        }
        .card p {
            font-size: 14px;
            color: #64748b;
            line-height: 1.5;
            margin-bottom: 25px;
        }
        .card-btn {
            display: inline-block;
            text-align: center;
            background: #0f766e;
            color: #fff;
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.3s ease;
        }
        .card-btn:hover { background: #115e59; }

        @media (max-width: 768px) {
            .topbar { padding: 14px 20px; flex-direction: column; gap: 10px; align-items: flex-start; }
            .dashboard-container { margin-top: 140px; }
        }
    </style>
</head>
<body>
    <div class="topbar">
        <span>JayasriMart Admin</span>
        <div class="user-info">
            <span>Welcome, <%= authUser.getUsername() %></span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <div class="dashboard-container">
        <div class="header-section">
            <h2>Admin Dashboard</h2>
            <p>You have full control over JayasriMart catalog and orders.</p>
        </div>

        <div class="cards-grid">
            <div class="card">
                <div>
                    <h4>Product Management</h4>
                    <p>Add new products to the catalog, update prices, or manage stock levels efficiently.</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/products" class="card-btn">Manage Products</a>
            </div>

            <div class="card" style="border-top-color: #14b8a6;">
                <div>
                    <h4>Customer Orders</h4>
                    <p>View all orders placed by customers through secure checkout systems in real-time.</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/orders" class="card-btn" style="background: #14b8a6;">View Orders</a>
            </div>
        </div>
    </div>
</body>
</html>