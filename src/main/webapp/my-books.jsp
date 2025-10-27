<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.library.util.DBConnection, com.library.beans.RegisterBean" %>
<%
    // Session check
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
    <title>My Borrowed Books</title>
    <link rel="stylesheet" href="css/common.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .books-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .page-header {
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            margin-bottom: 30px;
            border: 1px solid rgba(255,255,255,0.5);
        }
        
        .page-header h2 {
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 32px;
            font-weight: 800;
        }
        
        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .book-card {
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(255,255,255,0.5);
            position: relative;
            overflow: hidden;
        }
        
        .book-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }
        
        .book-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 15px 50px rgba(102, 126, 234, 0.4);
        }
        
        .book-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        
        .book-info {
            color: #666;
            margin: 5px 0;
            font-size: 14px;
        }
        
        .borrow-date {
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            color: #1565c0;
            padding: 8px 16px;
            border-radius: 20px;
            display: inline-block;
            margin-top: 10px;
            font-size: 13px;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(21, 101, 192, 0.2);
        }
        
        .return-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 25px;
            cursor: pointer;
            margin-top: 15px;
            width: 100%;
            font-weight: 700;
            font-size: 15px;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .return-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(102, 126, 234, 0.6);
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
        
        .no-books {
            text-align: center;
            padding: 60px 20px;
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.15);
            border: 1px solid rgba(255,255,255,0.5);
        }
        
        .no-books h3 {
            color: #666;
            margin-bottom: 20px;
        }
        
        .browse-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 14px 35px;
            border-radius: 30px;
            text-decoration: none;
            display: inline-block;
            font-weight: 700;
            transition: all 0.3s;
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .browse-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(102, 126, 234, 0.6);
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
        
        .success-msg, .error-msg {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .success-msg {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error-msg {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="navbar" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 5px rgba(0,0,0,0.1); flex-wrap: wrap;">
        <h1 style="font-size: 24px; margin: 0;">📚 Library Management System</h1>
        <div style="display: flex; align-items: center; gap: 20px; flex-wrap: wrap;">
            <span>👋 Welcome, <%= user.getUsername() %>!</span>
            <a href="home.jsp" style="color: white; text-decoration: none; padding: 8px 15px; border-radius: 5px; background: rgba(255,255,255,0.2); transition: all 0.3s;">🏠 Home</a>
            <a href="books.jsp" style="color: white; text-decoration: none; padding: 8px 15px; border-radius: 5px; background: rgba(255,255,255,0.2); transition: all 0.3s;">📖 Books</a>
            <a href="manage-books.jsp" style="color: white; text-decoration: none; padding: 8px 15px; border-radius: 5px; background: rgba(255,255,255,0.2); transition: all 0.3s;">📝 Manage</a>
            <a href="profile.jsp" style="color: white; text-decoration: none; padding: 8px 15px; border-radius: 5px; background: rgba(255,255,255,0.2); transition: all 0.3s;">👤 Profile</a>
            <a href="LogoutServlet" style="color: white; text-decoration: none; padding: 8px 15px; border-radius: 5px; background: rgba(255,255,255,0.2); transition: all 0.3s;">🚪 Logout</a>
        </div>
    </div>
    
    <div class="books-container">
        <div class="page-header">
            <h2>📚 My Borrowed Books</h2>
            <p style="color: #666; margin-top: 10px;">Books currently borrowed by you</p>
        </div>
        
        <% 
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            
            if(success != null && success.equals("book_returned")) {
        %>
            <div class="success-msg" id="msg">✅ Book returned successfully!</div>
        <% } %>
        
        <% if(error != null) { %>
            <div class="error-msg" id="msg">❌ Failed to return book. Please try again.</div>
        <% } %>
        
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int bookCount = 0;
            
            try {
                conn = DBConnection.getConnection();
                String sql = "SELECT b.bookid, b.bookname, b.authorname, b.category, " +
                           "bt.borrow_date, bt.transactionid " +
                           "FROM books b " +
                           "JOIN book_transactions bt ON b.bookid = bt.bookid " +
                           "WHERE bt.userid = ? AND bt.status = 'borrowed' " +
                           "ORDER BY bt.borrow_date DESC";
                
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, user.getUserId());
                rs = pstmt.executeQuery();
                
                StringBuilder booksHtml = new StringBuilder("<div class='books-grid'>");
                
                while(rs.next()) {
                    bookCount++;
                    booksHtml.append("<div class='book-card'>");
                    booksHtml.append("<div class='book-title'>").append(rs.getString("bookname")).append("</div>");
                    booksHtml.append("<div class='book-info'><strong>Author:</strong> ").append(rs.getString("authorname")).append("</div>");
                    booksHtml.append("<div class='book-info'><strong>Category:</strong> ").append(rs.getString("category")).append("</div>");
                    
                    Timestamp borrowDate = rs.getTimestamp("borrow_date");
                    booksHtml.append("<div class='borrow-date'>📅 Borrowed: ").append(new java.text.SimpleDateFormat("MMM dd, yyyy").format(borrowDate)).append("</div>");
                    
                    booksHtml.append("<form action='ReturnBookServlet' method='post' style='margin-top: 15px;'>");
                    booksHtml.append("<input type='hidden' name='transactionId' value='").append(rs.getInt("transactionid")).append("'>");
                    booksHtml.append("<input type='hidden' name='bookId' value='").append(rs.getInt("bookid")).append("'>");
                    booksHtml.append("<button type='submit' class='return-btn' onclick='return confirm(\"Are you sure you want to return this book?\")'>↩️ Return Book</button>");
                    booksHtml.append("</form>");
                    
                    booksHtml.append("</div>");
                }
                
                booksHtml.append("</div>");
                
                if(bookCount == 0) {
        %>
                    <div class="no-books">
                        <h3>📖 No books borrowed yet</h3>
                        <p style="color: #999; margin-bottom: 20px;">Start exploring our collection!</p>
                        <a href="books.jsp" class="browse-btn">Browse Books</a>
                    </div>
        <%
                } else {
                    out.print(booksHtml.toString());
                }
                
            } catch(Exception e) {
                e.printStackTrace();
                out.println("<div class='error-msg'>Error loading books: " + e.getMessage() + "</div>");
            } finally {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            }
        %>
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
