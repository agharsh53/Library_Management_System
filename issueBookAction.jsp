<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Issue Book</title>
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

     .success-message h2,p {
    color: #ffffff;
    font-size: 24px;
    margin-bottom: 20px;
    align-items: center;
}
    </style>
</head>
<body>
<%
    // Declare connection variable outside try block
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Retrieve form data
        String userIdStr = request.getParameter("userId");
        String bookIdStr = request.getParameter("bookId");
        String issueDateStr = request.getParameter("issueDate");
        String returnDateStr = request.getParameter("returnDate");

        // Check if any required parameter is null
        if (userIdStr == null || bookIdStr == null || issueDateStr == null || returnDateStr == null) {
%>
            <div>
                <h2>Error: All fields must be filled.</h2>
                <a href="issueBook.jsp">Go back</a>
            </div>
<%
            return; // Stop further execution if parameters are missing
        }

        // Parse the parameters
        String userId = userIdStr;
        int bookId = Integer.parseInt(bookIdStr);

        // Convert issue and return date to java.sql.Date
        java.sql.Date issueDate = java.sql.Date.valueOf(issueDateStr);
        java.sql.Date returnDate = java.sql.Date.valueOf(returnDateStr);

        // Establish connection to the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryDB", "root", "Mahadev07ji$");

        // Check if the book is available
        String checkSql = "SELECT quantity FROM books WHERE id = ?";
        stmt = conn.prepareStatement(checkSql);
        stmt.setInt(1, bookId);
        java.sql.ResultSet rs = stmt.executeQuery();

        if (rs.next() && rs.getInt("quantity") > 0) {
            // Update book quantity
            String updateBookSql = "UPDATE books SET quantity = quantity - 1 WHERE id = ?";
            stmt = conn.prepareStatement(updateBookSql);
            stmt.setInt(1, bookId);
            stmt.executeUpdate();

            // Insert borrow record
            String insertSql = "INSERT INTO borrowed_books (user_id, book_id, borrow_date, return_date) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(insertSql);
            stmt.setString(1, userId);
            stmt.setInt(2, bookId);
            stmt.setDate(3, issueDate);
            stmt.setDate(4, returnDate);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
%>
                <div class="success-message">
                    <h2>Book Issued Successfully!</h2>
                    <p>Book ID: <%= bookId %></p>
                    <p>User ID: <%= userId %></p>
                    <p>Issue Date: <%= issueDate %></p>
                    <p>Return Date: <%= returnDate %></p>
                    <a href="adminDashboard.jsp" class="back-button">Go back to Dashboard</a>
                </div>
<%
            } else {
%>
                <div class="error-message">
                    <h2>Error: Could not issue book.</h2>
                    <a href="issueBook.jsp">Try Again</a>
                </div>
<%
            }
        } else {
%>
            <div class="error-message">
                <h2>Error: Book is not available for issuing.</h2>
                <a href="issueBook.jsp">Try Again</a>
            </div>
<%
        }
    } catch (Exception e) {
%>
        <div>
            <h2>Error: <%= e.getMessage() %></h2>
            <a href="issueBook.jsp">Try Again</a>
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
