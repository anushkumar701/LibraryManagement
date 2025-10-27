<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library System - Login</title>
    <style>
        * {margin: 0; padding: 0; box-sizing: border-box;}
        
        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }
        
        /* Animated Background Circles */
        body::before, body::after {
            content: '';
            position: absolute;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
            animation: float 8s ease-in-out infinite;
        }
        
        body::before {
            width: 300px;
            height: 300px;
            top: -100px;
            left: -100px;
            animation-delay: 0s;
        }
        
        body::after {
            width: 400px;
            height: 400px;
            bottom: -150px;
            right: -150px;
            animation-delay: 2s;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0) scale(1); }
            50% { transform: translateY(-30px) scale(1.1); }
        }
        
        .container {
            background: linear-gradient(145deg, rgba(255,255,255,0.95), rgba(248,249,250,0.95));
            backdrop-filter: blur(20px);
            padding: 50px 40px;
            border-radius: 30px;
            box-shadow: 0 30px 80px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 450px;
            border: 1px solid rgba(255,255,255,0.5);
            animation: slideUp 0.8s ease;
            position: relative;
            z-index: 10;
        }
        
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(50px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .logo {
            text-align: center;
            margin-bottom: 30px;
            animation: bounce 1s ease;
        }
        
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        
        .logo-icon {
            font-size: 60px;
            margin-bottom: 10px;
            display: inline-block;
            animation: rotate 3s linear infinite;
        }
        
        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        h2 {
            text-align: center;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 35px;
            font-size: 32px;
            font-weight: 900;
        }
        
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 600;
            font-size: 14px;
        }
        
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid rgba(102, 126, 234, 0.2);
            border-radius: 15px;
            font-size: 15px;
            transition: all 0.3s;
            background: rgba(255,255,255,0.8);
        }
        
        input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 5px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }
        
        .btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 15px;
            font-size: 17px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 10px;
            transition: all 0.4s;
            box-shadow: 0 8px 30px rgba(102, 126, 234, 0.5);
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
        }
        
        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }
        
        .btn:hover::before {
            left: 100%;
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 50px rgba(102, 126, 234, 0.7);
        }
        
        .btn:active {
            transform: translateY(0);
        }
        
        .error, .success {
            padding: 15px 20px;
            border-radius: 15px;
            margin-bottom: 25px;
            text-align: center;
            animation: shake 0.5s;
            font-weight: 600;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
        
        .error {
            background: linear-gradient(135deg, #fee, #fdd);
            color: #c33;
            border: 2px solid #fcc;
            box-shadow: 0 5px 20px rgba(204, 51, 51, 0.2);
        }
        
        .success {
            background: linear-gradient(135deg, #dfd, #cfc);
            color: #2a6;
            border: 2px solid #8d8;
            box-shadow: 0 5px 20px rgba(34, 170, 102, 0.2);
        }
        
        .success .password-display {
            background: rgba(255,255,255,0.8);
            padding: 15px;
            border-radius: 10px;
            margin-top: 10px;
            font-family: 'Courier New', monospace;
            font-size: 18px;
            color: #ff6600;
            font-weight: 900;
            letter-spacing: 2px;
            box-shadow: inset 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .signup-link {
            text-align: center;
            margin-top: 25px;
            color: #666;
        }
        
        .signup-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 700;
            transition: all 0.3s;
        }
        
        .signup-link a:hover {
            color: #764ba2;
            text-decoration: underline;
        }
        
        .back-home {
            text-align: center;
            margin-bottom: 25px;
        }
        
        .back-home a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s;
        }
        
        .back-home a:hover {
            transform: translateX(-5px);
            color: #764ba2;
        }
        
        @media (max-width: 480px) {
            .container {padding: 40px 25px;}
            h2 {font-size: 26px;}
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="back-home">
            <a href="index.jsp">← Back to Home</a>
        </div>
        
        <div class="logo">
            <div class="logo-icon">📚</div>
            <h2>Library Login</h2>
        </div>
        
        <% 
            String error = request.getParameter("error");
            String registered = request.getParameter("registered");
            
            if(error != null) {
                String errorMsg = "";
                switch(error) {
                    case "1":
                        errorMsg = "❌ Invalid username or password!";
                        break;
                    case "session_expired":
                        errorMsg = "⏰ Session expired! Please login again.";
                        break;
                    default:
                        errorMsg = "❌ Login failed! Please try again.";
                }
        %>
            <div id="msg" class="error"><%= errorMsg %></div>
        <% } %>
        
        <% if(registered != null && registered.equals("true")) { 
            String generatedPassword = (String) session.getAttribute("generatedPassword");
            String username = (String) session.getAttribute("registeredUsername");
        %>
            <div id="successMsg" class="success">
                ✅ Registration Successful!<br>
                <% if(generatedPassword != null) { %>
                    <strong style="display: block; margin-top: 12px;">Your Auto-Generated Password:</strong>
                    <div class="password-display"><%= generatedPassword %></div>
                    <small style="display: block; margin-top: 8px; color: #666;">Save this password securely!</small>
                <% } %>
            </div>
        <% } %>
        
        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label for="username">👤 Username</label>
                <% 
                    String prefillUsername = (String) session.getAttribute("registeredUsername");
                    if(prefillUsername == null) prefillUsername = "";
                %>
                <input type="text" id="username" name="username" required 
                       placeholder="Enter your username" value="<%= prefillUsername %>">
            </div>
            
            <div class="form-group">
                <label for="password">🔒 Password</label>
                <input type="password" id="password" name="password" required 
                       placeholder="Enter your password">
            </div>
            
            <button type="submit" class="btn">🚀 Login Now</button>
        </form>
        
        <div class="signup-link">
            Don't have an account? <a href="register.jsp">Create one here</a>
        </div>
    </div>
    
    <script>
        window.addEventListener('DOMContentLoaded', () => {
            const msg = document.getElementById('msg');
            if (msg) {
                setTimeout(() => msg.style.display = 'none', 5000);
            }
            
            const successMsg = document.getElementById('successMsg');
            if (successMsg) {
                setTimeout(() => successMsg.style.display = 'none', 10000);
            }
        });
    </script>
</body>
</html>
