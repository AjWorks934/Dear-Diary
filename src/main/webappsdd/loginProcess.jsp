<%@ page import="java.sql.*, java.util.logging.*" %>
<%@ page import="com.deardiary.DBConnection" %>

<%
// Get parameters from the request
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Logging for debugging purposes
    Logger logger = Logger.getLogger("LoginProcess");

    if (username != null && password != null) {
        try (Connection conn = com.deardiary.DBConnection.getConnection()) {
            if (conn == null) {
                logger.severe("Failed to establish a database connection.");
                response.sendRedirect("login.jsp?error=2");
                return;
            }

            // Prepare SQL query to check credentials
            String sql = "SELECT user_id FROM Users WHERE username = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, password);

                // Execute the query
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // Successful login: set session attributes and redirect
                        session.setAttribute("userId", rs.getInt("user_id"));
                        session.setAttribute("username", username);
                        response.sendRedirect("dashboard.jsp");
                    } else {
                        // Invalid credentials: redirect to login with error
                        logger.info("Invalid credentials for username: " + username);
                        response.sendRedirect("login.jsp?error=1");
                    }
                }
            }
        } catch (SQLException e) {
            // Handle SQL exceptions
            logger.log(Level.SEVERE, "Database error occurred during login process.", e);
            response.sendRedirect("login.jsp?error=3");
        } catch (Exception e) {
            // Handle other unexpected exceptions
            logger.log(Level.SEVERE, "Unexpected error during login process.", e);
            response.sendRedirect("login.jsp?error=4");
        }
    } else {
        // Redirect to login if parameters are missing
        logger.warning("Username or password not provided.");
        response.sendRedirect("login.jsp?error=5");
    }
%>
