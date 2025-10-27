<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library System - Register</title>
    <style>
        * {margin:0; padding:0; box-sizing:border-box;}
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
        body::before {content: ''; position: absolute; width: 400px; height: 400px; background: rgba(255,255,255,0.1); border-radius: 50%; top: -150px; right: -150px; animation: float 6s ease-in-out infinite;}
        @keyframes float {0%, 100% {transform: translateY(0);} 50% {transform: translateY(-30px);}}
        .container {
            background: linear-gradient(145deg, rgba(255,255,255,0.95), rgba(248,249,250,0.95));
            backdrop-filter: blur(20px);
            padding: 50px 40px;
            border-radius: 30px;
            box-shadow: 0 30px 80px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 500px;
            border: 1px solid rgba(255,255,255,0.5);
            animation: slideUp 0.8s ease;
            position: relative;
            z-index: 10;
        }
        @keyframes slideUp {from {opacity: 0; transform: translateY(50px);} to {opacity: 1; transform: translateY(0);}}
        h2 {text-align: center; background: linear-gradient(135deg, #667eea, #764ba2); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 35px; font-size: 32px; font-weight: 900;}
        .form-group {margin-bottom: 20px;}
        label {display: block; margin-bottom: 5px; color: #555; font-weight: 500;}
        input[type="text"],input[type="email"],input[type="password"] {
            width: 100%; padding: 15px 20px; border: 2px solid rgba(102, 126, 234, 0.2);
            border-radius: 15px; font-size: 15px; transition: all 0.3s; background: rgba(255,255,255,0.8);
        }
        input:focus {outline:none; border-color: #667eea; box-shadow: 0 0 0 5px rgba(102, 126, 234, 0.1); transform: translateY(-2px);}
        .btn {
            width: 100%; padding: 16px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;
            border: none; border-radius: 15px; font-size: 17px; font-weight: 700;
            cursor: pointer; margin-top: 10px; transition: all 0.4s; box-shadow: 0 8px 30px rgba(102, 126, 234, 0.5);
            text-transform: uppercase; letter-spacing: 1px; position: relative; overflow: hidden;
        }
        .btn::before {content: ''; position: absolute; top: 0; left: -100%; width: 100%; height: 100%; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent); transition: left 0.5s;}
        .btn:hover::before {left: 100%;}
        .btn:hover {transform: translateY(-3px); box-shadow: 0 15px 50px rgba(102, 126, 234, 0.7);}
        .error {
            background: #fee; color: #c33; padding: 12px;
            border-radius: 5px; margin-bottom: 20px; text-align: center;
            border-left: 4px solid #c33;
        }
        .success {
            background: #efe; color: #3c3; padding: 12px;
            border-radius: 5px; margin-bottom: 20px; text-align: center;
            border-left: 4px solid #3c3;
        }
        .login-link {text-align: center; margin-top: 20px; color: #666;}
        .login-link a {color: #667eea; text-decoration: none; font-weight: 500;}
        .login-link a:hover {text-decoration: underline;}
        .password-requirements {
            font-size: 12px; color: #666; margin-top: 5px;
            padding: 10px; background: #f9f9f9; border-radius: 5px;
        }
        .password-requirements ul {
            list-style-position: inside;
            padding-left: 0;
            margin: 5px 0;
        }
        @media (max-width: 480px) {
            .container {padding: 30px 20px;}
        }
    </style>

    <script>
    function validateForm() {
        const username = document.getElementById("username").value.trim();
        const email = document.getElementById("email").value.trim();
        const phone = document.getElementById("phoneno").value.trim();
        const password = document.getElementById("password").value.trim();

        const usernameRegex = /^[A-Za-z][A-Za-z0-9._]{4,14}$/;
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        const phoneRegex = /^\+\d{1,3}\d{7,12}$/;
        const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

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
        if (!passwordRegex.test(password)) {
            alert("⚠️ Password must:\n• Be at least 8 characters\n• Include uppercase letter\n• Include lowercase letter\n• Include number\n• Include special character (@$!%*?&)");
            return false;
        }
        return true;
    }
    </script>
    
</head>
<body>
    <div class="container">
        <h2>📚 Library Registration</h2>
        
        <% 
            String error = request.getParameter("error");
            String success = request.getParameter("success");
            
            if(error != null) {
                String errorMsg = "";
                switch(error) {
                    case "username_exists":
                        errorMsg = "❌ Username already taken! Please choose another.";
                        break;
                    case "email_exists":
                        errorMsg = "❌ Email already registered! Please login.";
                        break;
                    case "invalid_username":
                        errorMsg = "❌ Invalid username format!";
                        break;
                    case "invalid_email":
                        errorMsg = "❌ Invalid email format!";
                        break;
                    case "invalid_phone":
                        errorMsg = "❌ Invalid phone number format!";
                        break;
                    case "weak_password":
                        errorMsg = "❌ Password too weak! Check requirements below.";
                        break;
                    case "empty_fields":
                        errorMsg = "❌ All fields are required!";
                        break;
                    default:
                        errorMsg = "❌ Registration failed! Please try again.";
                }
        %>
            <div id="msg" class="error"><%= errorMsg %></div>
        <% } %>
        
        <% if(success != null && success.equals("1")) { %>
            <div id="msg" class="success">✅ Registration successful! Please login.</div>
        <% } %>
        
        <form action="RegisterServlet" method="post" onsubmit="return validateForm();">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required 
                       placeholder="Enter username (5-15 chars)">
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required 
                       placeholder="your.email@example.com">
            </div>
            
            <div class="form-group">
                <label for="phoneno">Phone Number:</label>
                <input type="text" id="phoneno" name="phoneno" required 
                       placeholder="+911234567890">
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required 
                       placeholder="Enter strong password">
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
            
            <button type="submit" class="btn">📝 Register Now</button>
        </form>
        
        <div class="login-link">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </div>

    <script>
        // Auto-hide messages after 5 seconds
        window.addEventListener('DOMContentLoaded', () => {
            const msg = document.getElementById('msg');
            if (msg) {
                setTimeout(() => {
                    msg.style.display = 'none';
                }, 5000);
            }
        });
    </script>
    
</body>
</html>
