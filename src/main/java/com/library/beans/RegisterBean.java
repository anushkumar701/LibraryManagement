package com.library.beans;

public class RegisterBean {
    private int userId;
    private String username;
    private String email;
    private String phoneNo;
    private String password;
    
    public RegisterBean() {}

    public boolean validate() {
        if (username == null || username.trim().isEmpty()) return false;
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) return false;
        if (phoneNo == null || !phoneNo.matches("\\+\\d{1,3}\\d{7,12}")) return false;
        if (password == null || password.length() < 8) return false;
        return true;
    }

    // Getters and setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhoneNo() { return phoneNo; }
    public void setPhoneNo(String phoneNo) { this.phoneNo = phoneNo; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
