package com.library.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.library.beans.BookBean;
import com.library.util.DBConnection;

public class BookDao {
    
    // Get all books
    public List<BookBean> getBooks() {
        List<BookBean> books = new ArrayList<>();
        String sql = "SELECT * FROM books ORDER BY bookid DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                BookBean book = new BookBean();
                book.setBookId(rs.getInt("bookid"));
                book.setBookName(rs.getString("bookname"));
                book.setAuthorName(rs.getString("authorname"));
                book.setAvailableStatus(rs.getString("availablestatus"));
                book.setCategory(rs.getString("category"));
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    // Add new book WITH CATEGORY
    public boolean addBook(BookBean book) {
        String sql = "INSERT INTO books (bookname, authorname, availablestatus, category) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, book.getBookName());
            pstmt.setString(2, book.getAuthorName());
            pstmt.setString(3, book.getAvailableStatus());
            pstmt.setString(4, book.getCategory());
            
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update book WITH CATEGORY
    public boolean updateBook(BookBean book) {
        String sql = "UPDATE books SET bookname = ?, authorname = ?, availablestatus = ?, category = ? WHERE bookid = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, book.getBookName());
            pstmt.setString(2, book.getAuthorName());
            pstmt.setString(3, book.getAvailableStatus());
            pstmt.setString(4, book.getCategory());
            pstmt.setInt(5, book.getBookId());
            
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete book
    public boolean deleteBook(int bookId) {
        String sql = "DELETE FROM books WHERE bookid = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookId);
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get book by ID
    public BookBean getBookById(int bookId) {
        String sql = "SELECT * FROM books WHERE bookid = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                BookBean book = new BookBean();
                book.setBookId(rs.getInt("bookid"));
                book.setBookName(rs.getString("bookname"));
                book.setAuthorName(rs.getString("authorname"));
                book.setAvailableStatus(rs.getString("availablestatus"));
                book.setCategory(rs.getString("category"));
                return book;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Search books by name or author
    public List<BookBean> searchBooks(String keyword) {
        List<BookBean> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE LOWER(bookname) LIKE LOWER(?) OR LOWER(authorname) LIKE LOWER(?) ORDER BY bookid DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                BookBean book = new BookBean();
                book.setBookId(rs.getInt("bookid"));
                book.setBookName(rs.getString("bookname"));
                book.setAuthorName(rs.getString("authorname"));
                book.setAvailableStatus(rs.getString("availablestatus"));
                book.setCategory(rs.getString("category"));
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    // Take book - Borrow a book (NEW METHOD ADDED)
    public boolean takeBook(int bookId, int userId) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Check if book is available
            String checkSql = "SELECT availablestatus FROM books WHERE bookid = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, bookId);
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next() && rs.getString("availablestatus").equalsIgnoreCase("Yes")) {
                // Update book status to No
                String updateBookSql = "UPDATE books SET availablestatus = 'No' WHERE bookid = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateBookSql);
                updateStmt.setInt(1, bookId);
                updateStmt.executeUpdate();
                
                // Insert transaction record
                String insertTxnSql = "INSERT INTO book_transactions (bookid, userid, status) VALUES (?, ?, 'borrowed')";
                PreparedStatement insertStmt = conn.prepareStatement(insertTxnSql);
                insertStmt.setInt(1, bookId);
                insertStmt.setInt(2, userId);
                insertStmt.executeUpdate();
                
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }
        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
