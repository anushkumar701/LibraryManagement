<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.beans.RegisterBean" %>
<%
    RegisterBean user = (RegisterBean) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String message = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
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
        .navbar .user-info {display: flex; align-items: center; gap: 20px; flex-wrap: wrap;}
        .navbar a {
            color: white; text-decoration: none; padding: 8px 15px;
            border-radius: 5px; background: rgba(255,255,255,0.2); transition: all 0.3s;
        }
        .navbar a:hover {background: rgba(255,255,255,0.3); transform: translateY(-2px);}
        .container {max-width: 800px; margin: 40px auto; padding: 0 20px;}
        .profile-header {
            background: white; padding: 30px; border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 20px;
            text-align: center;
        }
        .profile-avatar {
            width: 100px; height: 100px; border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex; align-items: center; justify-content: center;
            font-size: 48px; margin: 0 auto 20px;
        }
        .profile-card {
            background: white; padding: 40px; border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 20px;
        }
        h2 {color: #333; margin-bottom: 30px;}
        .message {
            padding: 15px; border-radius: 5px; margin-bottom: 20px; text-align: center;
        }
        .success {
            background: #d4edda; color: #155724;
            border: 1px solid #c3e6cb; border-left: 4px solid #28a745;
        }
        .error {
            background: #f8d7da; color: #721c24;
            border: 1px solid #f5c6cb; border-left: 4px solid #dc3545;
        }
        .form-group {margin-bottom: 20px;}
        label {display: block; margin-bottom: 5px; color: #555; font-weight: 500;}
        input {
            width: 100%; padding: 12px; border: 1px solid #ddd;
            border-radius: 5px; font-size: 14px;
        }
        input:focus {outline: none; border-color: #667eea;}
        .btn {
            width: 100%; padding: 12px; background: #667eea; color: white;
            border: none; border-radius: 5px; font-size: 16px;
            font-weight: 600; cursor: pointer; margin-top: 10px; transition: all 0.3s;
        }
        .btn:hover {background: #5568d3; transform: translateY(-2px);}
        .action-buttons {
            display: grid; grid-template-columns: 1fr; gap: 15px; margin-top: 20px;
        }
        .action-buttons a {
            padding: 12px; text-align: center; border-radius: 5px;
            text-decoration: none; font-weight: 600; transition: all 0.3s;
            display: block;
        }
        .btn-change-password {background: #28a745; color: white;}
        .btn-change-password:hover {background: #218838; transform: translateY(-2px);}
        @media (max-width: 768px) {
            .navbar {flex-direction: column; gap: 15px;}
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>📚 Library Management System</h1>
        <div class="user-info">
            <span>👋 Welcome, <%= user.getUsername() %>!</span>
            <a href="home.jsp">🏠 Home</a>
            <a href="books.jsp">📖 Books</a>
            <a href="manage-books.jsp">📝 Manage</a>
            <a href="my-books.jsp">📚 My Books</a>
            <a href="LogoutServlet">🚪 Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="profile-header">
            <div class="profile-avatar">👤</div>
            <h1><%= user.getUsername() %></h1>
            <p style="color: #666;">Library Member</p>
        </div>
        
        <div class="profile-card">
            <h2>👤 Profile Information</h2>
            
            <% if(message != null) { 
                if(message.equals("updated")) { %>
                    <div id="msg" class="message success">✅ Profile updated successfully!</div>
                <% } else { %>
                    <div id="msg" class="message error">❌ Profile update failed!</div>
                <% } 
            } %>
            
            <form action="UpdateProfileServlet" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label>Username: *</label>
                    <input type="text" id="username" name="username" 
                           value="<%= user.getUsername() %>" required 
                           placeholder="Enter username">
                </div>
                
                <div class="form-group">
                    <label>Email: *</label>
                    <input type="email" id="email" name="email" 
                           value="<%= user.getEmail() %>" required 
                           placeholder="your.email@example.com">
                </div>
                
                <div class="form-group">
                    <label>Phone Number: *</label>
                    <input type="text" id="phoneno" name="phoneno" 
                           value="<%= user.getPhoneNo() %>" required 
                           placeholder="+911234567890">
                </div>
                
                <button type="submit" class="btn">💾 Update Profile</button>
            </form>
            
            <div class="action-buttons">
                <a href="change-password.jsp" class="btn-change-password">🔒 Change Password</a>
            </div>
        </div>
    </div>
    
    <script>
        function validateForm() {
            const username = document.getElementById('username').value.trim();
            const email = document.getElementById('email').value.trim();
            const phone = document.getElementById('phoneno').value.trim();
            
            const usernameRegex = /^[A-Za-z][A-Za-z0-9._]{4,14}$/;
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            const phoneRegex = /^\+\d{1,3}\d{7,12}$/;
            
            if (!usernameRegex.test(username)) {
                alert("⚠️ Username must:\n• Start with a letter\n• Contain only letters, numbers, dot, underscore\n• Be 5-15 characters long");
                return false;
            }
            if (!emailRegex.test(email)) {
                alert("⚠️ Please enter a valid email address");
                return false;
            }
            if (!phoneRegex.test(phone)) {
                alert("⚠️ Phone number must include country code\nExample: +911234567890");
                return false;
            }
            return true;
        }
        
        window.addEventListener('DOMContentLoaded', () => {
            const msg = document.getElementById('msg');
            if (msg) {
                setTimeout(() => msg.style.display = 'none', 5000);
            }
        });
    </script>
</body>
</html>
