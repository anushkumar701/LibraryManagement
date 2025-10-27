# 📚 Library Management System

A complete web-based Library Management System built with Java, JSP, Servlets, and PostgreSQL.

## ✨ Features

### User Management
- ✅ **User Registration** with strong validation
  - Username validation (5-15 characters, starts with letter)
  - Email validation (proper email format)
  - Phone validation (with country code)
  - Strong password requirements (8+ chars, uppercase, lowercase, number, special char)
- ✅ **Secure Login** with SHA-256 password hashing
- ✅ **User Profile Management**
  - View and update profile information
  - Change password with old password verification
- ✅ **Session Management** with automatic timeout protection

### Book Management
- ✅ **Add New Books** with category support
- ✅ **Update Book Information**
- ✅ **Delete Books** with confirmation
- ✅ **View All Books** in organized table format
- ✅ **Search Books** by name or author
- ✅ **Book Categories**: Fiction, Non-Fiction, Science, Technology, History, Biography, Self-Help, Education, Children, Mystery, Romance, Other
- ✅ **Availability Status** tracking (Available/Not Available)

### Security Features
- 🔒 **Password Hashing** (SHA-256)
- 🔒 **SQL Injection Protection** with prepared statements
- 🔒 **Input Sanitization** to prevent XSS attacks
- 🔒 **Session-based Authentication**
- 🔒 **Server-side Validation** for all inputs
- 🔒 **Session Filter** to protect authenticated pages

### UI/UX Features
- 📱 **Responsive Design** - works on all devices
- 🎨 **Modern UI** with gradient backgrounds
- ✅ **Success/Error Messages** with auto-hide
- 🔍 **Live Search** functionality
- 📊 **Clear Status Badges** for book availability
- 🎯 **User-friendly Navigation**

## 🛠️ Technology Stack

- **Backend**: Java (Servlets, JSP)
- **Database**: PostgreSQL
- **Server**: Apache Tomcat
- **Frontend**: HTML5, CSS3, JavaScript
- **Build Tool**: Eclipse/Maven

## 📋 Prerequisites

- Java JDK 8 or higher
- Apache Tomcat 9.x
- PostgreSQL 12 or higher
- Eclipse IDE (or any Java IDE)

## 🚀 Installation & Setup

### 1. Database Setup

```sql
-- Create database
CREATE DATABASE library_db;

-- Connect to database
\c library_db

-- Create users table
CREATE TABLE libraryuser (
    userid SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phoneno VARCHAR(20) NOT NULL,
    password VARCHAR(256) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create books table
CREATE TABLE books (
    bookid SERIAL PRIMARY KEY,
    bookname VARCHAR(200) NOT NULL,
    authorname VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    availablestatus VARCHAR(10) NOT NULL CHECK (availablestatus IN ('Yes', 'No')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX idx_books_name ON books(bookname);
CREATE INDEX idx_books_author ON books(authorname);
CREATE INDEX idx_books_category ON books(category);
CREATE INDEX idx_user_username ON libraryuser(username);
CREATE INDEX idx_user_email ON libraryuser(email);
```

### 2. Update Database Configuration

Edit `src/main/java/com/library/util/DBConnection.java`:

```java
private static final String URL = "jdbc:postgresql://localhost:5432/library_db";
private static final String USERNAME = "your_postgres_username";
private static final String PASSWORD = "your_postgres_password";
```

### 3. Deploy to Tomcat

1. Right-click on project → Run As → Run on Server
2. Select Apache Tomcat server
3. Access application at: `http://localhost:8080/LibrarySystem/`

## 📁 Project Structure

