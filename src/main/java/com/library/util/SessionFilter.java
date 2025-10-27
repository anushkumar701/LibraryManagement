package com.library.util;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/home.jsp", "/books.jsp", "/manage-books.jsp", "/profile.jsp", 
                          "/update-book.jsp", "/change-password.jsp"})
public class SessionFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {}
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        // Check if user is logged in
        if(session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect("login.jsp?error=session_expired");
            return;
        }
        
        // User is logged in, continue
        chain.doFilter(request, response);
    }
    
    public void destroy() {}
}
