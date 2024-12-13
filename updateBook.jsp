<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Book</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        .form-container {
     display: flex;
     flex-direction: column;
     align-items: center;
     justify-content: center;
     min-height: 80vh;
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
<body>
    <div class="form-container">
        <h1 >Update Book</h1>
        <%
            // Get the book ID from the request
            String bookIdParam = request.getParameter("id");
            
            // Check if the book ID is passed and valid
            if (bookIdParam == null || bookIdParam.isEmpty()) {
                out.println("<h2>Error: Missing book ID</h2>");
                return;
            }

            // Parse the ID to an integer
            int bookId = Integer.parseInt(bookIdParam);

            // Debugging line to show the book ID passed
            out.println("<p>Book ID: " + bookId + "</p>");

            // Database connection and retrieval of book data
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            String title = "", author = "", category = "", description = "";
            int quantity = 0;

            try {
                // Load JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection to the database
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryDB", "root", "Mahadev07ji$");

                // Create SQL statement
                stmt = con.createStatement();

                // Query to fetch the book data
                rs = stmt.executeQuery("SELECT * FROM Books WHERE id = " + bookId);

                // If the book is found, retrieve the details
                if (rs.next()) {
                    title = rs.getString("title");
                    author = rs.getString("author");
                    category = rs.getString("category");
                    quantity = rs.getInt("quantity");
                    description = rs.getString("description");
                }
            } catch (Exception e) {
                out.println("<h2>Error: " + e.getMessage() + "</h2>");
            } finally {
                // Close resources
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
                } catch (SQLException se) {
                    out.println("<h2>Error closing resources: " + se.getMessage() + "</h2>");
                }
            }
        %>

        <form action="updateBookAction.jsp" method="post">
          <!-- Hidden input to send the book ID -->
          <input type="hidden" name="bookId" value="<%= bookId %>">
          
          <div class="form-group">
              <label for="title">Book Title:</label>
              <input type="text" id="title" name="title" value="<%= title %>" required>
          </div>
          
          <div class="form-group">
              <label for="author">Author:</label>
              <input type="text" id="author" name="author" value="<%= author %>" required>
          </div>
          
          <div class="form-group">
              <label for="category">Category:</label>
              <input type="text" id="category" name="category" value="<%= category %>" required>
          </div>
          
          <div class="form-group">
              <label for="quantity">Quantity:</label>
              <input type="number" id="quantity" name="quantity" value="<%= quantity %>" required>
          </div>
          
          <div class="form-group">
              <label for="description">Description:</label>
              <textarea id="description" name="description" required><%= description %></textarea>
          </div>
          
          <button type="submit" class="btn">Update Book</button>
      </form>
      

    </div>
</body>
</html>
