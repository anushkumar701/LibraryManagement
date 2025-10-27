# 🚀 Quick Start Guide - Library Management System

## Step 1: Database Setup (5 minutes)

### Option A: Using Command Line
```bash
# Login to PostgreSQL
psql -U postgres

# Run the setup script
\i C:/Users/anush/eclipse-workspace/LibrarySystem/database_setup.sql
```

### Option B: Using pgAdmin
1. Open pgAdmin
2. Right-click on "Databases" → Create → Database
3. Name it "library_db"
4. Open Query Tool
5. Copy and paste contents of `database_setup.sql`
6. Execute the script (F5)

## Step 2: Update Database Credentials (2 minutes)

Edit: `src/main/java/com/library/util/DBConnection.java`

```java
private static final String URL = "jdbc:postgresql://localhost:5432/library_db";
private static final String USERNAME = "postgres";  // Change this
private static final String PASSWORD = "godhand";   // Change this to your password
```

## Step 3: Deploy to Tomcat (3 minutes)

### Using Eclipse:
1. Right-click on project
2. Run As → Run on Server
3. Select "Tomcat v9.0 Server"
4. Click Finish

### Manual Deployment:
1. Export project as WAR file
2. Copy WAR to Tomcat's webapps folder
3. Start Tomcat server

## Step 4: Access the Application

Open browser and navigate to:
```
http://localhost:8080/LibrarySystem/
```

## Step 5: Create Your First Account

1. Click "Register" button
2. Fill in the form:
   - **Username**: johnsmith (5-15 chars, starts with letter)
   - **Email**: john@example.com
   - **Phone**: +911234567890 (with country code)
   - **Password**: JohnSmith@123 (strong password required)
3. Click "Register Now"
4. Login with your credentials

## Step 6: Add Your First Book

1. After login, go to "Manage Books"
2. Fill in book details:
   - Book Name: The Great Gatsby
   - Author: F. Scott Fitzgerald
   - Category: Fiction
   - Status: Available
3. Click "Add Book"

## 🎉 You're All Set!

### Quick Feature Tour:

1. **Browse Books** - View all books with search
2. **Manage Books** - Add, Update, Delete books
3. **Profile** - Update your information
4. **Change Password** - Secure password management

## 🔧 Troubleshooting

### Problem: Can't connect to database
**Solution**: 
- Check if PostgreSQL is running
- Verify credentials in DBConnection.java
- Test connection: `psql -U postgres -d library_db`

### Problem: 404 Error
**Solution**:
- Verify Tomcat is running
- Check project is deployed
- Clear Tomcat work directory

### Problem: Compilation Errors
**Solution**:
- Clean and rebuild project
- Verify all JAR files are in WEB-INF/lib
- Check Java version compatibility

### Problem: Session Timeout
**Solution**:
- This is normal after inactivity
- Simply login again
- Adjust timeout in web.xml if needed

## 📚 Sample Test Data

The database setup script includes 20 sample books. You can:
- Browse them immediately after login
- Search for specific books
- Update or delete them as needed

## 🔐 Security Notes

- All passwords are hashed with SHA-256
- Never share database credentials
- Use strong passwords for production
- Enable HTTPS in production environment

## 📞 Need Help?

Check the main README.md file for detailed documentation!

---

**Happy Reading! 📖**
