<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - JayasriMart</title>
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
        .nav-links {
            display: flex;
            align-items: center;
            gap: 12px;
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
            max-width: 1200px;
            margin: 110px auto 40px auto;
            padding: 0 20px;
        }
        .page-header {
            margin-bottom: 24px;
        }
        .page-header h2 {
            font-size: 28px;
            font-weight: 700;
            color: #0f766e;
        }

        .table-container {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 14px;
        }
        th {
            background: #f8fafc;
            color: #475569;
            font-weight: 600;
            padding: 16px 20px;
            border-bottom: 2px solid #e2e8f0;
        }
        td {
            padding: 16px 20px;
            border-bottom: 1px solid #e2e8f0;
            color: #334155;
        }
        tr:hover { background: #fafafa; }
        tr:last-child td { border-bottom: none; }

        .status-badge {
            background: #f0fdf4;
            color: #16a34a;
            border: 1px solid #bbf7d0;
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .alert-info {
            background: #f0fdfa;
            color: #0f766e;
            border: 1px solid #ccfbf1;
            padding: 35px 20px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.02);
        }
        .alert-info h4 {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 10px;
            color: #0f766e;
        }
        .alert-info p {
            font-size: 14px;
            color: #475569;
            margin-bottom: 20px;
        }
        .btn-start-shopping {
            background: #0f766e;
            color: #fff;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: background 0.3s ease;
        }
        .btn-start-shopping:hover { background: #115e59; }

        @media (max-width: 768px) {
            .topbar { padding: 14px 20px; flex-direction: column; gap: 10px; align-items: flex-start; }
            .main-container { margin-top: 140px; }
            table { font-size: 13px; }
            th, td { padding: 12px 14px; }
        }
    </style>
</head>
<body>
    <!-- Topbar Navigation -->
    <div class="topbar">
        <span>JayasriMart</span>
        <div class="nav-links">
            <a href="<%= ctx %>/products" class="nav-btn">Home</a>
            <a href="<%= ctx %>/cart?action=view" class="nav-btn">Cart</a>
            <a href="<%= ctx %>/my-orders" class="nav-btn" style="background: #14b8a6; color: #fff;">My Orders</a>
            <a href="<%= ctx %>/logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <div class="main-container">
        <div class="page-header">
            <h2>📦 My Order History</h2>
        </div>

        <c:choose>
            <c:when test="${not empty orderList}">
                <div class="table-container">
                    <div style="overflow-x: auto;">
                        <table>
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Recipient</th>
                                    <th>Phone</th>
                                    <th>Shipping Address</th>
                                    <th>Total Amount</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orderList}">
                                    <tr>
                                        <td><strong>#${order.orderId}</strong></td>
                                        <td>${order.customerName}</td>
                                        <td>${order.phone}</td>
                                        <td>${order.address}</td>
                                        <td><strong>₹${order.totalAmount}</strong></td>
                                        <td><span class="status-badge">${order.status}</span></td>
                                        <td>${order.createdAt}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert-info">
                    <h4>No Orders Found!</h4>
                    <p>You haven't placed any orders yet. Explore our products and start shopping today.</p>
                    <a href="<%= ctx %>/products" class="btn-start-shopping">Start Shopping</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>