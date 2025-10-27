<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library System - Welcome</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .navbar {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .navbar h1 {
            color: white;
            font-size: 24px;
        }
        
        .navbar .nav-links {
            display: flex;
            gap: 15px;
        }
        
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.2);
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .navbar a:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }
        
        .hero {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 40px 20px;
            color: white;
        }
        
        .hero h2 {
            font-size: 48px;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .hero p {
            font-size: 20px;
            margin-bottom: 40px;
            max-width: 600px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
        }
        
        .cta-buttons {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
        }
        
        .cta-buttons a {
            padding: 15px 40px;
            background: white;
            color: #667eea;
            text-decoration: none;
            border-radius: 30px;
            font-size: 18px;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        
        .cta-buttons a:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
        }
        
        .features {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 40px 20px;
            margin-top: 40px;
        }
        
        .features h3 {
            text-align: center;
            color: white;
            font-size: 32px;
            margin-bottom: 30px;
        }
        
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .feature-card {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            color: white;
            transition: all 0.3s;
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.3);
        }
        
        .feature-card h4 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        
        .feature-card p {
            font-size: 16px;
        }
        
        @media (max-width: 768px) {
            .hero h2 {
                font-size: 32px;
            }
            
            .hero p {
                font-size: 16px;
            }
            
            .cta-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>📚 Library Management System</h1>
        <div class="nav-links">
            <a href="about.jsp">📖 About</a>
            <a href="register.jsp">📝 Register</a>
            <a href="login.jsp">🔐 Login</a>
        </div>
    </div>
    
    <div class="hero">
        <h2>📖 Welcome to Our Digital Library</h2>
        <p>Discover, manage, and explore thousands of books from the comfort of your device. Your journey to knowledge starts here!</p>
        <div class="cta-buttons">
            <a href="register.jsp">Get Started</a>
            <a href="login.jsp">Sign In</a>
        </div>
    </div>
    
    <div class="features">
        <h3>✨ Why Choose Us?</h3>
        <div class="feature-grid">
            <div class="feature-card">
                <h4>📚 Vast Collection</h4>
                <p>Access a wide range of books across multiple genres and categories</p>
            </div>
            <div class="feature-card">
                <h4>🔍 Easy Search</h4>
                <p>Find your favorite books quickly with our powerful search feature</p>
            </div>
            <div class="feature-card">
                <h4>👤 User Profiles</h4>
                <p>Manage your account and track your reading preferences</p>
            </div>
            <div class="feature-card">
                <h4>&#128274; Secure &amp; Safe</h4>
                <p>Your data is protected with industry-standard security measures</p>
            </div>
            <div class="feature-card">
                <h4>📱 Mobile Friendly</h4>
                <p>Access the library from any device, anywhere, anytime</p>
            </div>
            <div class="feature-card">
                <h4>&#9889; Fast &amp; Reliable</h4>
                <p>Enjoy smooth browsing with our optimized platform</p>
            </div>
        </div>
    </div>
</body>
</html>
