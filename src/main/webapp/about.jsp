<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About - Library System</title>
    <style>
        * {margin: 0; padding: 0; box-sizing: border-box;}
        body {font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5;}
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white; padding: 15px 30px; display: flex;
            justify-content: space-between; align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1); flex-wrap: wrap;
        }
        .navbar h1 {font-size: 24px;}
        .navbar .nav-links {display: flex; gap: 15px; flex-wrap: wrap;}
        .navbar a {
            color: white; text-decoration: none; padding: 8px 15px;
            border-radius: 5px; background: rgba(255,255,255,0.2); transition: all 0.3s;
        }
        .navbar a:hover {background: rgba(255,255,255,0.3);}
        .container {max-width: 1000px; margin: 40px auto; padding: 0 20px;}
        .hero {
            background: white; padding: 50px; border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; margin-bottom: 30px;
        }
        .hero h1 {color: #667eea; font-size: 42px; margin-bottom: 15px;}
        .hero p {color: #666; font-size: 18px; line-height: 1.8;}
        .features {
            display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px; margin-bottom: 30px;
        }
        .feature-card {
            background: white; padding: 35px; border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); transition: all 0.3s;
        }
        .feature-card:hover {transform: translateY(-5px); box-shadow: 0 5px 20px rgba(0,0,0,0.15);}
        .feature-icon {font-size: 48px; margin-bottom: 15px;}
        .feature-card h3 {color: #333; margin-bottom: 10px; font-size: 22px;}
        .feature-card p {color: #666; line-height: 1.6;}
        .mission {
            background: white; padding: 40px; border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .mission h2 {color: #667eea; margin-bottom: 20px; font-size: 32px; text-align: center;}
        .mission p {color: #666; font-size: 16px; line-height: 1.8; text-align: center; max-width: 800px; margin: 0 auto;}
    </style>
</head>
<body>
    <div class="navbar">
        <h1>📚 Library Management System</h1>
        <div class="nav-links">
            <a href="index.jsp">🏠 Home</a>
            <a href="register.jsp">📝 Register</a>
            <a href="login.jsp">🔐 Login</a>
        </div>
    </div>
    
    <div class="container">
        <div class="hero">
            <h1>📖 About Our Library</h1>
            <p>A modern digital library management system designed to make book management and discovery simple, efficient, and enjoyable for everyone.</p>
        </div>
        
        <div class="features">
            <div class="feature-card">
                <div class="feature-icon">🎯</div>
                <h3>Our Mission</h3>
                <p>To democratize access to knowledge by providing a user-friendly platform for managing and discovering books across various genres and categories.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">🌟</div>
                <h3>Our Vision</h3>
                <p>To become the leading digital library platform that connects readers with books and promotes lifelong learning and literary exploration.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">💡</div>
                <h3>Innovation</h3>
                <p>We leverage modern technology to create an intuitive, responsive, and secure platform that works seamlessly across all devices.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">🔒</div>
                <h3>Security First</h3>
                <p>Your data security is our priority. We implement industry-standard encryption and security measures to protect your information.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">🚀</div>
                <h3>Performance</h3>
                <p>Built with efficiency in mind, our system delivers fast search results and smooth navigation for the best user experience.</p>
            </div>
            
            <div class="feature-card">
                <div class="feature-icon">🤝</div>
                <h3>Community</h3>
                <p>We believe in building a community of readers and learners who share a passion for knowledge and continuous growth.</p>
            </div>
        </div>
        
        <div class="mission">
            <h2>🌍 Our Impact</h2>
            <p>
                Since our inception, we've been committed to making quality literature accessible to everyone. 
                Our platform serves readers of all ages and backgrounds, providing them with tools to discover, 
                manage, and enjoy books in a digital environment. We continue to evolve and improve our services 
                based on user feedback and emerging technologies, ensuring that we remain at the forefront of 
                digital library management solutions.
            </p>
        </div>
    </div>
</body>
</html>
