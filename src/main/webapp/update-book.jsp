<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.beans.RegisterBean, com.library.beans.BookBean, com.library.dao.BookDao" %>
<%
    RegisterBean user = (RegisterBean) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String bookIdStr = request.getParameter("id");
    if(bookIdStr == null || bookIdStr.trim().isEmpty()) {
        response.sendRedirect("manage-books.jsp");
        return;
    }
    
    int bookId = Integer.parseInt(bookIdStr);
    BookDao dao = new BookDao();
    BookBean book = dao.getBookById(bookId);
    
    if(book == null) {
        response.sendRedirect("manage-books.jsp?msg=notfound");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Book</title>
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
        .container {max-width: 700px; margin: 40px auto; padding: 0 20px;}
        .form-card {
            background: white; padding: 40px; border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {color: #333; margin-bottom: 30px; text-align: center;}
        .form-group {margin-bottom: 20px;}
        label {display: block; margin-bottom: 5px; color: #555; font-weight: 500;}
        input, select {
            width: 100%; padding: 12px; border: 1px solid #ddd;
            border-radius: 5px; font-size: 14px;
        }
        input:focus, select:focus {outline: none; border-color: #667eea;}
        .btn-group {display: flex; gap: 15px; margin-top: 30px;}
        .btn {
            flex: 1; padding: 12px; border: none; border-radius: 5px;
            font-size: 16px; font-weight: 600; cursor: pointer; transition: all 0.3s;
        }
        .btn-primary {background: #667eea; color: white;}
        .btn-primary:hover {background: #5568d3; transform: translateY(-2px);}
        .btn-secondary {background: #6c757d; color: white; text-decoration: none; text-align: center;}
        .btn-secondary:hover {background: #5a6268; transform: translateY(-2px);}
    </style>
</head>
<body>
    <div class="navbar">
        <h1>📚 Library Management System</h1>
        <div class="user-info">
            <span>👋 <%= user.getUsername() %></span>
            <a href="home.jsp">🏠 Home</a>
            <a href="manage-books.jsp">📝 Manage Books</a>
            <a href="LogoutServlet">🚪 Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="form-card">
            <h2>✏️ Update Book</h2>
            
            <form action="UpdateBookServlet" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="bookid" value="<%= book.getBookId() %>">
                
                <div class="form-group">
                    <label>Book Name: *</label>
                    <input type="text" id="bookname" name="bookname" 
                           value="<%= book.getBookName() %>" required
                           placeholder="Enter book name">
                </div>
                
                <div class="form-group">
                    <label>Author Name: *</label>
                    <input type="text" id="authorname" name="authorname" 
                           value="<%= book.getAuthorName() %>" required
                           placeholder="Enter author name">
                </div>
                
                <div class="form-group">
                    <label>Category: *</label>
                    <select name="category" id="category" required>
                        <option value="">Select Category</option>
                        <option value="Fiction" <%= book.getCategory() != null && book.getCategory().equals("Fiction") ? "selected" : "" %>>Fiction</option>
                        <option value="Non-Fiction" <%= book.getCategory() != null && book.getCategory().equals("Non-Fiction") ? "selected" : "" %>>Non-Fiction</option>
                        <option value="Science" <%= book.getCategory() != null && book.getCategory().equals("Science") ? "selected" : "" %>>Science</option>
                        <option value="Technology" <%= book.getCategory() != null && book.getCategory().equals("Technology") ? "selected" : "" %>>Technology</option>
                        <option value="History" <%= book.getCategory() != null && book.getCategory().equals("History") ? "selected" : "" %>>History</option>
                        <option value="Biography" <%= book.getCategory() != null && book.getCategory().equals("Biography") ? "selected" : "" %>>Biography</option>
                        <option value="Self-Help" <%= book.getCategory() != null && book.getCategory().equals("Self-Help") ? "selected" : "" %>>Self-Help</option>
                        <option value="Education" <%= book.getCategory() != null && book.getCategory().equals("Education") ? "selected" : "" %>>Education</option>
                        <option value="Children" <%= book.getCategory() != null && book.getCategory().equals("Children") ? "selected" : "" %>>Children</option>
                        <option value="Mystery" <%= book.getCategory() != null && book.getCategory().equals("Mystery") ? "selected" : "" %>>Mystery</option>
                        <option value="Romance" <%= book.getCategory() != null && book.getCategory().equals("Romance") ? "selected" : "" %>>Romance</option>
                        <option value="Other" <%= book.getCategory() != null && book.getCategory().equals("Other") ? "selected" : "" %>>Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Available Status: *</label>
                    <select name="availablestatus" required>
                        <option value="Yes" <%= book.getAvailableStatus().equals("Yes") ? "selected" : "" %>>✅ Available</option>
                        <option value="No" <%= book.getAvailableStatus().equals("No") ? "selected" : "" %>>❌ Not Available</option>
                    </select>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">💾 Update Book</button>
                    <a href="manage-books.jsp" class="btn btn-secondary">✖ Cancel</a>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        function validateForm() {
            const bookname = document.getElementById('bookname').value.trim();
            const authorname = document.getElementById('authorname').value.trim();
            const category = document.getElementById('category').value;
            
            if(bookname === '') {
                alert('⚠️ Please enter book name');
                return false;
            }
            if(authorname === '') {
                alert('⚠️ Please enter author name');
                return false;
            }
            if(category === '') {
                alert('⚠️ Please select a category');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
