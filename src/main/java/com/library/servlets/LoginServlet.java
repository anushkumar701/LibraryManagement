package com.library.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.library.beans.RegisterBean;
import com.library.dao.RegisterDao;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Form data edukradhu
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Database check panradhu
        RegisterDao dao = new RegisterDao();
        RegisterBean user = dao.validateUser(username, password);
        
        if(user != null) {
            // Login success - Session create pannu
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            
            // Home page ku po
            response.sendRedirect("home.jsp");
        } else {
            // Login failed - error kaatu
            response.sendRedirect("login.jsp?error=1");
        }
    }
}