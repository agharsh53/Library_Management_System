<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Book</title>
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>
<%
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String category = request.getParameter("category");
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    String description = request.getParameter("description");

    // Declare connection variable outside the try block
    Connection conn = null;

    try {
        // Establish DB connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryDB", "root", "Mahadev07ji$");

        // Prepare SQL query
        String sql = "INSERT INTO books (title, author, category, quantity, description) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        
        stmt.setString(1, title);
        stmt.setString(2, author);
        stmt.setString(3, category);
        stmt.setInt(4, quantity);
        stmt.setString(5, description);

        // Execute the update
        int rowsInserted = stmt.executeUpdate();
        
        if (rowsInserted > 0) {
          %>
          <div class="success-message">
               <h2>Book Added Successfully!</h2>
               <a href="adminDashboard.jsp" class="back-button">Go back to Dashboard</a>
           </div>
<%
       } else {
%>
           <div class="error-message">
               <h2>Error: Book Insertion Failed</h2>
               <a href="addBook.jsp" class="back-button">Try Again</a>
           </div>
<%
       }
   } catch (Exception e) {
%>
       <div class="error-message">
           <h2>Error: <%= e.getMessage() %></h2>
           <a href="addBook.jsp" class="back-button">Try Again</a>
       </div>
<%
   } finally {
       try {
           if (conn != null) conn.close(); // This will now work, as conn is declared outside try block
       } catch (SQLException e) {
           out.println("<h2>Error closing resources: " + e.getMessage() + "</h2>");
       }
   }
%>
</body>
</html>