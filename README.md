# Library Management System

## Project Overview
The Library Management System is a web-based application developed using **Java (JSP, Servlets)**, **Tomcat Server**, **MySQL Database**, **HTML**, and **CSS**. It facilitates managing library operations such as book management, user authentication, and book borrowing.

---

## Features
### Admin Features
- Add, update, search, and delete book records.
- Issue and return books.
- Manage user records.

### Student Features
- Search for books by title, author, or category.
- View available books.

---

## Technology Stack
- **Frontend:** HTML, CSS, JSP
- **Backend:** Java Servlets
- **Database:** MySQL
- **Server:** Apache Tomcat

---

## Database Setup
### MySQL Queries
```sql
CREATE DATABASE LibraryDB;

USE LibraryDB;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100),
    category VARCHAR(50),
    is_available BOOLEAN DEFAULT TRUE
);

CREATE TABLE borrowed_books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);
```

---

## Installation Guide

### Step 1: Clone the Repository
```bash
git clone https://github.com/agharsh53/library-management-system.git
```

### Step 2: Import Project
- Open the project in an IDE like **Eclipse** or **IntelliJ IDEA**.

### Step 3: Configure Database
- Import the provided SQL script to MySQL.

### Step 4: Configure Tomcat Server
- Deploy the project on **Apache Tomcat Server**.

### Step 5: Run the Project
- Access the application via `http://localhost:9090/library-management-system`.

---

## Project Snapshots

### **Login Page**
![Login Page](snapshots/login_page.png)

### **SignUp Page**
![SignUp Page](snapshots/signup_page.png)

### **Admin Dashboard**
![Admin Dashboard](snapshots/admin_dashboard.png)

### **Admin Dashboard**
![Student Dashboard](snapshots/student_dashboard.png)

### **Admin Dashboard Feature**
### **Add Book Page**
![Add Book](snapshots/addBook_page.png)

### **Update Book Page**
![Update Book](snapshots/updateBook_page.png)

### **Delete Book Page**
![Delete Book](snapshots/deleteBook_page.png)

### **Issue Book Page**
![Issue Book](snapshots/issueBook_page.png)

### **Return Book Page**
![Return Book](snapshots/returnBook_page.png)

### **Student Dashboard Feature**
#### **View Books**
![View Books](snapshots/viewBook_page.png)
#### **Search Books**
![Search Book](snapshots/searchBook_page.png)
#### **View Profile**
![View Profile](snapshots/viewProfile_page.png)

### **Logout Page**
![Logout page](snapshots/logout_page2.png)

## Project Snapshots

| Login Page              | Admin Dashboard        | Book Management        | Borrow Book         |
|------------------------|-------------------------|------------------------|---------------------|
| ![Login](snapshots/login_page.png) | ![Admin](snapshots/admin_dashboard.png) | ![Add Book](snapshots/addBook_page.png) | ![Issue Book](snapshots/issueBook_page.png) |

---

## Contributions
Contributions are welcome! Please fork this repository, create a new branch, and submit a pull request.

---

## License
This project is licensed under the **MIT License**.

---

## Maintainer
- **Name:** Harsh Kumar Agrawal 
- **Email:** agrawalharsh2653@gmail.com
