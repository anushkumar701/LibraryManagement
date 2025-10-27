package com.library.servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.library.beans.RegisterBean;
import com.library.util.DBConnection;

@WebServlet("/ReturnBookServlet")
public class ReturnBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        RegisterBean user = (RegisterBean) session.getAttribute("user");
        int userId = user.getUserId();
        
        String transactionIdParam = request.getParameter("transactionId");
        String bookIdParam = request.getParameter("bookId");
        
        if (transactionIdParam == null || bookIdParam == null) {
            response.sendRedirect("my-books.jsp?error=invalid_request");
            return;
        }
        
        Connection conn = null;
        try {
            int transactionId = Integer.parseInt(transactionIdParam);
            int bookId = Integer.parseInt(bookIdParam);
            
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Verify the transaction belongs to this user
            String verifySql = "SELECT userid FROM book_transactions WHERE transactionid = ? AND status = 'borrowed'";
            PreparedStatement verifyStmt = conn.prepareStatement(verifySql);
            verifyStmt.setInt(1, transactionId);
            ResultSet rs = verifyStmt.executeQuery();
            
            if (!rs.next() || rs.getInt("userid") != userId) {
                conn.rollback();
                response.sendRedirect("my-books.jsp?error=unauthorized");
                return;
            }
            
            // Update transaction status
            String updateTxnSql = "UPDATE book_transactions SET status = 'returned', return_date = CURRENT_TIMESTAMP WHERE transactionid = ?";
            PreparedStatement updateTxnStmt = conn.prepareStatement(updateTxnSql);
            updateTxnStmt.setInt(1, transactionId);
            updateTxnStmt.executeUpdate();
            
            // Update book availability
            String updateBookSql = "UPDATE books SET availablestatus = 'Yes' WHERE bookid = ?";
            PreparedStatement updateBookStmt = conn.prepareStatement(updateBookSql);
            updateBookStmt.setInt(1, bookId);
            updateBookStmt.executeUpdate();
            
            conn.commit();
            response.sendRedirect("my-books.jsp?success=book_returned");
            
        } catch (NumberFormatException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            response.sendRedirect("my-books.jsp?error=invalid_request");
        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            response.sendRedirect("my-books.jsp?error=db_error");
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
