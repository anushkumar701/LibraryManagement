package com.library.util;

public class InputSanitizer {

    /**
     * Sanitize input by removing dangerous tags & characters
     */
    public static String sanitize(String input) {
        if (input == null) return null;

        // Remove all HTML tags
        String sanitized = input.replaceAll("<[^>]*>", "");

        // Remove any <script> tags and their content
        sanitized = sanitized.replaceAll("(?i)<script.*?>.*?</script>", "");

        // Remove SQL keywords that may be malicious
        sanitized = sanitized.replaceAll("(?i)(drop|delete|insert|update|create|alter|exec|execute)\\s", "");

        // Remove common injection characters
        sanitized = sanitized.replaceAll("[;&|`$]", "");

        // Trim leading and trailing spaces
        return sanitized.trim();
    }

    /**
     * Validate username:
     * - Start with a letter
     * - 5–15 characters
     * - Can contain letters, numbers, dot, underscore
     */
    public static boolean isValidUsername(String username) {
        if (username == null) return false;
        return username.matches("^[A-Za-z][A-Za-z0-9._]{4,14}$");
    }

    /**
     * Validate email:
     * - Must be a valid email format
     */
    public static boolean isValidEmail(String email) {
        if (email == null) return false;
        return email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");
    }

    /**
     * Validate phone number:
     * - Must include country code (e.g., +911234567890)
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null) return false;
        return phone.matches("^\\+\\d{1,3}\\d{7,12}$");
    }

    /**
     * Validate strong password:
     * - At least 8 characters
     * - At least 1 uppercase, 1 lowercase, 1 digit, 1 special character
     */
    public static boolean isStrongPassword(String password) {
        if (password == null) return false;
        return password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$");
    }
}
