<%@ page import="java.sql.*, java.util.logging.*" %>
<%@ page import="com.deardiary.DBConnection" %>

<%
// Get parameters from the request
String username = request.getParameter("username");
String password = request.getParameter("password");
String confirmPassword = request.getParameter("confirm_password");

// Logging for debugging purposes
Logger logger = Logger.getLogger("SignupProcess");

if (username != null && password != null && confirmPassword != null) {
    if (!password.equals(confirmPassword)) {
        // Passwords do not match: redirect with an error
        logger.warning("Passwords do not match for username: " + username);
        response.sendRedirect("Signup.jsp?error=1");
        return;
    }

    try (Connection conn = com.deardiary.DBConnection.getConnection()) {
        if (conn == null) {
            logger.severe("Failed to establish a database connection.");
            response.sendRedirect("Signup.jsp?error=2");
            return;
        }

        // Check if username already exists
        String checkSql = "SELECT user_id FROM Users WHERE username = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, username);

            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    // Username already exists: redirect with an error
                    logger.info("Attempted signup with an existing username: " + username);
                    response.sendRedirect("Signup.jsp?error=3");
                    return;
                }
            }
        }

        // Insert new user into the database
        String insertSql = "INSERT INTO Users (username, password) VALUES (?, ?)";
        try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
            insertStmt.setString(1, username);
            insertStmt.setString(2, password);

            int rowsAffected = insertStmt.executeUpdate();
            if (rowsAffected > 0) {
                // Successful signup: redirect to login page
                logger.info("User successfully registered: " + username);
                response.sendRedirect("login.jsp?success=1");
            } else {
                // Failed to insert: redirect with an error
                logger.warning("Failed to register user: " + username);
                response.sendRedirect("Signup.jsp?error=4");
            }
        }
    } catch (SQLException e) {
        // Handle SQL exceptions
        logger.log(Level.SEVERE, "Database error occurred during signup process.", e);
        response.sendRedirect("Signup.jsp?error=5");
    } catch (Exception e) {
        // Handle other unexpected exceptions
        logger.log(Level.SEVERE, "Unexpected error during signup process.", e);
        response.sendRedirect("Signup.jsp?error=6");
    }
} else {
    // Redirect to signup if parameters are missing
    logger.warning("Username, password, or confirmPassword not provided.");
    response.sendRedirect("signup.jsp?error=7");
}
%>
