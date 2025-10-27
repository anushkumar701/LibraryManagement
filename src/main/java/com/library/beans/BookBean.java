package com.library.beans;

public class BookBean {
    private int bookId;
    private String bookName;
    private String authorName;
    private String availableStatus;
    private String category;
    
    // New fields for Take Book feature
    private boolean issued; // true if book is borrowed
    private int issuedTo;   // userId of the borrower

    // Empty constructor
    public BookBean() {}

    // Getters and Setters
    public int getBookId() { 
        return bookId; 
    }
    public void setBookId(int bookId) { 
        this.bookId = bookId; 
    }
    public String getBookName() { 
        return bookName; 
    }
    public void setBookName(String bookName) { 
        this.bookName = bookName; 
    }
    public String getAuthorName() { 
        return authorName; 
    }
    public void setAuthorName(String authorName) { 
        this.authorName = authorName; 
    }
    public String getAvailableStatus() { 
        return availableStatus; 
    }
    public void setAvailableStatus(String availableStatus) { 
        this.availableStatus = availableStatus; 
    }
    public String getCategory() { 
        return category; 
    }
    public void setCategory(String category) { 
        this.category = category; 
    }

    // New getters and setters
    public boolean isIssued() { 
        return issued; 
    }
    public void setIssued(boolean issued) { 
        this.issued = issued; 
    }
    public int getIssuedTo() { 
        return issuedTo; 
    }
    public void setIssuedTo(int issuedTo) { 
        this.issuedTo = issuedTo; 
    }
}
