<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - JayasriMart</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', Arial, sans-serif; }
        body {
            background: #f4f7f6;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
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
        }
        .login-box {
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
        .left-panel li {
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }
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
        .form-group { margin-bottom: 24px; position: relative; }
        .form-group input {
            width: 100%;
            border: 1.5px solid #e2e8f0;
            border-radius: 8px;
            padding: 14px 16px;
            font-size: 14px;
            outline: none;
            background: #fafafa;
            transition: all 0.3s ease;
        }
        .form-group input:focus {
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
        .alert { font-size: 13px; padding: 12px 14px; border-radius: 8px; margin-bottom: 20px; }
        .alert-danger { background: #fef2f2; color: #dc2626; border: 1px solid #fecaca; }
        .alert-success { background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }
        .terms { font-size: 12px; color: #64748b; margin-bottom: 24px; line-height: 1.5; }
        .terms a { color: #0f766e; text-decoration: none; font-weight: 500; }
        .terms a:hover { text-decoration: underline; }
        button.login-btn {
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
        button.login-btn:hover { background: #115e59; }
        .create-account {
            display: block;
            text-align: center;
            margin-top: 24px;
            padding: 12px;
            border: 1.5px solid #ccfbf1;
            border-radius: 8px;
            color: #0f766e;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: background 0.3s ease;
        }
        .create-account:hover { background: #f0fdfa; }
        @media (max-width: 768px) {
            .login-box { flex-direction: column; width: 100%; }
            .left-panel, .right-panel { width: 100%; }
            .left-panel { padding: 30px 25px; }
            .right-panel { padding: 30px 25px; }
        }
    </style>
</head>
<body>
    <div class="topbar">JayasriMart</div>

    <div class="login-box">
        <div class="left-panel">
            <h2>Welcome Back</h2>
            <p>Access your orders, saved wishlists, and personalized recommendations.</p>
            <ul>
                <li>Track shipments in real-time</li>
                <li>Tailored product suggestions</li>
                <li>Express and secure checkouts</li>
            </ul>
        </div>

        <div class="right-panel">
            <% if ("invalid".equals(request.getParameter("error"))) { %>
                <div class="alert alert-danger">Invalid email or password. Please try again.</div>
            <% } %>
            <% if ("registered".equals(request.getParameter("success"))) { %>
                <div class="alert alert-success">Registration successful! Please log in.</div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <input type="email" id="email" name="email" placeholder=" " required>
                    <label for="email">Email Address</label>
                </div>
                <div class="form-group">
                    <input type="password" id="password" name="password" placeholder=" " required>
                    <label for="password">Password</label>
                </div>

                <p class="terms">By continuing, you agree to JayasriMart's <a href="#">Terms of Use</a> and <a href="#">Privacy Policy</a>.</p>

                <button type="submit" class="login-btn">Log In</button>
            </form>

            <a href="register.jsp" class="create-account">New to JayasriMart? Create an account</a>
        </div>
    </div>
</body>
</html>