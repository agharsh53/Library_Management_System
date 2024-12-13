<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Book</title>
    <link rel="stylesheet" href="dashboard.css">
    <link rel="stylesheet" href="userStyle.css">
    <style>
        .form-container {
     display: flex;
     flex-direction: column;
     align-items: center;
     justify-content: center;
     min-height: 90vh;
     background: rgba(0, 0, 0, 0.5); /* Dark background with transparency */
     padding: 20px;
     border-radius: 10px;
     box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
     width: 80%;
     max-width: 380px;
     margin: auto;
     margin-top: 10px;
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
       
        <h1>Add Book</h1>
        <form action="addBookAction.jsp" method="POST" class="book-form">
            <div class="form-group">
                <label for="title">Book Title:</label>
                <input type="text" id="title" name="title" required>
            </div>
            
            <div class="form-group">
                <label for="author">Author:</label>
                <input type="text" id="author" name="author" required>
            </div>
            
            <div class="form-group">
                <label for="category">Category:</label>
                <input type="text" id="category" name="category" required>
            </div>
            
            <div class="form-group">
                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" required>
            </div>
            
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="4" required></textarea>
            </div>

            <button type="submit" class="submit-btn">Add Book</button>
        </form>
    </div>
    <script src="script.js"></script>
</body>
</html>
