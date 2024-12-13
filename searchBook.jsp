<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Books</title>
    <link rel="stylesheet" href="dashboard.css">
    <link rel="stylesheet" href="userStyle.css">
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
     margin-top: 10px;
 }
 .toolbar .active {
     background-color: #d9c8c8;
     color: rgb(18, 18, 18);
     border-radius: 10px;
     
 }
    </style>
</head>
<body style="background-image: url('user-background.jpg'); background-size: cover; background-position: center;">
    <div class="toolbar">
        <a href="userDashboard.jsp">Student Dashboard</a>
        <a href="viewBooks.jsp">View Books</a>
        <a href="searchBook.jsp">Search Book</a>
        <a href="viewProfile.jsp">View Profile</a>
    </div>
    <div class="form-container">
        
        
        <!-- Search Form -->
        <h1>Search Books</h1>
        <form action="searchBookAction.jsp" method="POST" class="book-form">
            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" id="title" name="title">
            </div>
            
            <div class="form-group">
                <label for="author">Author:</label>
                <input type="text" id="author" name="author">
            </div>
            
            <div class="form-group">
                <label for="category">Category:</label>
                <input type="text" id="category" name="category">
            </div>

            <button type="submit" class="submit-btn">Search</button>
        </form>
    </div>

    <!-- Display Search Results -->
    <div class="search-results">
        <%
            // Fetch search criteria
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String category = request.getParameter("category");

            // Establish DB connection
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Initialize DB connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryDB", "root", "Mahadev07ji$");

                // Prepare the SQL query with the dynamic conditions
                String sql = "SELECT * FROM books WHERE 1=1";
                if (title != null && !title.isEmpty()) {
                    sql += " AND title LIKE ?";
                }
                if (author != null && !author.isEmpty()) {
                    sql += " AND author LIKE ?";
                }
                if (category != null && !category.isEmpty()) {
                    sql += " AND category LIKE ?";
                }

                stmt = conn.prepareStatement(sql);

                // Set parameters dynamically based on the search criteria
                int paramIndex = 1;
                if (title != null && !title.isEmpty()) {
                    stmt.setString(paramIndex++, "%" + title + "%");
                }
                if (author != null && !author.isEmpty()) {
                    stmt.setString(paramIndex++, "%" + author + "%");
                }
                if (category != null && !category.isEmpty()) {
                    stmt.setString(paramIndex++, "%" + category + "%");
                }

                // Execute query and fetch results
                rs = stmt.executeQuery();
                
                if (rs.next()) {
                    out.println("<table class='results-table'>");
                    out.println("<tr><th>Book Id</th><th>Title</th><th>Author</th><th>Category</th><th>Quantity</th><th>Description</th></tr>");
                    do {
                        out.println("<tr>");
                        out.println("<td>" + rs.getInt("id") + "</td>");
                        out.println("<td>" + rs.getString("title") + "</td>");
                        out.println("<td>" + rs.getString("author") + "</td>");
                        out.println("<td>" + rs.getString("category") + "</td>");
                        out.println("<td>" + rs.getInt("quantity") + "</td>");
                        out.println("<td>" + rs.getString("description") + "</td>");
                        out.println("</tr>");
                    } while (rs.next());
                    out.println("</table>");
                } else {
                    out.println("<p>No books found matching the criteria.</p>");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
    <script src="script.js"></script>
</body>
</html>
