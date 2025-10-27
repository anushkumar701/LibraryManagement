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
import com.library.util.PasswordGenerator;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form data and sanitize
        String username = InputSanitizer.sanitize(request.getParameter("username"));
        String email = InputSanitizer.sanitize(request.getParameter("email"));
        String phoneno = InputSanitizer.sanitize(request.getParameter("phoneno"));
        
        // AUTO-GENERATE PASSWORD (as per PDF requirement)
        String password = PasswordGenerator.generatePassword();
        
        // Null checks
        if(username == null || email == null || phoneno == null) {
            response.sendRedirect("register.jsp?error=empty_fields");
            return;
        }
        
        RegisterDao dao = new RegisterDao();
        
        // Check if username already exists
        if (dao.isUsernameExists(username)) {
            response.sendRedirect("register.jsp?error=username_exists");
            return;
        }
        
        // Check if email already exists
        if (dao.isEmailExists(email)) {
            response.sendRedirect("register.jsp?error=email_exists");
            return;
        }
        
        // Server-side validation using utility
        if (!InputSanitizer.isValidUsername(username)) {
            response.sendRedirect("register.jsp?error=invalid_username");
            return;
        }
        
        if (!InputSanitizer.isValidEmail(email)) {
            response.sendRedirect("register.jsp?error=invalid_email");
            return;
        }
        
        if (!InputSanitizer.isValidPhone(phoneno)) {
            response.sendRedirect("register.jsp?error=invalid_phone");
            return;
        }
        
        // Create user bean
        RegisterBean user = new RegisterBean();
        user.setUsername(username);
        user.setEmail(email);
        user.setPhoneNo(phoneno);
        user.setPassword(password); // Auto-generated password
        
        // Save to database
        boolean result = dao.createUser(user);
        
        if(result) {
            // Store generated password in session to show to user
            HttpSession session = request.getSession();
            session.setAttribute("generatedPassword", password);
            session.setAttribute("registeredUsername", username);
            response.sendRedirect("login.jsp?registered=true");
        } else {
            response.sendRedirect("register.jsp?error=db_error");
        }
    }
}
