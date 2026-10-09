<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jayasri.jayasrimart.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Success - JayasriMart</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', Arial, sans-serif; }
        body {
            background: #f4f7f6;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #1e293b;
        }
        .container-box {
            width: 100%;
            max-width: 520px;
            padding: 20px;
        }
        .card {
            background: #fff;
            border-radius: 16px;
            padding: 45px 35px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.06);
            border: 1px solid #e2e8f0;
            text-align: center;
        }
        .success-icon {
            font-size: 50px;
            margin-bottom: 15px;
        }
        .card h1 {
            font-size: 24px;
            font-weight: 700;
            color: #0f766e;
            margin-bottom: 12px;
        }
        .card p {
            font-size: 14.5px;
            color: #475569;
            line-height: 1.5;
            margin-bottom: 20px;
        }
        .order-badge {
            background: #ccfbf1;
            color: #0f766e;
            font-weight: 600;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13.5px;
            display: inline-block;
            margin-bottom: 15px;
        }
        hr {
            border: none;
            border-top: 1px solid #e2e8f0;
            margin: 20px 0;
        }
        .btn-primary-custom {
            background: #0f766e;
            color: #fff;
            border: none;
            width: 100%;
            padding: 13px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: block;
            transition: background 0.3s ease;
            margin-bottom: 12px;
        }
        .btn-primary-custom:hover { background: #115e59; }

        .btn-outline-custom {
            background: transparent;
            color: #0f766e;
            border: 1.5px solid #0f766e;
            width: 100%;
            padding: 13px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: block;
            transition: all 0.3s ease;
        }
        .btn-outline-custom:hover {
            background: #f0fdfa;
        }

        @media (max-width: 576px) {
            .card { padding: 30px 20px; }
        }
    </style>
</head>
<body>
    <div class="container-box">
        <div class="card">
            <div class="success-icon">🎉</div>
            <h1>Order Placed Successfully!</h1>
            
            <c:if test="${not empty orderId}">
                <div class="order-badge">Order ID: #${orderId}</div>
            </c:if>

            <p>Thank you for shopping with JayasriMart. Your order has been placed and confirmed successfully.</p>
            <hr>
            <a href="<%= ctx %>/products" class="btn-primary-custom">Continue Shopping</a>
            <a href="<%= ctx %>/my-orders" class="btn-outline-custom">View My Order History</a>
        </div>
    </div>
</body>
</html>