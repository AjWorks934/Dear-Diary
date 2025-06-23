<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dear Diary</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<div class="main-container">
    <!-- Sidebar -->
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
                        <a href="viewEntries.jsp" class="menu-item">All Entries</a>
                    </li>
                    <li>
                </ul>
            </nav>
            
            <div class="sidebar-quote">
                <p>"Writing in your diary is like having a conversation with your future self."</p>
            </div>
        </div>
    </aside>

    <!-- Main Content -->
<div class="content-wrapper">

<!-- Header section - replace the header in your dashboard.jsp -->
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
        <main class="main-content">
            <div class="content-container">
                <h1 class="page-title">Welcome to Your Journey</h1>
                
                <div class="intro-card">
                    <p>Your personal space to reflect, grow, and cherish your memories. Start writing today and watch your story unfold.</p>
                </div>
                
                <h2 class="section-title">Why Keep a Diary?</h2>
                
                <div class="cards-grid">
                    <!-- Quote Card 1 -->
                    <div class="quote-card purple-card">
                        <svg xmlns="http://www.w3.org/2000/svg" class="card-icon purple-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z" />
                        </svg>
                        <p class="quote-text purple-text">"Keeping a diary is to write one's self into being. It's a way to make sense of our days and find meaning in our experiences."</p>
                        <p class="card-label purple-label">Self-Discovery</p>
                    </div>
                    
                    <!-- Quote Card 2 -->
                    <div class="quote-card indigo-card">
                        <svg xmlns="http://www.w3.org/2000/svg" class="card-icon indigo-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z" />
                        </svg>
                        <p class="quote-text indigo-text">"Your journal is a safe haven where your thoughts can flow freely without judgment. It's a sanctuary for your mind."</p>
                        <p class="card-label indigo-label">Mental Clarity</p>
                    </div>
                    
                    <!-- Quote Card 3 -->
                    <div class="quote-card blue-card">
                        <svg xmlns="http://www.w3.org/2000/svg" class="card-icon blue-icon" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        <p class="quote-text blue-text">"Today's journal entry is tomorrow's memory. Capture the moments that matter, for they become the story of your life."</p>
                        <p class="card-label blue-label">Preserving Memories</p>
                    </div>
                </div>
                
                <div class="bottom-grid">
                    <!-- Motivation Section -->
                    <div class="motivation-card">
                        <h3 class="card-title">Daily Motivation</h3>
                        <div class="motivation-list">
                            <div class="motivation-item">
                                <div class="bullet purple-bullet"></div>
                                <p>"The habit of journaling is a powerful tool for personal growth. Just a few minutes each day can lead to profound insights."</p>
                            </div>
                            <div class="motivation-item">
                                <div class="bullet indigo-bullet"></div>
                                <p>"Your diary doesn't judge. It listens. It's the perfect companion for life's journey."</p>
                            </div>
                            <div class="motivation-item">
                                <div class="bullet blue-bullet"></div>
                                <p>"Writing regularly helps you track your progress and celebrate your growth over time."</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Reassurance Section -->
                    <div class="safe-space-card">
                        <h3 class="safe-space-title">Your Safe Space</h3>
                        <p class="safe-space-text">Dear Diary is designed to be your personal sanctuary. Your entries are private and secure, allowing you to express yourself freely.</p>
                        <button class="start-btn" onclick="location.href='addEntries.jsp'">Start Writing Today</button>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
</html>