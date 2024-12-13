<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Book</title>
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
     padding: 20px;
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
        <h1>Delete Book</h1>

        <%
            String bookIdParam = request.getParameter("id");
            if (bookIdParam == null || bookIdParam.isEmpty()) {
                // Step 1: Ask the user to input the book ID to delete
        %>
            <form action="deleteBook.jsp" method="get" class="book-form">
                <div class="form-group">
                    <label for="id">Enter Book ID to Delete:</label>
                    <input type="number" id="id" name="id" required placeholder="Enter Book ID">
                </div>
                <button type="submit" class="submit-btn">Delete Book</button>
            </form>
        <%
            } else {
                // Step 2: Process the book deletion after ID submission
                int bookId = Integer.parseInt(bookIdParam);
                Connection con = null;
                PreparedStatement ps = null;

                try {
                    // Load MySQL Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Connect to the database
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryDB", "root", "Mahadev07ji$");

                    // Create SQL query for deleting the book
                    String sql = "DELETE FROM Books WHERE id = ?";

                    // Prepare statement to prevent SQL Injection
                    ps = con.prepareStatement(sql);
                    ps.setInt(1, bookId);

                    // Execute the delete
                    int rowsAffected = ps.executeUpdate();

                    if (rowsAffected > 0) {
        %>
                        <div class="success-message">
                            <h2>Book Deleted Successfully!</h2>
                            <a href="adminDashboard.jsp" class="back-button">Go back to Dashboard</a>
                        </div>
        <%
                    } else {
        %>
                        <div class="error-message">
                            <h2>Error: Book Deletion Failed. ID not found.</h2>
                            <a href="deleteBook.jsp" class="back-button">Try Again</a>
                        </div>
        <%
                    }
                } catch (Exception e) {
        %>
        <div class="error-message">
          <h2>Error: <%= e.getMessage() %></h2>
          <a href="deleteBook.jsp" class="back-button">Try Again</a>
      </div>
        <%
                } finally {
                    try {
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        out.println("<h2>Error closing resources: " + e.getMessage() + "</h2>");
                    }
                }
            }
        %>
    </div>
    <script src="script.js"></script>
</body>
</html>
