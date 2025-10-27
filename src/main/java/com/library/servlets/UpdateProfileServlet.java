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
import com.library.util.InputSanitizer;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        RegisterBean user = (RegisterBean) session.getAttribute("user");
        
        // Get and sanitize form data
        String username = InputSanitizer.sanitize(request.getParameter("username"));
        String email = InputSanitizer.sanitize(request.getParameter("email"));
        String phoneno = InputSanitizer.sanitize(request.getParameter("phoneno"));
        
        // Validation
        if(username == null || username.trim().isEmpty()) {
            response.sendRedirect("profile.jsp?msg=empty_username");
            return;
        }
        
        if(email == null || email.trim().isEmpty()) {
            response.sendRedirect("profile.jsp?msg=empty_email");
            return;
        }
        
        if(phoneno == null || phoneno.trim().isEmpty()) {
            response.sendRedirect("profile.jsp?msg=empty_phone");
            return;
        }
        
        // Validate formats
        if(!InputSanitizer.isValidUsername(username)) {
            response.sendRedirect("profile.jsp?msg=invalid_username");
            return;
        }
        
        if(!InputSanitizer.isValidEmail(email)) {
            response.sendRedirect("profile.jsp?msg=invalid_email");
            return;
        }
        
        if(!InputSanitizer.isValidPhone(phoneno)) {
            response.sendRedirect("profile.jsp?msg=invalid_phone");
            return;
        }
        
        // Update user object
        user.setUsername(username);
        user.setEmail(email);
        user.setPhoneNo(phoneno);
        
        // Update in database
        RegisterDao dao = new RegisterDao();
        boolean result = dao.updateUser(user);
        
        if(result) {
            // Update session
            session.setAttribute("user", user);
            response.sendRedirect("profile.jsp?msg=updated");
        } else {
            response.sendRedirect("profile.jsp?msg=error");
        }
    }
}
