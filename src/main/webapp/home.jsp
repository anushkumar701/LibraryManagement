<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.beans.RegisterBean" %>
<%
    RegisterBean user = (RegisterBean) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library System - Home</title>
    <style>
        * {margin: 0; padding: 0; box-sizing: border-box;}
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; padding: 15px 30px; display: flex;
            justify-content: space-between; align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1); flex-wrap: wrap;
        }
        .navbar h1 {font-size: 24px;}
        .navbar .user-info {display: flex; align-items: center; gap: 20px; flex-wrap: wrap;}
        .navbar a {
            color: white; text-decoration: none; padding: 8px 15px;
            border-radius: 5px; background: rgba(255,255,255,0.2);
            transition: all 0.3s;
        }
        .navbar a:hover {background: rgba(255,255,255,0.3); transform: translateY(-2px);}
        .container {max-width: 1200px; margin: 40px auto; padding: 0 20px;}
        .welcome {
            background: linear-gradient(145deg, rgba(255,255,255,0.95) 0%, rgba(248,249,250,0.95) 100%);
            padding: 50px; border-radius: 25px;
            box-shadow: 0 15px 50px rgba(0,0,0,0.2);
            margin-bottom: 30px; text-align: center;
            border: 1px solid rgba(255,255,255,0.5);
            backdrop-filter: blur(10px);
        }
        .welcome h2 {
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 15px; font-size: 42px;
            font-weight: 800;
        }
        .welcome p {color: #666; font-size: 18px; line-height: 1.6;}
        .cards {
            display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px; margin-bottom: 40px;
        }
        .card {
            background: linear-gradient(145deg, rgba(255,255,255,0.95) 0%, rgba(248,249,250,0.95) 100%);
            padding: 40px; border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            text-align: center; transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer; border: 1px solid rgba(255,255,255,0.5);
            backdrop-filter: blur(10px); position: relative; overflow: hidden;
        }
        .card::before {
            content: ''; position: absolute; top: 0; left: 0;
            width: 100%; height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }
        .card:hover {
            transform: translateY(-15px) scale(1.03);
            box-shadow: 0 20px 60px rgba(102, 126, 234, 0.4);
        }
        .card-icon {
            font-size: 50px; margin-bottom: 15px;
        }
        .card h3 {color: #333; margin-bottom: 10px; font-size: 22px;}
        .card p {color: #666; margin-bottom: 20px; font-size: 14px;}
        .card a {
            display: inline-block; padding: 14px 35px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; text-decoration: none; border-radius: 25px;
            font-weight: 700; transition: all 0.3s;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
            text-transform: uppercase; letter-spacing: 0.5px;
        }
        .card a:hover {
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 8px 30px rgba(102, 126, 234, 0.6);
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
        .about-section {
            background: linear-gradient(145deg, rgba(255,255,255,0.95) 0%, rgba(248,249,250,0.95) 100%);
            padding: 40px; border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            border: 1px solid rgba(255,255,255,0.5);
            backdrop-filter: blur(10px);
        }
        .about-section h3 {
            color: #333; margin-bottom: 20px; font-size: 28px;
            text-align: center;
        }
        .about-content {
            display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px; margin-top: 30px;
        }
        .about-item {
            padding: 25px;
            background: linear-gradient(145deg, rgba(255,255,255,0.8) 0%, rgba(248,249,250,0.8) 100%);
            border-radius: 15px;
            border-left: 5px solid;
            border-image: linear-gradient(180deg, #667eea, #764ba2) 1;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: all 0.3s;
        }
        .about-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.2);
        }
        .about-item h4 {color: #667eea; margin-bottom: 10px; font-size: 18px;}
        .about-item p {color: #666; font-size: 14px; line-height: 1.6;}
        @media (max-width: 768px) {
            .navbar {flex-direction: column; gap: 15px;}
            .welcome h2 {font-size: 28px;}
            .welcome p {font-size: 16px;}
            .cards {grid-template-columns: 1fr;}
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>📚 Library Management System</h1>
        <div class="user-info">
            <span>👋 Welcome, <%= user.getUsername() %>!</span>
            <a href="profile.jsp">👤 Profile</a>
            <a href="LogoutServlet">🚪 Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="welcome">
            <h2>📖 Welcome to Digital Library</h2>
            <p>Your gateway to knowledge and endless learning opportunities. Explore our vast collection of books!</p>
        </div>
        
        <div class="cards">
            <div class="card">
                <div class="card-icon">📚</div>
                <h3>Browse Books</h3>
                <p>Explore our extensive collection of books across various categories</p>
                <a href="books.jsp">View All Books</a>
            </div>
            
            <div class="card">
                <div class="card-icon">🔍</div>
                <h3>Search Library</h3>
                <p>Find your favorite books quickly by name or author</p>
                <a href="books.jsp">Search Now</a>
            </div>
            
            <div class="card">
                <div class="card-icon">📝</div>
                <h3>Manage Books</h3>
                <p>Add, update, or remove books from the library collection</p>
                <a href="manage-books.jsp">Manage Books</a>
            </div>
            
            <div class="card">
                <div class="card-icon">📚</div>
                <h3>My Books</h3>
                <p>View and manage your borrowed books</p>
                <a href="my-books.jsp">View My Books</a>
            </div>
            
            <div class="card">
                <div class="card-icon">👤</div>
                <h3>My Profile</h3>
                <p>View and update your personal information and settings</p>
                <a href="profile.jsp">View Profile</a>
            </div>
        </div>
        
        <div class="about-section">
            <h3>📖 About Our Library</h3>
            <div class="about-content">
                <div class="about-item">
                    <h4>🎯 Our Mission</h4>
                    <p>To provide easy access to quality educational resources and promote the love of reading in our community.</p>
                </div>
                <div class="about-item">
                    <h4>📚 Collection</h4>
                    <p>We offer a diverse collection of books spanning fiction, non-fiction, science, technology, and more.</p>
                </div>
                <div class="about-item">
                    <h4>🔒 Security</h4>
                    <p>Your data is protected with industry-standard security measures and password encryption.</p>
                </div>
                <div class="about-item">
                    <h4>📱 Accessibility</h4>
                    <p>Access our library from anywhere, anytime on any device with an internet connection.</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
