# Dear Diary

**Dear Diary** is a secure, web-based journaling application designed to provide users with a private and aesthetically pleasing platform for self-reflection and personal growth. The application allows users to securely log in, add diary entries, view and manage their entries, and log out, ensuring data integrity and user privacy.

---

## Features

- **User Authentication:**
  - Secure login and signup functionality with password protection.
- **Diary Management:**
  - Add, view, and manage diary entries with timestamps for chronological organization.
- **Session Management:**
  - Persistent sessions for logged-in users and secure logout functionality.
- **Error Handling:**
  - User-friendly error messages for validation and system errors.
- **Database Integration:**
  - Seamless CRUD operations for users and diary entries using MySQL with JDBC.

---

## Project Structure

### 1. Backend
- **Java Classes:**
  - `DBConnection.java`: Manages database connections and SQL queries.
  - `TestDBConnection.java`: Utility class for testing database connectivity.

### 2. Web Interface
- **JSP Pages:**
  - `index.jsp`: Landing page.
  - `login.jsp` & `loginProcess.jsp`: User authentication.
  - `Signup.jsp` & `SignupProcess.jsp`: User registration.
  - `addEntries.jsp`: Add new diary entries.
  - `viewEntries.jsp`: View existing diary entries.
  - `logout.jsp`: Securely log out users.
- **CSS:**
  - `style.css`: Global styling.
  - `stylelogin.css`, `styleAddEntries.css`, `styleViewEntries.css`: Page-specific styles.

### 3. Database
- **Tables:**
  - `Users`: Stores user credentials.
  - `DiaryEntries`: Stores diary entries with titles, content, and timestamps.

---

## Getting Started

### 1. Prerequisites
- **Java Development Kit (JDK)**
- **Eclipse IDE**
- **Apache Tomcat Server**
- **MySQL Database**

### 2. Installation Steps

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd Dear-Diary
   ```

2. **Configure the database:**
   - Create a MySQL database named `dear_diary`.
   - Run the following SQL script to create required tables:

   ```sql
   CREATE TABLE Users (
       user_id INT AUTO_INCREMENT PRIMARY KEY,
       username VARCHAR(50) UNIQUE NOT NULL,
       password VARCHAR(50) NOT NULL
   );

   CREATE TABLE DiaryEntries (
       entry_id INT AUTO_INCREMENT PRIMARY KEY,
       user_id INT,
       title VARCHAR(255) NOT NULL,
       content TEXT NOT NULL,
       created_at DATE NOT NULL,
       FOREIGN KEY (user_id) REFERENCES Users(user_id)
   );
   ```

3. **Update database connection settings** in `DBConnection.java`:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/dear_diary";
   private static final String USER = "your_mysql_username";
   private static final String PASSWORD = "your_mysql_password";
   ```

4. **Deploy the project in Eclipse IDE:**
   - Import the project as a **Dynamic Web Project**.
   - Add the project to the Apache Tomcat server.

5. **Start the server** and access the application at:
   ```
   http://localhost:8080/Dear-Diary/
   ```

---

## Usage

1. **Sign Up:**
   - Create an account using the signup page.

2. **Log In:**
   - Use your credentials to log in.

3. **Add Entries:**
   - Navigate to the "Add Entry" page to document your thoughts.

4. **View Entries:**
   - Access all saved entries on the "View Entries" page.

5. **Log Out:**
   - Securely log out to end the session.

---

## Error Handling

- Displays meaningful error messages for:
  - Invalid login credentials.
  - Empty fields during signup or entry creation.
  - Database connection issues.
- Logs system errors for debugging purposes.

---

## Future Enhancements

- **Password Encryption:** Implement hashing for secure password storage.
- **Advanced Features:** Add search, tagging, and editing functionality for diary entries.
- **Mobile-Friendly Design:** Optimize the interface for better usability on mobile devices.

---


## Contributors

- **[Aayushi Jain]** - Developer

---

## Support

If you encounter any issues or have questions about the Dear Diary application, please feel free to reach out or create an issue in the repository.

---

*Happy Journaling! 📖✨*
