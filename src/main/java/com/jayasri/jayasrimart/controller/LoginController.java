package com.jayasri.jayasrimart.controller;

import com.jayasri.jayasrimart.model.User;
import com.jayasri.jayasrimart.service.UserService;
import com.jayasri.jayasrimart.service.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserServiceImpl();

    // 1. Browser-la irunthu neradiyaka /login nu vanthaal (GET request)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // IMPORTANT: Forwarding-ku /login.jsp mattum thaan podanum (/jayasrimart poda koodathu)
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    // 2. Login form submit aanaal (POST request)
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Input validation
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            // NOTE: sendRedirect-ku mattum context path thevai (/jayasrimart/login.jsp)
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=invalid");
            return;
        }

        // Authenticate user via service layer
        User user = userService.loginUser(email.trim(), password);
        
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());

            // Role-based redirection
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/admin-dashboard.jsp");
            } else if ("SELLER".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/seller/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/products");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=invalid");
        }
    }
}