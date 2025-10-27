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

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        RegisterBean user = (RegisterBean) session.getAttribute("user");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validation
        if(oldPassword == null || oldPassword.trim().isEmpty()) {
            response.sendRedirect("change-password.jsp?error=empty_old");
            return;
        }
        
        if(newPassword == null || newPassword.trim().isEmpty()) {
            response.sendRedirect("change-password.jsp?error=empty_new");
            return;
        }
        
        if(!newPassword.equals(confirmPassword)) {
            response.sendRedirect("change-password.jsp?error=mismatch");
            return;
        }
        
        // Password strength validation
        if(!newPassword.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$")) {
            response.sendRedirect("change-password.jsp?error=weak");
            return;
        }
        
        // Update password
        RegisterDao dao = new RegisterDao();
        boolean updated = dao.updatePassword(user.getUserId(), oldPassword, newPassword);
        
        if(updated) {
            response.sendRedirect("change-password.jsp?success=1");
        } else {
            response.sendRedirect("change-password.jsp?error=incorrect_old");
        }
    }
}
