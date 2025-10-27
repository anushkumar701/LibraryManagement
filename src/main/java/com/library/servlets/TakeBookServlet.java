package com.library.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.library.beans.RegisterBean;
import com.library.dao.BookDao;

@WebServlet("/TakeBookServlet")
public class TakeBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get user details from session
        RegisterBean user = (RegisterBean) session.getAttribute("user");
        int userId = user.getUserId();
        
        // Get book ID from request
        String bookIdParam = request.getParameter("bookId");
        
        if (bookIdParam == null || bookIdParam.isEmpty()) {
            response.sendRedirect("books.jsp?error=invalid_book");
            return;
        }
        
        try {
            int bookId = Integer.parseInt(bookIdParam);
            BookDao bookDao = new BookDao();
            
            boolean result = bookDao.takeBook(bookId, userId);
            
            if (result) {
                response.sendRedirect("books.jsp?success=book_taken");
            } else {
                response.sendRedirect("books.jsp?error=book_unavailable");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("books.jsp?error=invalid_book");
        }
    }
}
