<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.beans.RegisterBean, com.library.beans.BookBean, com.library.dao.BookDao, java.util.List" %>
<%
    // Session check
    RegisterBean user = (RegisterBean) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get all books or search results
    BookDao bookDao = new BookDao();
    String searchKeyword = request.getParameter("search");
    List<BookBean> books;
    
    if(searchKeyword != null && !searchKeyword.trim().isEmpty()) {
        books = bookDao.searchBooks(searchKeyword.trim());
    } else {
        books = bookDao.getBooks();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library System - Books</title>
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
        }
        
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            flex-wrap: wrap;
        }
        
        .navbar h1 {
            font-size: 24px;
        }
        
        .navbar .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }
        
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 5px;
            background: rgba(255,255,255,0.2);
            transition: all 0.3s;
        }
        
        .navbar a:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-2px);
        }
        
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .header {
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            margin-bottom: 30px;
            border: 1px solid rgba(255,255,255,0.5);
        }
        
        .header h2 {
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 32px;
            font-weight: 800;
        }
        
        .header h2 {
            color: #333;
            margin-bottom: 20px;
        }
        
        .search-form {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .search-form input[type="text"] {
            flex: 1;
            min-width: 200px;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .search-form input[type="text"]:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .search-form button {
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 700;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .search-form button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(102, 126, 234, 0.6);
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
        
        .search-form .btn-clear {
            background: #6c757d;
        }
        
        .search-form .btn-clear:hover {
            background: #5a6268;
        }
        
        .books-container {
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.5);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        th, td {
            padding: 15px;
            text-align: left;
        }
        
        th {
            font-weight: 600;
        }
        
        tbody tr {
            border-bottom: 1px solid #eee;
            transition: all 0.3s;
        }
        
        tbody tr:hover {
            background: #f9f9f9;
        }
        
        .status-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 13px;
        }
        
        .status-yes {
            background: #d4edda;
            color: #155724;
        }
        
        .status-no {
            background: #f8d7da;
            color: #721c24;
        }
        
        .no-books {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        
        .no-books h3 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        
        .search-info {
            background: #e7f3ff;
            color: #004085;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #004085;
        }
        
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
            }
            
            .navbar h1 {
                font-size: 20px;
            }
            
            .books-container {
                overflow-x: auto;
            }
            
            table {
                min-width: 600px;
            }
        }
    </style>
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
</head>
<body>
    <div class="navbar">
        <h1>📚 Library Management System</h1>
        <div class="user-info">
            <span>👋 Welcome, <%= user.getUsername() %>!</span>
            <a href="home.jsp">🏠 Home</a>
            <a href="manage-books.jsp">📖 Manage</a>
            <a href="my-books.jsp">📚 My Books</a>
            <a href="profile.jsp">👤 Profile</a>
            <a href="LogoutServlet">🚪 Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="header">
            <h2>📖 Library Books</h2>
            <form action="books.jsp" method="get" class="search-form">
                <input type="text" name="search" placeholder="Search by book name or author..." 
                       value="<%= searchKeyword != null ? searchKeyword : "" %>">
                <button type="submit">🔍 Search</button>
                <% if(searchKeyword != null && !searchKeyword.isEmpty()) { %>
                    <a href="books.jsp" class="btn-clear" style="padding: 12px 25px; color: white; text-decoration: none; border-radius: 5px; font-weight: 600;">✖ Clear</a>
                <% } %>
            </form>
        </div>
        
        <% 
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            
            if(success != null && success.equals("book_taken")) {
        %>
            <div id="msg" style="background: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin-bottom: 20px; text-align: center; border: 1px solid #c3e6cb;">
                ✅ Book borrowed successfully! Check "My Books" to view.
            </div>
        <% } %>
        
        <% if(error != null) {
                String errorMsg = "";
                switch(error) {
                    case "book_unavailable":
                        errorMsg = "❌ Book is not available. Please try another book.";
                        break;
                    case "invalid_book":
                        errorMsg = "❌ Invalid book request.";
                        break;
                    default:
                        errorMsg = "❌ Failed to borrow book. Please try again.";
                }
        %>
            <div id="msg" style="background: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; margin-bottom: 20px; text-align: center; border: 1px solid #f5c6cb;">
                <%= errorMsg %>
            </div>
        <% } %>
        
        <% if(searchKeyword != null && !searchKeyword.isEmpty()) { %>
            <div class="search-info">
                📊 Showing search results for: "<strong><%= searchKeyword %></strong>" 
                (<%= books != null ? books.size() : 0 %> books found)
            </div>
        <% } %>
        
        <% if(books != null && books.size() > 0) { %>
            <div class="books-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Book Name</th>
                            <th>Author</th>
                            <th>Category</th>
                            <th>Status</th>
                            <th>Action</th>
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
                                        <%= book.getAvailableStatus().equals("Yes") ? "✅ Available" : "❌ Not Available" %>
                                    </span>
                                </td>
                                <td>
                                    <% if(book.getAvailableStatus().equals("Yes")) { %>
                                        <form action="TakeBookServlet" method="post" style="display: inline;">
                                            <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                                            <button type="submit" onclick="return confirm('Do you want to borrow this book?')" 
                                                    style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; padding: 10px 20px; border-radius: 20px; cursor: pointer; font-weight: 700; transition: all 0.3s; box-shadow: 0 3px 10px rgba(102, 126, 234, 0.4); font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px;"
                                                    onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 5px 15px rgba(102, 126, 234, 0.6)'" 
                                                    onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 3px 10px rgba(102, 126, 234, 0.4)'">
                                                📖 Take Book
                                            </button>
                                        </form>
                                    <% } else { %>
                                        <span style="color: #999; font-style: italic;">Not Available</span>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else { %>
            <div class="books-container">
                <div class="no-books">
                    <h3>📭 No Books Found</h3>
                    <% if(searchKeyword != null && !searchKeyword.isEmpty()) { %>
                        <p>No books match your search. Try different keywords.</p>
                        <br>
                        <a href="books.jsp" style="color: #667eea; text-decoration: none; font-weight: 600;">← Back to all books</a>
                    <% } else { %>
                        <p>The library is empty. Add some books to get started!</p>
                        <br>
                        <a href="manage-books.jsp" style="color: #667eea; text-decoration: none; font-weight: 600;">➕ Add Books</a>
                    <% } %>
                </div>
            </div>
        <% } %>
    </div>
</body>
</html>
