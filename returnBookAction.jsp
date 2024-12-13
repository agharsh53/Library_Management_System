<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Return Book</title>
    <link rel="stylesheet" href="dashboard.css">
    <style>
        .success-message, .error-message {
            background-color: rgba(45, 44, 44, 0.8);
            padding: 20px;
            margin-top: 20px;
            border-radius: 22px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 400px;
            margin-left: 400px;
        }

        .success-message h2, p {
            color: #ffffff;
            font-size: 24px;
            margin-bottom: 20px;
            align-items: center;
        }

        .error-message h2 {
            color: #ff4d4d;
            font-size: 24px;
            margin-bottom: 20px;
            align-items: center;
        }

        .back-button {
            color: #fff;
            background-color: #007bff;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%
    // Declare connection variable outside try block
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Retrieve form data using correct parameter names
        String userIdStr = request.getParameter("user_id");
        String bookIdStr = request.getParameter("book_id");

        // Debugging output to ensure parameters are being passed
        out.println("userId: " + userIdStr);
        out.println("bookId: " + bookIdStr);

        // Check if any required parameter is null or empty
        if (userIdStr == null || bookIdStr == null || userIdStr.isEmpty() || bookIdStr.isEmpty()) {
%>
            <div class="error-message">
                <h2>Error: All fields must be filled.</h2>
                <a href="returnBook.jsp" class="back-button">Go back</a>
            </div>
<%
            return; // Stop further execution if parameters are missing
        }

        // Parse the parameters
        int userId = Integer.parseInt(userIdStr);
        int bookId = Integer.parseInt(bookIdStr);

        // Establish connection to the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryDB", "root", "Mahadev07ji$");

        // Check if the borrow record exists in borrowed_books table
        String checkSql = "SELECT * FROM borrowed_books WHERE user_id = ? AND book_id = ? ";
        stmt = conn.prepareStatement(checkSql);
        stmt.setInt(1, userId);
        stmt.setInt(2, bookId);
        java.sql.ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            // Remove the record from borrowed_books table
            String deleteSql = "DELETE FROM borrowed_books WHERE user_id = ? AND book_id = ?";
            stmt = conn.prepareStatement(deleteSql);
            stmt.setInt(1, userId);
            stmt.setInt(2, bookId);
            stmt.executeUpdate();

            // Update the book quantity in books table
            String updateBookSql = "UPDATE books SET quantity = quantity + 1 WHERE id = ?";
            stmt = conn.prepareStatement(updateBookSql);
            stmt.setInt(1, bookId);
            stmt.executeUpdate();

%>
            <div class="success-message">
                <h2>Book Returned Successfully!</h2>
                <p>Book ID: <%= bookId %></p>
                <p>User ID: <%= userId %></p>
                <a href="adminDashboard.jsp" class="back-button">Go back to Dashboard</a>
            </div>
<%
        } else {
%>
            <div class="error-message">
                <h2>Error: No record found for the borrowed book.</h2>
                <a href="returnBook.jsp" class="back-button">Try Again</a>
            </div>
<%
        }
    } catch (Exception e) {
%>
        <div class="error-message">
            <h2>Error: <%= e.getMessage() %></h2>
            <a href="returnBook.jsp" class="back-button">Try Again</a>
        </div>
<%
    } finally {
        // Close resources
        try {
            if (conn != null) conn.close();
            if (stmt != null) stmt.close();
        } catch (SQLException e) {
            out.println("<h2>Error closing resources: " + e.getMessage() + "</h2>");
        }
    }
%>
</body>
</html>
