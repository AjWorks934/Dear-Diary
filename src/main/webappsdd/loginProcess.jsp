<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    // Hardcoded credentials for now
    String validUsername = "user";
    String validPassword = "password123";
    
    if (username != null && password != null) {
        if (username.equals(validUsername) && password.equals(validPassword)) {
            // Valid credentials - create session
            session.setAttribute("username", username);
            session.setMaxInactiveInterval(1800); // 30 minutes
            
            // Redirect to dashboard
            response.sendRedirect("dashboard.jsp");
        } else {
            // Invalid credentials - redirect back to login with error
            response.sendRedirect("login.jsp?error=invalid");
        }
    } else {
        // Missing parameters - redirect to login
        response.sendRedirect("login.jsp?error=missing");
    }
%>