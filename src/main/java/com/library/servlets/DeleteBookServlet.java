package com.library.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.library.dao.BookDao;

@WebServlet("/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Session check
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get book ID
        String bookIdStr = request.getParameter("bookid");
        
        if(bookIdStr == null || bookIdStr.trim().isEmpty()) {
            response.sendRedirect("manage-books.jsp?msg=error");
            return;
        }
        
        try {
            int bookId = Integer.parseInt(bookIdStr);
            
            // Delete from database
            BookDao dao = new BookDao();
            boolean result = dao.deleteBook(bookId);
            
            if(result) {
                response.sendRedirect("manage-books.jsp?msg=deleted");
            } else {
                response.sendRedirect("manage-books.jsp?msg=error");
            }
        } catch(NumberFormatException e) {
            response.sendRedirect("manage-books.jsp?msg=error");
        }
    }
}
