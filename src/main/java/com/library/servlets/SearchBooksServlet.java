package com.library.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SearchBooksServlet")
public class SearchBooksServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String searchKeyword = request.getParameter("search");
        
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            // Redirect to books.jsp with search parameter
            response.sendRedirect("books.jsp?search=" + searchKeyword.trim());
        } else {
            // No search term, show all books
            response.sendRedirect("books.jsp");
        }
    }
}
