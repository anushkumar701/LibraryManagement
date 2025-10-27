-- ========================================
-- Library Management System - Database Setup
-- ========================================

-- Create database
CREATE DATABASE library_db;

-- Connect to the database
\c library_db

-- ========================================
-- Table: libraryuser
-- Purpose: Store user account information
-- ========================================
CREATE TABLE libraryuser (
    userid SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phoneno VARCHAR(20) NOT NULL,
    password VARCHAR(256) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- Table: books
-- Purpose: Store book information
-- ========================================
CREATE TABLE books (
    bookid SERIAL PRIMARY KEY,
    bookname VARCHAR(200) NOT NULL,
    authorname VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    availablestatus VARCHAR(10) NOT NULL CHECK (availablestatus IN ('Yes', 'No')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- Indexes for Performance
-- ========================================

-- Indexes on books table
CREATE INDEX idx_books_name ON books(bookname);
CREATE INDEX idx_books_author ON books(authorname);
CREATE INDEX idx_books_category ON books(category);
CREATE INDEX idx_books_status ON books(availablestatus);

-- Indexes on libraryuser table
CREATE INDEX idx_user_username ON libraryuser(username);
CREATE INDEX idx_user_email ON libraryuser(email);

-- ========================================
-- Table: book_transactions
-- Purpose: Track book borrowing history
-- ========================================
CREATE TABLE book_transactions (
    transactionid SERIAL PRIMARY KEY,
    bookid INTEGER NOT NULL REFERENCES books(bookid) ON DELETE CASCADE,
    userid INTEGER NOT NULL REFERENCES libraryuser(userid) ON DELETE CASCADE,
    borrow_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    return_date TIMESTAMP,
    status VARCHAR(20) NOT NULL CHECK (status IN ('borrowed', 'returned')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for book_transactions
CREATE INDEX idx_transactions_bookid ON book_transactions(bookid);
CREATE INDEX idx_transactions_userid ON book_transactions(userid);
CREATE INDEX idx_transactions_status ON book_transactions(status);

-- ========================================
-- Sample Data (Optional)
-- ========================================

-- Insert sample books
INSERT INTO books (bookname, authorname, category, availablestatus) VALUES
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 'Yes'),
('1984', 'George Orwell', 'Fiction', 'Yes'),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 'Yes'),
('Pride and Prejudice', 'Jane Austen', 'Romance', 'Yes'),
('The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 'No'),
('Sapiens', 'Yuval Noah Harari', 'Non-Fiction', 'Yes'),
('Educated', 'Tara Westover', 'Biography', 'Yes'),
('The Alchemist', 'Paulo Coelho', 'Fiction', 'Yes'),
('Atomic Habits', 'James Clear', 'Self-Help', 'Yes'),
('Brief Answers to Big Questions', 'Stephen Hawking', 'Science', 'Yes'),
('The Da Vinci Code', 'Dan Brown', 'Mystery', 'Yes'),
('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 'Children', 'Yes'),
('A Brief History of Time', 'Stephen Hawking', 'Science', 'Yes'),
('The Power of Now', 'Eckhart Tolle', 'Self-Help', 'No'),
('Thinking, Fast and Slow', 'Daniel Kahneman', 'Non-Fiction', 'Yes'),
('The Lean Startup', 'Eric Ries', 'Technology', 'Yes'),
('Guns, Germs, and Steel', 'Jared Diamond', 'History', 'Yes'),
('The Art of War', 'Sun Tzu', 'History', 'Yes'),
('Rich Dad Poor Dad', 'Robert Kiyosaki', 'Self-Help', 'Yes'),
('The Subtle Art of Not Giving', 'Mark Manson', 'Self-Help', 'Yes');

-- ========================================
-- Verification Queries
-- ========================================

-- Count total users
SELECT COUNT(*) as total_users FROM libraryuser;

-- Count total books
SELECT COUNT(*) as total_books FROM books;

-- Count books by category
SELECT category, COUNT(*) as book_count 
FROM books 
GROUP BY category 
ORDER BY book_count DESC;

-- Count available vs unavailable books
SELECT availablestatus, COUNT(*) as count 
FROM books 
GROUP BY availablestatus;

-- ========================================
-- Useful Queries for Testing
-- ========================================

-- View all books
SELECT * FROM books ORDER BY bookid DESC;

-- View all users (passwords are hashed)
SELECT userid, username, email, phoneno, created_at FROM libraryuser;

-- Search books by name or author
SELECT * FROM books 
WHERE LOWER(bookname) LIKE LOWER('%harry%') 
   OR LOWER(authorname) LIKE LOWER('%rowling%');

-- Get books by category
SELECT * FROM books WHERE category = 'Fiction';

-- Get available books only
SELECT * FROM books WHERE availablestatus = 'Yes';

-- ========================================
-- Maintenance Queries
-- ========================================

-- Update book availability
-- UPDATE books SET availablestatus = 'No' WHERE bookid = 1;

-- Update user information
-- UPDATE libraryuser SET email = 'newemail@example.com' WHERE userid = 1;

-- Delete a book
-- DELETE FROM books WHERE bookid = 1;

-- Reset auto-increment (use with caution)
-- ALTER SEQUENCE books_bookid_seq RESTART WITH 1;
-- ALTER SEQUENCE libraryuser_userid_seq RESTART WITH 1;

-- ========================================
-- Backup Commands
-- ========================================

-- Backup database
-- pg_dump library_db > library_db_backup.sql

-- Restore database
-- psql library_db < library_db_backup.sql

-- ========================================
-- Drop Tables (Use with extreme caution!)
-- ========================================

-- DROP TABLE IF EXISTS books CASCADE;
-- DROP TABLE IF EXISTS libraryuser CASCADE;

-- ========================================
-- Success Message
-- ========================================

SELECT 'Database setup completed successfully!' as message;
