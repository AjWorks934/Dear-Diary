<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
   if (username == null) {
       response.sendRedirect("login.jsp");
       return;
   }
   
    String message = "";
    String messageType = "";
    
    // Handle form submission
    if ("POST".equals(request.getMethod())) {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String date = request.getParameter("date");        
        // Validate inputs
        if (title != null && !title.trim().isEmpty() && 
            content != null && !content.trim().isEmpty() && 
            date != null && !date.trim().isEmpty()) {
            
            // Get existing entries from session
            List<Map<String, String>> entries = (List<Map<String, String>>) session.getAttribute("diaryEntries");
            if (entries == null) {
                entries = new ArrayList<>();
            }
            
            // Create new entry
            Map<String, String> newEntry = new HashMap<>();
            newEntry.put("id", String.valueOf(System.currentTimeMillis())); // Use timestamp as ID
            newEntry.put("title", title.trim());
            newEntry.put("content", content.trim());
            newEntry.put("date", date);            
            // Add to beginning of list (newest first)
            entries.add(0, newEntry);
            
            // Save back to session
            session.setAttribute("diaryEntries", entries);
            
            message = "Entry saved successfully!";
            messageType = "success";
            
            // Clear form fields after successful submission
            title = "";
            content = "";
            date = "";
            
        } else {
            message = "Please fill in all required fields.";
            messageType = "error";
        }
    }
    
    // Get current date for default value
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String currentDate = sdf.format(new Date());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dear Diary - New Entry</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/styleAddEntries.css">
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
                <h1 class="page-title">Write New Entry</h1>
                
                <% if (!message.isEmpty()) { %>
                    <div class="<%= messageType.equals("success") ? "success-message" : "error-message" %>">
                        <%= message %>
                    </div>
                <% } %>
                
                <div class="form-container">
                    <form method="post" class="entry-form" id="entryForm">
                        <div class="form-group">
                            <label for="title" class="form-label">Entry Title *</label>
                            <input type="text" 
                                   id="title" 
                                   name="title" 
                                   class="form-input" 
                                   placeholder="Give your entry a meaningful title..."
                                   value="<%= request.getParameter("title") != null ? request.getParameter("title") : "" %>"
                                   maxlength="100"
                                   required>
                            <div id="titleCounter" class="char-counter">0/100</div>
                       
                            <label for="date" class="form-label">Date *</label>
                            <input type="date" 
                                   id="date" 
                                   name="date" 
                                   class="form-input form-date" 
                                   value="<%= request.getParameter("date") != null ? request.getParameter("date") : currentDate %>"
                                   required>
                                   
                            <label for="content" class="form-label">Your Entry *</label>
                            <textarea id="content" 
                                      name="content" 
                                      class="form-input form-textarea" 
                                      placeholder="Share your thoughts, experiences, and feelings here..."
                                      maxlength="5000"
                                      required><%= request.getParameter("content") != null ? request.getParameter("content") : "" %></textarea>
                            <div id="contentCounter" class="char-counter">0/5000</div>
                        </div>
                        
                        <div class="button-group">
                            <a href="viewEntries.jsp" class="cancel-btn">Cancel</a>
                            <button type="submit" class="submit-btn">Save Entry</button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
// Character counters
function updateCounter(inputId, counterId, maxLength) {
    const input = document.getElementById(inputId);
    const counter = document.getElementById(counterId);
    
    function update() {
        const currentLength = input.value.length;
        counter.textContent = currentLength + '/' + maxLength;
        
        // Change color based on usage
        counter.classList.remove('warning', 'danger');
        if (currentLength > maxLength * 0.8) {
            counter.classList.add('warning');
        }
        if (currentLength > maxLength * 0.95) {
            counter.classList.add('danger');
        }
    }
    
    input.addEventListener('input', update);
    update(); // Initial update
}

// Initialize counters
updateCounter('title', 'titleCounter', 100);
updateCounter('content', 'contentCounter', 5000);

// Form validation
document.getElementById('entryForm').addEventListener('submit', function(e) {
    const title = document.getElementById('title').value.trim();
    const content = document.getElementById('content').value.trim();
    const date = document.getElementById('date').value;
    
    if (!title || !content || !date) {
        e.preventDefault();
        alert('Please fill in all required fields.');
        return false;
    }
    
    if (title.length > 100 || content.length > 5000) {
        e.preventDefault();
        alert('Please check the character limits for your entry.');
        return false;
    }
});

// Auto-save draft functionality (optional)
let autoSaveTimeout;
function autoSave() {
    clearTimeout(autoSaveTimeout);
    autoSaveTimeout = setTimeout(() => {
        const title = document.getElementById('title').value;
        const content = document.getElementById('content').value;
        
        if (title || content) {
            // You can implement local storage save here if needed
            console.log('Draft auto-saved');
        }
    }, 2000);
}

document.getElementById('title').addEventListener('input', autoSave);
document.getElementById('content').addEventListener('input', autoSave);
</script>
</body>
</html>