```
LibrarySystem/
├── src/main/java/com/library/
│   ├── beans/
│   │   ├── BookBean.java          # Book entity
│   │   └── RegisterBean.java      # User entity
│   ├── dao/
│   │   ├── BookDao.java            # Book database operations
│   │   └── RegisterDao.java       # User database operations
│   ├── servlets/
│   │   ├── AddBookServlet.java
│   │   ├── UpdateBookServlet.java
│   │   ├── DeleteBookServlet.java
│   │   ├── RegisterServlet.java
│   │   ├── LoginServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── UpdateProfileServlet.java
│   │   ├── ChangePasswordServlet.java
│   │   └── SearchBooksServlet.java
│   └── util/
│       ├── DBConnection.java       # Database connection
│       ├── InputSanitizer.java     # Input validation & sanitization
│       └── SessionFilter.java      # Session management filter
├── src/main/webapp/
│   ├── index.jsp                   # Landing page
│   ├── register.jsp                # Registration page
│   ├── login.jsp                   # Login page
│   ├── home.jsp                    # Dashboard
│   ├── books.jsp                   # View all books
│   ├── manage-books.jsp            # Manage books
│   ├── update-book.jsp             # Update book form
│   ├── profile.jsp                 # User profile
│   ├── change-password.jsp         # Change password
│   ├── about.jsp                   # About page
│   └── WEB-INF/
│       ├── web.xml                 # Deployment descriptor
│       └── lib/
│           └── postgresql-42.7.8.jar
└── README.md
```

## 🔐 Security Implementation

### Password Security
- All passwords are hashed using SHA-256 before storage
- No plain text passwords stored in database
- Password strength requirements enforced

### Input Validation
- Server-side validation for all user inputs
- Client-side validation for better UX
- Input sanitization to prevent XSS attacks

### SQL Injection Prevention
- All database queries use PreparedStatement
- No string concatenation in SQL queries
- Proper parameter binding

### Session Security
- Session timeout implementation
- Protected pages require authentication
- Automatic redirect on session expiry

## 📱 Pages & Features

### Public Pages
- **Landing Page** (`index.jsp`) - Welcome page with features
- **Register** (`register.jsp`) - User registration with validation
- **Login** (`login.jsp`) - Secure login
- **About** (`about.jsp`) - Information about the library

### Protected Pages (Requires Login)
- **Home Dashboard** (`home.jsp`) - Quick access to all features
- **Browse Books** (`books.jsp`) - View and search books
- **Manage Books** (`manage-books.jsp`) - Add, update, delete books
- **Profile** (`profile.jsp`) - View and update profile
- **Change Password** (`change-password.jsp`) - Update password securely

## 🎨 UI Features

- Gradient backgrounds for modern look
- Responsive grid layouts
- Hover effects and transitions
- Status badges for book availability
- Auto-hiding success/error messages
- Mobile-friendly navigation
- Clear visual feedback for user actions

## ⚡ Performance Optimizations

- Database indexes on frequently queried columns
- Connection pooling ready architecture
- Efficient SQL queries with prepared statements
- Minimal JavaScript for faster page loads
- CSS-only animations where possible

## 🧪 Testing

### Test User Registration
1. Navigate to register page
2. Enter valid credentials
3. Verify success message
4. Try login with created account

### Test Book Management
1. Login to system
2. Navigate to Manage Books
3. Add a new book with all fields
4. Update book information
5. Search for the book
6. Delete the book

### Test Security
1. Try accessing protected pages without login
2. Test SQL injection in search
3. Test XSS in form inputs
4. Verify password hashing in database

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Verify PostgreSQL is running
   - Check database credentials in DBConnection.java
   - Ensure database and tables are created

2. **404 Error**
   - Verify project is deployed to Tomcat
   - Check servlet mappings in @WebServlet annotations
   - Ensure JSP files are in correct location

3. **Session Issues**
   - Clear browser cookies
   - Restart Tomcat server
   - Check SessionFilter configuration

## 📝 Future Enhancements

- [ ] Book borrowing/return system
- [ ] Due date tracking
- [ ] Fine calculation
- [ ] Book reservation system
- [ ] Admin and user role separation
- [ ] Email notifications
- [ ] Book cover image upload
- [ ] Reading history tracking
- [ ] Book recommendations
- [ ] Export reports (PDF/Excel)

## 👨‍💻 Developer

Developed with ❤️ using Java, JSP, Servlets, and PostgreSQL

## 📄 License

This project is for educational purposes.

---

**Note**: Remember to change default passwords and add proper environment variables for production deployment!
