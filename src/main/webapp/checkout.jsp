<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jayasri.jayasrimart.model.CartItem" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Checkout - JayasriMart</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { 
            margin: 0; 
            padding: 0; 
            box-sizing: border-box; 
            font-family: 'Plus Jakarta Sans', Arial, sans-serif; 
        }
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

        .main-container {
            max-width: 650px;
            margin: 110px auto 40px auto;
            padding: 0 20px;
        }

        .card-box {
            background: #fff;
            border-radius: 12px;
            padding: 35px 30px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            border: 1px solid #e2e8f0;
        }
        .card-box h3 {
            font-size: 22px;
            font-weight: 700;
            color: #0f766e;
            text-align: center;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #475569;
            margin-bottom: 6px;
        }
        .form-control {
            width: 100%;
            border: 1.5px solid #e2e8f0;
            border-radius: 8px;
            padding: 11px 14px;
            font-size: 14px;
            outline: none;
            background: #fafafa;
            color: #1e293b;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #0f766e;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.1);
        }
        textarea.form-control { 
            resize: vertical; 
        }

        .submit-btn {
            background: #0f766e;
            color: #fff;
            border: none;
            width: 100%;
            padding: 14px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-top: 10px;
        }
        .submit-btn:hover { 
            background: #115e59; 
        }

        @media (max-width: 768px) {
            .topbar { padding: 14px 20px; }
            .main-container { margin-top: 100px; }
            .card-box { padding: 25px 20px; }
        }
    </style>
</head>
<body>
    <div class="topbar">
        <span>JayasriMart Secure Checkout</span>
        <a href="<%= ctx %>/cart?action=view" class="nav-btn">Back to Cart</a>
    </div>

    <div class="main-container">
        <div class="card-box">
            <h3>Shipping & Payment Details</h3>
            
            <form action="<%= ctx %>/checkout" method="POST">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName" class="form-control" required placeholder="Enter your full name" value="${sessionScope.user != null ? sessionScope.user.username : ''}">
                </div>

                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" name="phone" class="form-control" required placeholder="Enter 10-digit mobile number">
                </div>

                <div class="form-group">
                    <label>Delivery Address</label>
                    <textarea name="address" class="form-control" rows="3" required placeholder="Street address, city, pincode"></textarea>
                </div>

                <div class="form-group">
                    <label>Payment Method</label>
                    <select name="paymentMethod" class="form-control">
                        <option value="COD">Cash on Delivery (COD)</option>
                    </select>
                </div>

                <button type="submit" class="submit-btn">Place Order</button>
            </form>
        </div>
    </div>
</body>
</html>