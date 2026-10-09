<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jayasri.jayasrimart.model.User, com.jayasri.jayasrimart.model.Product, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"SELLER".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String ctx = request.getContextPath();
    @SuppressWarnings("unchecked")
    List<Product> productList = (List<Product>) request.getAttribute("productList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - JayasriMart Seller Panel</title>
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
        .page-header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 15px;
        }
        .page-header-row h2 {
            font-size: 26px;
            font-weight: 700;
            color: #0f766e;
        }
        .action-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 15px;
        }
        .back-btn {
            background: #64748b;
            color: #fff;
            padding: 9px 18px;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.3s ease;
        }
        .back-btn:hover { background: #475569; color: #fff; }

        .add-btn {
            background: #0f766e;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
            box-shadow: 0 4px 12px rgba(15, 118, 110, 0.2);
        }
        .add-btn:hover { background: #115e59; }

        .table-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            border: 1px solid #e2e8f0;
            padding: 0;
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

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(15, 23, 42, 0.6);
            z-index: 2000;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .modal-dialog {
            background: #fff;
            width: 100%;
            max-width: 500px;
            border-radius: 12px;
            box-shadow: 0 20px 35px rgba(0,0,0,0.2);
            overflow: hidden;
            animation: modalPop 0.3s ease;
        }
        @keyframes modalPop {
            from { transform: scale(0.95); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }
        .modal-header {
            background: #0f766e;
            color: #fff;
            padding: 18px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .modal-title { font-size: 18px; font-weight: 700; }
        .modal-close {
            background: none;
            border: none;
            color: #ccfbf1;
            font-size: 22px;
            cursor: pointer;
            font-weight: bold;
        }
        .modal-body { padding: 24px; }
        .form-group { margin-bottom: 18px; }
        .form-group label {
            display: block;
            font-size: 13.5px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 6px;
        }
        .form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }
        .form-control:focus { border-color: #0f766e; }
        .modal-footer {
            padding: 16px 24px;
            background: #f8fafc;
            border-top: 1px solid #e2e8f0;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        .btn-cancel {
            background: #e2e8f0;
            color: #475569;
            border: none;
            padding: 9px 18px;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            cursor: pointer;
        }
        .btn-cancel:hover { background: #cbd5e1; }
        .btn-save {
            background: #0f766e;
            color: #fff;
            border: none;
            padding: 9px 20px;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-save:hover { background: #115e59; }

        @media (max-width: 768px) {
            .topbar { padding: 14px 20px; flex-direction: column; gap: 10px; align-items: flex-start; }
            .main-container { margin-top: 140px; }
            table { font-size: 13px; }
            th, td { padding: 12px 14px; }
        }
    </style>
</head>
<body>
    <nav class="topbar">
        <a class="navbar-brand" href="<%= ctx %>/seller/dashboard">JayasriMart Seller Panel</a>
        <div class="nav-links">
            <a href="<%= ctx %>/seller/dashboard" class="nav-btn">Dashboard</a>
            <a href="<%= ctx %>/logout" class="logout-btn">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="page-header-row">
            <h2>Manage Products Catalog</h2>
        </div>

        <div class="action-row">
            <a href="<%= ctx %>/seller/dashboard" class="back-btn">&larr; Back to Dashboard</a>
            <button type="button" class="add-btn" onclick="openModal()">
                + Add New Product
            </button>
        </div>

        <div class="table-card">
            <div style="overflow-x: auto;">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (productList != null && !productList.isEmpty()) { 
                            for (Product p : productList) { %>
                        <tr>
                            <td><strong>#<%= p.getId() %></strong></td>
                            <td><%= p.getName() %></td>
                            <td><%= p.getCategory() %></td>
                            <td><strong>₹<%= p.getPrice() %></strong></td>
                            <td><%= p.getStock() %></td>
                        </tr>
                        <%   } 
                           } else { %>
                        <tr>
                            <td colspan="5" style="text-align: center; color: #64748b; padding: 30px;">No products found in catalog.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div id="addProductModal" class="modal">
        <div class="modal-dialog">
            <form action="<%= ctx %>/seller/add-product" method="POST">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Product</h5>
                    <button type="button" class="modal-close" onclick="closeModal()">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Product Name</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Category</label>
                        <input type="text" name="category" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Price (₹)</label>
                        <input type="number" step="0.01" name="price" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Stock Quantity</label>
                        <input type="number" name="stock" class="form-control" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-cancel" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn-save">Save Product</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openModal() {
            document.getElementById('addProductModal').style.display = 'flex';
        }
        function closeModal() {
            document.getElementById('addProductModal').style.display = 'none';
        }
        window.onclick = function(event) {
            const modal = document.getElementById('addProductModal');
            if (event.target === modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>