<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Return Book</title>
    <link rel="stylesheet" href="dashboard.css">
    <link rel="stylesheet" href="userStyle.css">
    <style>
        .form-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 50vh;
    background: rgba(0, 0, 0, 0.5); /* Dark background with transparency */
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
    width: 80%;
    max-width: 300px;
    margin: auto;
}
.toolbar .active {
     background-color: #d9c8c8;
     color: rgb(18, 18, 18);
     border-radius: 10px;
     
 }
   </style>
</head>
<body style="background-image: url('admin-background.jpg'); background-size: cover; background-position: center;">
    <div class="toolbar">
        <a href="adminDashboard.jsp">Admin Dashboard</a>
        <a href="addBook.jsp">Add Books</a>
        <a href="selectBookId.jsp">Update Book</a>
        <a href="deleteBook.jsp">Delete Book</a>
        <a href="issueBook.jsp">Issue Book</a>
        <a href="returnBook.jsp">Return Book</a>
    </div>
    <h1>Return Book</h1>
    <div class="form-container">
        <h1>Return a Book</h1>
        <form action="returnBookAction.jsp" method="POST">
            <div class="form-group">
                <label for="user_id">Student ID:</label>
                <input type="number" id="user_id" name="user_id" required placeholder="Enter your User ID">
            </div>
            <div class="form-group">
                <label for="book_id">Book ID:</label>
                <input type="number" id="book_id" name="book_id" required placeholder="Enter the Book ID">
            </div>
            <button type="submit" class="submit-btn">Return Book</button>
        </form>
 
    </div>
    <script src="script.js"></script>
</body>
</html>
