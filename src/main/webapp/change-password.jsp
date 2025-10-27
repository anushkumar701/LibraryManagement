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
    <title>Change Password</title>
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
        .navbar a:hover {background: rgba(255,255,255,0.3);}
        .container {max-width: 600px; margin: 40px auto; padding: 0 20px;}
        .card {
            background: white; padding: 40px; border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {text-align: center; color: #333; margin-bottom: 30px;}
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
        .password-requirements {
            font-size: 12px; color: #666; margin-top: 5px;
            padding: 10px; background: #f9f9f9; border-radius: 5px;
        }
        .password-requirements ul {list-style-position: inside; padding-left: 0; margin: 5px 0;}
    </style>
</head>
<body>
    <div class="navbar">
        <h1>📚 Library Management System</h1>
        <div class="user-info">
            <span>👋 <%= user.getUsername() %></span>
            <a href="home.jsp">🏠 Home</a>
            <a href="profile.jsp">👤 Profile</a>
            <a href="LogoutServlet">🚪 Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="card">
            <h2>🔒 Change Password</h2>
            
            <% 
                String error = request.getParameter("error");
                String success = request.getParameter("success");
                
                if(error != null) {
                    String errorMsg = "";
                    switch(error) {
                        case "empty_old":
                            errorMsg = "❌ Please enter current password";
                            break;
                        case "empty_new":
                            errorMsg = "❌ Please enter new password";
                            break;
                        case "mismatch":
                            errorMsg = "❌ New passwords don't match";
                            break;
                        case "weak":
                            errorMsg = "❌ New password is too weak";
                            break;
                        case "incorrect_old":
                            errorMsg = "❌ Current password is incorrect";
                            break;
                        default:
                            errorMsg = "❌ Password change failed";
                    }
            %>
                <div id="msg" class="message error"><%= errorMsg %></div>
            <% } %>
            
            <% if(success != null && success.equals("1")) { %>
                <div id="msg" class="message success">✅ Password changed successfully!</div>
            <% } %>
            
            <form action="ChangePasswordServlet" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label>Current Password: *</label>
                    <input type="password" id="oldPassword" name="oldPassword" required 
                           placeholder="Enter current password">
                </div>
                
                <div class="form-group">
                    <label>New Password: *</label>
                    <input type="password" id="newPassword" name="newPassword" required 
                           placeholder="Enter new password">
                    <div class="password-requirements">
                        <strong>Password Requirements:</strong>
                        <ul>
                            <li>Minimum 8 characters</li>
                            <li>At least one uppercase letter (A-Z)</li>
                            <li>At least one lowercase letter (a-z)</li>
                            <li>At least one digit (0-9)</li>
                            <li>At least one special character (@$!%*?&amp;)</li>
                        </ul>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Confirm New Password: *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required 
                           placeholder="Re-enter new password">
                </div>
                
                <button type="submit" class="btn">🔒 Change Password</button>
            </form>
        </div>
    </div>
    
    <script>
        function validateForm() {
            const oldPwd = document.getElementById('oldPassword').value;
            const newPwd = document.getElementById('newPassword').value;
            const confirmPwd = document.getElementById('confirmPassword').value;
            
            if(oldPwd === '') {
                alert('⚠️ Please enter current password');
                return false;
            }
            
            if(newPwd === '') {
                alert('⚠️ Please enter new password');
                return false;
            }
            
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            if(!passwordRegex.test(newPwd)) {
                alert('⚠️ New password must:\n• Be at least 8 characters\n• Include uppercase letter\n• Include lowercase letter\n• Include number\n• Include special character (@$!%*?&)');
                return false;
            }
            
            if(newPwd !== confirmPwd) {
                alert('⚠️ New passwords do not match');
                return false;
            }
            
            if(oldPwd === newPwd) {
                alert('⚠️ New password must be different from current password');
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
