<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dear Diary - Sign Up</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/stylelogin.css">
</head>
<body>        
        <div class="login-container">
        <div class="login-container">
         <%
        String error = request.getParameter("error");
        if (error != null) {%>
    <div class="error-message">
       <%
            switch (error) {
                case "1":
                    out.println("Passwords do not match! Please try again.");
                    break;
                case "3":
                    out.println("Username already exists! Choose a different username.");
                    break;
                case "5":
                    out.println("A database error occurred! Please try again later.");
                    break;
                default:
                    out.println("An unknown error occurred! Please try again.");
            }
        }
        %>
    </div>
        <div class="login-box">
            <div class="login-header">
                <svg xmlns="http://www.w3.org/2000/svg" class="logo-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                </svg>
                <h1 class="login-title">Dear Diary</h1>
                <p class="login-subtitle">Make your own personal space</p>
            </div>
            
            <form action="SignupProcess.jsp" method="post" class="login-form">
            <div class="form-group">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" class="form-input" required>
            </div>
            
            <div class="form-group">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-input" required>
            </div>
            <div class="form-group">
                <label for="Confirm password" class="form-label">Confirm Password</label>
                <input type="password" id="confirm_password" name="confirm_password" class="form-input" required>
            </div>
            
            <button type="submit" class="login-btn">Sign Up</button>
                    </form>
             <div class="login-footer">
               <p>Already have an account? <a href="login.jsp">Login here</a></p>
            </div>

        </div>
    </div>/
</body>
</html>
