package com.library.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.library.beans.BookBean;
import com.library.dao.BookDao;
import com.library.util.InputSanitizer;

@WebServlet("/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Session check
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get and sanitize form data
        String bookName = InputSanitizer.sanitize(request.getParameter("bookname"));
        String authorName = InputSanitizer.sanitize(request.getParameter("authorname"));
        String availableStatus = request.getParameter("availablestatus");
        String category = InputSanitizer.sanitize(request.getParameter("category"));
        
        // Validation
        if(bookName == null || bookName.trim().isEmpty()) {
            response.sendRedirect("manage-books.jsp?msg=empty_bookname");
            return;
        }
        
        if(authorName == null || authorName.trim().isEmpty()) {
            response.sendRedirect("manage-books.jsp?msg=empty_author");
            return;
        }
        
        if(availableStatus == null || (!availableStatus.equals("Yes") && !availableStatus.equals("No"))) {
            response.sendRedirect("manage-books.jsp?msg=invalid_status");
            return;
        }
        
        if(category == null || category.trim().isEmpty()) {
            response.sendRedirect("manage-books.jsp?msg=empty_category");
            return;
        }
        
        // Create book bean
        BookBean book = new BookBean();
        book.setBookName(bookName);
        book.setAuthorName(authorName);
        book.setAvailableStatus(availableStatus);
        book.setCategory(category);
        
        // Save to database
        BookDao dao = new BookDao();
        boolean result = dao.addBook(book);
        
        if(result) {
            response.sendRedirect("manage-books.jsp?msg=added");
        } else {
            response.sendRedirect("manage-books.jsp?msg=error");
        }
    }
}
