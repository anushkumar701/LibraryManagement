<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.beans.RegisterBean, com.library.beans.BookBean, com.library.dao.BookDao, java.util.List" %>
<%
    // Session check
    RegisterBean user = (RegisterBean) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get all books
    BookDao bookDao = new BookDao();
    List<BookBean> books = bookDao.getBooks();
    
    // Check for success/error messages
    String message = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library System - Manage Books</title>
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
        .container {max-width: 1200px; margin: 40px auto; padding: 0 20px;}
        .message {
            padding: 15px; border-radius: 5px; margin-bottom: 20px;
            text-align: center; animation: slideDown 0.5s;
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .success {
            background: #d4edda; color: #155724;
            border: 1px solid #c3e6cb; border-left: 4px solid #28a745;
        }
        .error {
            background: #f8d7da; color: #721c24;
            border: 1px solid #f5c6cb; border-left: 4px solid #dc3545;
        }
        .add-form {
            background: white; padding: 30px; border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 30px;
        }
        .add-form h3 {margin-bottom: 20px; color: #333;}
        .form-row {
            display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px; margin-bottom: 20px;
        }
        .form-group {display: flex; flex-direction: column;}
        label {margin-bottom: 5px; color: #555; font-weight: 500;}
        input, select {
            padding: 10px; border: 1px solid #ddd; border-radius: 5px;
            font-size: 14px; transition: border-color 0.3s;
        }
        input:focus, select:focus {outline: none; border-color: #667eea;}
        .btn {
            padding: 10px 20px; background: #667eea; color: white;
            border: none; border-radius: 5px; cursor: pointer;
            font-size: 14px; font-weight: 600; transition: all 0.3s;
        }
        .btn:hover {background: #5568d3; transform: translateY(-2px);}
        .books-table-container {
            background: white; border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); overflow: hidden;
        }
        table {width: 100%; border-collapse: collapse;}
        thead {background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;}
        th, td {padding: 15px; text-align: left;}
        th {font-weight: 600;}
        tbody tr {border-bottom: 1px solid #eee; transition: all 0.3s;}
        tbody tr:hover {background: #f9f9f9;}
        .action-btns {display: flex; gap: 10px;}
        .btn-update {
            padding: 5px 15px; background: #28a745; color: white;
            border: none; border-radius: 3px; cursor: pointer;
            text-decoration: none; font-size: 12px; transition: all 0.3s;
        }
        .btn-delete {
            padding: 5px 15px; background: #dc3545; color: white;
            border: none; border-radius: 3px; cursor: pointer;
            font-size: 12px; transition: all 0.3s;
        }
        .btn-update:hover {background: #218838; transform: scale(1.05);}
        .btn-delete:hover {background: #c82333; transform: scale(1.05);}
        .no-books {text-align: center; padding: 60px 20px; color: #999;}
        .status-badge {
            display: inline-block; padding: 5px 12px;
            border-radius: 20px; font-size: 12px; font-weight: 600;
        }
        .status-yes {background: #d4edda; color: #155724;}
        .status-no {background: #f8d7da; color: #721c24;}
        @media (max-width: 768px) {
            .navbar {flex-direction: column; gap: 15px;}
            .books-table-container {overflow-x: auto;}
            table {min-width: 700px;}
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>📚 Library Management System</h1>
        <div class="user-info">
            <span>👋 Welcome, <%= user.getUsername() %>!</span>
            <a href="home.jsp">🏠 Home</a>
            <a href="books.jsp">📖 View Books</a>
            <a href="my-books.jsp">📚 My Books</a>
            <a href="profile.jsp">👤 Profile</a>
            <a href="LogoutServlet">🚪 Logout</a>
        </div>
    </div>
    
    <div class="container">
        <% if(message != null) { 
            String msgText = "";
            String msgClass = "";
            switch(message) {
                case "added":
                    msgText = "✅ Book added successfully!";
                    msgClass = "success";
                    break;
                case "updated":
                    msgText = "✅ Book updated successfully!";
                    msgClass = "success";
                    break;
                case "deleted":
                    msgText = "✅ Book deleted successfully!";
                    msgClass = "success";
                    break;
                case "empty_bookname":
                    msgText = "❌ Book name is required!";
                    msgClass = "error";
                    break;
                case "empty_author":
                    msgText = "❌ Author name is required!";
                    msgClass = "error";
                    break;
                case "empty_category":
                    msgText = "❌ Category is required!";
                    msgClass = "error";
                    break;
                default:
                    msgText = "❌ Operation failed! Please try again.";
                    msgClass = "error";
            }
        %>
            <div id="msg" class="message <%= msgClass %>"><%= msgText %></div>
        <% } %>
        
        <div class="add-form">
            <h3>➕ Add New Book</h3>
            <form action="AddBookServlet" method="post" onsubmit="return validateForm()">
                <div class="form-row">
                    <div class="form-group">
                        <label>Book Name: *</label>
                        <input type="text" name="bookname" id="bookname" required 
                               placeholder="Enter book name">
                    </div>
                    <div class="form-group">
                        <label>Author Name: *</label>
                        <input type="text" name="authorname" id="authorname" required 
                               placeholder="Enter author name">
                    </div>
                    <div class="form-group">
                        <label>Category: *</label>
                        <select name="category" id="category" required>
                            <option value="">Select Category</option>
                            <option value="Fiction">Fiction</option>
                            <option value="Non-Fiction">Non-Fiction</option>
                            <option value="Science">Science</option>
                            <option value="Technology">Technology</option>
                            <option value="History">History</option>
                            <option value="Biography">Biography</option>
                            <option value="Self-Help">Self-Help</option>
                            <option value="Education">Education</option>
                            <option value="Children">Children</option>
                            <option value="Mystery">Mystery</option>
                            <option value="Romance">Romance</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Available Status: *</label>
                        <select name="availablestatus" required>
                            <option value="Yes">✅ Available</option>
                            <option value="No">❌ Not Available</option>
                        </select>
                    </div>
                </div>
                <button type="submit" class="btn">➕ Add Book</button>
            </form>
        </div>
        
        <h3 style="margin-bottom: 20px; color: #333;">📚 All Books (<%= books != null ? books.size() : 0 %>)</h3>
        
        <% if(books != null && books.size() > 0) { %>
            <div class="books-table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Book Name</th>
                            <th>Author</th>
                            <th>Category</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(BookBean book : books) { %>
                            <tr>
                                <td>#<%= book.getBookId() %></td>
                                <td><strong><%= book.getBookName() %></strong></td>
                                <td><%= book.getAuthorName() %></td>
                                <td><%= book.getCategory() != null ? book.getCategory() : "General" %></td>
                                <td>
                                    <span class="status-badge <%= book.getAvailableStatus().equals("Yes") ? "status-yes" : "status-no" %>">
                                        <%= book.getAvailableStatus().equals("Yes") ? "Available" : "Not Available" %>
                                    </span>
                                </td>
                                <td>
                                    <div class="action-btns">
                                        <a href="update-book.jsp?id=<%= book.getBookId() %>" class="btn-update">✏️ Edit</a>
                                        <form action="DeleteBookServlet" method="post" style="display: inline;">
                                            <input type="hidden" name="bookid" value="<%= book.getBookId() %>">
                                            <button type="submit" class="btn-delete" 
                                                    onclick="return confirm('Are you sure you want to delete this book?')">
                                                🗑️ Delete
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else { %>
            <div class="books-table-container">
                <div class="no-books">
                    <h3>📭 No Books Available</h3>
                    <p>Add your first book using the form above!</p>
                </div>
            </div>
        <% } %>
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
