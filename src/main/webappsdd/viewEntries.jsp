<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*" %>
<%
// Check if user is logged in
   String username = (String) session.getAttribute("username");
Integer userId = (Integer) session.getAttribute("userId");
//System.out.println("Session Debug: username = " + username + ", userId = " + userId);
if (username == null || userId == null) {
    //System.out.println("Session attributes missing. Redirecting to login page.");
    response.sendRedirect("login.jsp");
    return;
} /*else {
    System.out.println("User logged in: Username - " + username + ", User ID - " + userId);
}*/

    // Get entries from database
    List<Map<String, String>> entries = new ArrayList<>();
    boolean hasEntries = false;
    System.out.println("Attempting to connect to the database...");
    
    try (Connection conn = com.deardiary.DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement("SELECT entry_id, title, content, created_at FROM diary_entries WHERE user_id = ? ORDER BY created_at DESC")) {
        //System.out.println("Executing SQL query: SELECT entry_id, title, content, entry_date FROM diary_entries WHERE user_id = " + userId);
        
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();
        
        
       //System.out.println("Fetching entries for user ID: " + userId);
while (rs.next()) {
   // System.out.println("Entry fetched from DB: Title = " + rs.getString("title") + ", Content = " + rs.getString("content") + ", Date = " + rs.getString("created_at"));
    Map<String, String> entry = new HashMap<>();
    entry.put("id", String.valueOf(rs.getInt("entry_id")));
    entry.put("title", rs.getString("title"));
    entry.put("content", rs.getString("content"));
    entry.put("date", rs.getString("created_at"));
    entries.add(entry);
}
//System.out.println("Total entries fetched: " + entries.size());

        
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    // Handle delete operation
    String deleteId = request.getParameter("delete");
    if (deleteId != null && !deleteId.isEmpty()) {
        try (Connection conn = com.deardiary.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM diary_entries WHERE entry_id = ? AND user_id = ?")) {
            
            stmt.setInt(1, Integer.parseInt(deleteId));
            stmt.setInt(2, userId);
            stmt.executeUpdate();
            //System.out.println("Request parameter for deletion: deleteId = " + deleteId);
           // System.out.println("Executing DELETE query for entry_id = " + deleteId + " and user_id = " + userId);
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("viewEntries.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dear Diary - My Entries</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
     <link rel="stylesheet" href="css/style.css">
     <link rel="stylesheet" href="css/styleViewEntries.css">
</head>
<body>
<div class="main-container">
       <aside class="sidebar">
        <div class="sidebar-content">
            <div class="sidebar-header">
                <svg xmlns="http://www.w3.org/2000/svg" class="sidebar-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                </svg>
                <h2 class="sidebar-title">My Diary</h2>
                <p class="sidebar-subtitle">Your personal space</p>
            </div>
            
            <nav class="sidebar-nav">
                <ul class="menu-list">
                    <li>
                        <a href="addEntries.jsp" class="menu-item">New Entry</a>
                    </li>
                    <li>
                        <a href="viewEntries.jsp" class="menu-item active">All Entries</a>
                    </li>
                </ul>
            </nav>
            
            <div class="sidebar-quote">
                <p>"Writing in your diary is like having a conversation with your future self."</p>
            </div>
        </div>
    </aside>

   <!-- Main Content -->
    <div class="content-wrapper">
        <!-- Header -->
        <header class="header">
            <div class="header-content">
                <!-- Logo -->
                <div class="logo-container">
                    <div class="logo-wrapper">
                        <svg xmlns="http://www.w3.org/2000/svg" class="header-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                        </svg>
                        <a href="dashboard.jsp" class="logo-text-anchor">
                        <span class="logo-text">Dear Diary</span></a>
                    </div>
                </div>
                
                <!-- User info and logout -->
                <div class="user-section">
                    <span class="welcome-text">Welcome, <%= username %></span>
                    <button class="logout-btn" onclick="location.href='logout.jsp'">
                        Logout
                    </button>
                </div>
            </div>
        </header>

        <!-- Page Content -->
        <main class="content">
            <div class="content-container">
                <h1 class="page-title">My Diary Entries</h1>
                
                <% if (entries.isEmpty()) { %>
                    <div class="empty-state">
                        <h2 class="empty-title">No entries yet</h2>
                        <p class="empty-text">Start your journaling journey by creating your first entry.</p>
                        <button class="create-btn" onclick="location.href='addEntries.jsp'">Create First Entry</button>
                    </div>
                <% } else { %>
                    <div class="entries-grid">
                        <% for (int i = 0; i < entries.size(); i++) {
                            Map<String, String> entry = entries.get(i);
                        %>
                            <div class="entry-card">
                                <div class="entry-header">
                                    <h3 class="entry-title"><%= entry.get("title") %></h3>
                                    <span class="entry-date"><%= entry.get("date") %></span>
                                </div>
                                <div class="entry-content">
                                    <p class="entry-text"><%= entry.get("content") %></p>
                                </div>
                                <div class="entry-actions">
                                    <button onclick="viewEntry(<%= i %>)" class="view-btn">View Complete</button>
                                    <form method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this entry?');">
                                        <input type="hidden" name="delete" value="<%= entry.get("id") %>">
                                        <button type="submit" class="delete-btn">Delete</button>
                                    </form>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            </div>
        </main>
    </div>
</div>

<!-- Modal for viewing complete entry -->
<div id="entryModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 id="modalTitle" class="modal-title"></h3>
            <span class="modal-close" onclick="closeModal()">&times;</span>
        </div>
        <div class="modal-body">
            <p id="modalDate" class="modal-date"></p>
            <div id="modalContent" class="modal-text"></div>
        </div>
    </div>
</div>

<script>
function viewEntry(index) {
    const entries = [
        <% for (Map<String, String> entry : entries) { %>
        {
            title: "<%= entry.get("title").replace("\"", "\\\"") %>",
            date: "<%= entry.get("date") %>",
            content: "<%= entry.get("content").replace("\"", "\\\"").replace("\n", "\\n") %>"
        }<%= (entries.indexOf(entry) < entries.size() - 1) ? "," : "" %>
        <% } %>
    ];
    
    if (entries[index]) {
        document.getElementById('modalTitle').textContent = entries[index].title;
        document.getElementById('modalDate').textContent = entries[index].date;
        document.getElementById('modalContent').innerHTML = entries[index].content.replace(/\n/g, '<br>');
        document.getElementById('entryModal').style.display = 'block';
    }
}

function closeModal() {
    document.getElementById('entryModal').style.display = 'none';
}

window.onclick = function(event) {
    const modal = document.getElementById('entryModal');
    if (event.target == modal) {
        modal.style.display = 'none';
    }
}
</script>
</body>