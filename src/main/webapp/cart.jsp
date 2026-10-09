<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jayasri.jayasrimart.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - JayasriMart</title>
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
            gap: 15px;
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
            max-width: 1100px;
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

        .btn-remove {
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fecaca;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-block;
        }
        .btn-remove:hover {
            background: #dc2626;
            color: #fff;
        }

        .cart-summary {
            background: #fff;
            border-radius: 12px;
            padding: 24px 30px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            margin-top: 24px;
            border: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .cart-summary h4 {
            font-size: 20px;
            font-weight: 700;
            color: #1e293b;
        }
        .cart-summary h4 span {
            color: #0f766e;
        }

        .btn-checkout {
            background: #0f766e;
            color: #fff;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.3s ease;
            display: inline-block;
        }
        .btn-checkout:hover { background: #115e59; }

        .alert-info {
            background: #f0fdfa;
            color: #0f766e;
            border: 1px solid #ccfbf1;
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            font-weight: 600;
            font-size: 16px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.02);
        }
        .alert-info a {
            color: #0d9488;
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .topbar { padding: 14px 20px; flex-direction: column; gap: 10px; align-items: flex-start; }
            .main-container { margin-top: 140px; }
            .cart-summary { flex-direction: column; gap: 20px; align-items: flex-start; }
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
            <a href="products" class="nav-btn">Continue Shopping</a>
            <a href="logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <div class="main-container">
        <div class="page-header">
            <h2>Your Shopping Cart</h2>
        </div>

        <c:choose>
            <c:when test="${not empty sessionScope.cart}">
                <div class="table-container">
                    <div style="overflow-x: auto;">
                        <table>
                            <thead>
                                <tr>
                                    <th>Product Name</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="grandTotal" value="0" />
                                <c:forEach var="item" items="${sessionScope.cart}">
                                    <c:set var="itemTotal" value="${item.product.price * item.quantity}" />
                                    <c:set var="grandTotal" value="${grandTotal + itemTotal}" />
                                    <tr>
                                        <td><strong>${item.product.name}</strong></td>
                                        <td>₹${item.product.price}</td>
                                        <td>${item.quantity}</td>
                                        <td><strong>₹${itemTotal}</strong></td>
                                        <td>
                                            <a href="cart?action=remove&id=${item.product.id}" class="btn-remove">Remove</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="cart-summary">
                    <h4>Grand Total: <span>₹${grandTotal}</span></h4>
                    <a href="checkout" class="btn-checkout">Proceed to Checkout</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert-info">
                    Your cart is empty! <a href="products">Start shopping now</a>.
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>