<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Book ID to Update</title>
    <link rel="stylesheet" href="dashboard.css">
    <link rel="stylesheet" href="userStyle.css">
    <style>
        .form-container {
     display: flex;
     flex-direction: column;
     align-items: center;
     justify-content: center;
     min-height: 60vh;
     background: rgba(0, 0, 0, 0.5); /* Dark background with transparency */
     padding: 30px;
     border-radius: 10px;
     box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
     width: 80%;
     max-width: 380px;
     margin: auto;
     margin-top: 20px;
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
    <div class="form-container">
        <h1>Select Book ID to Update</h1>
        <form action="updateBook.jsp" method="get" class="book-form">
            <div class="form-group">
                <label for="bookId">Enter Book ID:</label>
                <input type="number" id="bookId" name="id" required>
            </div>
            <button type="submit" class="submit-btn">Go to Update Book</button>
        </form>
    </div>
    <script src="script.js"></script>
</body>
</html>
