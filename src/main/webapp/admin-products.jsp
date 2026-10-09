<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management - JayasriMart Admin</title>
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

        .alert {
            font-size: 13px;
            padding: 14px 18px;
            border-radius: 8px;
            margin-bottom: 24px;
            font-weight: 500;
        }
        .alert-success { background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }
        .alert-warning { background: #fefce8; color: #ca8a04; border: 1px solid #fef08a; }

        .card-box {
            background: #fff;
            border-radius: 12px;
            padding: 35px 30px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            margin-bottom: 40px;
            border: 1px solid #e2e8f0;
        }
        .card-box h4 {
            font-size: 20px;
            font-weight: 700;
            color: #0f766e;
            margin-bottom: 20px;
        }

        .form-row {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }
        .form-group {
            margin-bottom: 20px;
            flex: 1;
            min-width: 200px;
            position: relative;
        }
        .form-group.col-md-4 { flex: 0 0 calc(33.333% - 14px); }
        .form-group.col-md-2 { flex: 0 0 calc(16.666% - 17px); }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #475569;
            margin-bottom: 8px;
        }
        .form-control {
            width: 100%;
            border: 1.5px solid #e2e8f0;
            border-radius: 8px;
            padding: 12px 14px;
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
        textarea.form-control { resize: vertical; }

        .submit-btn {
            background: #0f766e;
            color: #fff;
            border: none;
            padding: 12px 24px;
            font-size: 14px;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .submit-btn:hover { background: #115e59; }

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

        .btn-delete {
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
        .btn-delete:hover {
            background: #dc2626;
            color: #fff;
        }
        .text-center { text-align: center; }
        .text-muted { color: #94a3b8; padding: 30px !important; }

        @media (max-width: 768px) {
            .topbar { padding: 14px 20px; flex-direction: column; gap: 10px; align-items: flex-start; }
            .main-container { margin-top: 140px; }
            .form-group.col-md-4, .form-group.col-md-2 { flex: 100%; }
            table { font-size: 13px; }
            th, td { padding: 12px 14px; }
        }
    </style>
</head>
<body>
    <div class="topbar">
        <span>JayasriMart Admin</span>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin-dashboard.jsp" class="nav-btn">Dashboard</a>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <div class="main-container">
        <div class="page-header">
            <h2>Manage Products</h2>
        </div>

        <c:if test="${param.success == 'added'}">
            <div class="alert alert-success">Product added successfully!</div>
        </c:if>

        <c:if test="${param.success == 'deleted'}">
            <div class="alert alert-warning">Product deleted successfully!</div>
        </c:if>

        <div class="card-box">
            <h4>Add New Product</h4>
            <form action="${pageContext.request.contextPath}/admin/products" method="POST">
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label>Product Name</label>
                        <input type="text" name="name" class="form-control" required placeholder="Enter product name">
                    </div>
                    <div class="form-group col-md-4">
                        <label>Category</label>
                        <select name="category" class="form-control" required>
                            <option value="Men">Men</option>
                            <option value="Women">Women</option>
                            <option value="Kids">Kids</option>
                            <option value="Groceries">Groceries</option>
                            <option value="Electronics">Electronics</option>
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Price (₹)</label>
                        <input type="number" step="0.01" name="price" class="form-control" required placeholder="0.00">
                    </div>
                    <div class="form-group col-md-2">
                        <label>Stock</label>
                        <input type="number" name="stock" class="form-control" required placeholder="Quantity">
                    </div>
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" class="form-control" rows="2" required placeholder="Enter description"></textarea>
                </div>
                <div class="form-group">
                    <label>Image URL (Unsplash Link)</label>
                    <input type="text" name="imageUrl" class="form-control" required placeholder="https://images.unsplash.com/...">
                </div>
                <button type="submit" class="submit-btn">Add Product</button>
            </form>
        </div>

        <div class="page-header" style="margin-bottom: 16px;">
            <h4 style="font-size: 20px; font-weight: 700; color: #0f766e;">Product Catalog</h4>
        </div>

        <div class="table-container">
            <div style="overflow-x: auto;">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${productList}">
                            <tr>
                                <td><strong>#${p.id}</strong></td>
                                <td>${p.name}</td>
                                <td>${p.category}</td>
                                <td><strong>₹${p.price}</strong></td>
                                <td>${p.stock}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${p.id}" class="btn-delete" onclick="return confirm('Are you sure you want to delete this product?');">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty productList}">
                            <tr>
                                <td colspan="6" class="text-center text-muted">No products added yet.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>