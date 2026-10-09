<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - JayasriMart</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', Arial, sans-serif; }
        body { background: #f4f7f6; min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
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
        }
        .reg-box {
            display: flex;
            width: 750px;
            max-width: 100%;
            background: #fff;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            border-radius: 12px;
            overflow: hidden;
            margin-top: 40px;
        }
        .left-panel {
            background: linear-gradient(135deg, #0f766e, #115e59);
            color: #fff;
            width: 42%;
            padding: 45px 35px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .left-panel h2 { font-size: 28px; font-weight: 700; margin-bottom: 12px; }
        .left-panel p { font-size: 14px; color: #ccfbf1; line-height: 1.5; margin-bottom: 35px; }
        .left-panel ul { list-style: none; }
        .left-panel li { font-size: 14px; font-weight: 500; margin-bottom: 20px; display: flex; align-items: center; }
        .left-panel li::before {
            content: "✓";
            background: #14b8a6;
            color: #fff;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            margin-right: 12px;
            flex-shrink: 0;
        }
        .right-panel { width: 58%; padding: 45px 40px; }
        .form-group { margin-bottom: 22px; position: relative; }
        .form-group input, .form-group select {
            width: 100%;
            border: 1.5px solid #e2e8f0;
            border-radius: 8px;
            padding: 14px 16px;
            font-size: 14px;
            outline: none;
            background: #fafafa;
            transition: all 0.3s ease;
        }
        .form-group input:focus, .form-group select:focus {
            border-color: #0f766e;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.1);
        }
        .form-group label {
            position: absolute;
            top: 14px;
            left: 16px;
            color: #94a3b8;
            font-size: 14px;
            pointer-events: none;
            transition: 0.3s ease;
            background: transparent;
        }
        .form-group input:focus ~ label,
        .form-group input:not(:placeholder-shown) ~ label {
            top: -9px;
            left: 12px;
            font-size: 12px;
            color: #0f766e;
            background: #fff;
            padding: 0 4px;
            font-weight: 600;
        }
        .form-group.select-group label {
            position: static;
            display: block;
            margin-bottom: 6px;
            font-size: 13px;
            color: #475569;
            font-weight: 600;
            background: none;
        }
        .alert-danger { font-size: 13px; padding: 12px 14px; border-radius: 8px; margin-bottom: 20px; background: #fef2f2; color: #dc2626; border: 1px solid #fecaca; }
        .terms { font-size: 12px; color: #64748b; margin-bottom: 20px; line-height: 1.5; }
        .terms a { color: #0f766e; text-decoration: none; font-weight: 500; }
        .terms a:hover { text-decoration: underline; }
        button.reg-btn {
            width: 100%;
            background: #0f766e;
            color: #fff;
            border: none;
            padding: 14px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        button.reg-btn:hover { background: #115e59; }
        .existing-account {
            display: block;
            text-align: center;
            margin-top: 20px;
            padding: 12px;
            border: 1.5px solid #ccfbf1;
            border-radius: 8px;
            color: #0f766e;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: background 0.3s ease;
        }
        .existing-account:hover { background: #f0fdfa; }
        @media (max-width: 768px) {
            .reg-box { flex-direction: column; width: 100%; }
            .left-panel, .right-panel { width: 100%; }
            .left-panel { padding: 30px 25px; }
            .right-panel { padding: 30px 25px; }
        }
    </style>
</head>
<body>
    <div class="topbar">JayasriMart</div>

    <div class="reg-box">
        <div class="left-panel">
            <h2>Looks like you're new here!</h2>
            <p>Sign up with your details to start shopping or selling.</p>
            <ul>
                <li>Track orders and wishlist items</li>
                <li>Personalized product recommendations</li>
                <li>Register as a seller to list items</li>
            </ul>
        </div>

        <div class="right-panel">
            <% if ("failed".equals(request.getParameter("error"))) { %>
                <div class="alert-danger">Registration failed. Email may already be registered, or a field was left blank.</div>
            <% } %>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group select-group">
                    <label for="role">Register As</label>
                    <select id="role" name="role" required>
                        <option value="CUSTOMER" selected>Customer</option>
                        <option value="SELLER">Seller</option>
                    </select>
                </div>

                <div class="form-group">
                    <input type="text" id="name" name="name" placeholder=" " required>
                    <label for="name">Full Name</label>
                </div>
                <div class="form-group">
                    <input type="email" id="email" name="email" placeholder=" " required>
                    <label for="email">Email Address</label>
                </div>
                <div class="form-group">
                    <input type="password" id="password" name="password" placeholder=" " required>
                    <label for="password">Password</label>
                </div>

                <p class="terms">By continuing, you agree to JayasriMart's <a href="#">Terms of Use</a> and <a href="#">Privacy Policy</a>.</p>

                <button type="submit" class="reg-btn">Create Account</button>
            </form>

            <a href="login.jsp" class="existing-account">Existing user? Log in</a>
        </div>
    </div>
</body>
</html>