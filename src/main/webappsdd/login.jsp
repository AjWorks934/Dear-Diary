<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is already logged in
    String loggedInUser = (String) session.getAttribute("username");
    if (loggedInUser != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    
    // Get error parameter
    String error = request.getParameter("error");
    String errorMessage = "";
    
    if ("invalid".equals(error)) {
        errorMessage = "Invalid username or password. Please try again.";
    } else if ("missing".equals(error)) {
        errorMessage = "Please enter both username and password.";
    }
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dear Diary - Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/stylelogin.css">
</head>
<body>        
        <!-- Error Message -->
        <% if (!errorMessage.isEmpty()) { %>
            <div class="error-message">
                <%= errorMessage %>
            </div>
        <% } %>
        <div class="login-container">
    	<div class="login-card">
        <h1 class="login-title">Welcome Back</h1>
        <p class="login-subtitle">Sign in to your diary</p>
        </div>
        <div class="login-box">
            <div class="login-header">
                <svg xmlns="http://www.w3.org/2000/svg" class="logo-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                </svg>
                <h1 class="login-title">Dear Diary</h1>
                <p class="login-subtitle">Welcome back to your personal space</p>
            </div>
            
            <form class="login-form" action="loginProcess.jsp" method="post">
                <div class="form-group">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" id="username" name="username" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" name="password" class="form-input"  required>
                </div>
                 <!-- Demo Credentials -->
        <div class="demo-info">
            <p><strong>Demo Credentials:</strong></p>
            <p>Username: <code>user</code></p>
            <p>Password: <code>password123</code></p>
        </div>
                <div class="form-options">
                    <label class="checkbox-label">
                        <input type="checkbox" name="remember" class="checkbox">
                        <span class="checkbox-text">Remember me</span>
                    </label>
                    <a href="#" class="forgot-link">Forgot Password?</a>
                </div>
                
                <button type="submit" class="login-btn">Sign In</button>
            </form>
            
            <div class="login-footer">
                <p class="signup-text">Don't have an account? <a href="#" class="signup-link">Sign up</a></p>
            </div>
        </div>
    </div>
</body>
</html>