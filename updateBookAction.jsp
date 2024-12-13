<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String category = request.getParameter("category");
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    String description = request.getParameter("description");
    int bookId = Integer.parseInt(request.getParameter("bookId"));  // Get the book ID
    
    Connection con = null;
    PreparedStatement ps = null;

    try {
        // Load MySQL Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryDB", "root", "Mahadev07ji$");

        // Create SQL query for updating the book
        String sql = "UPDATE Books SET title = ?, author = ?, category = ?, quantity = ?, description = ? WHERE id = ?";
        
        // Prepare statement to prevent SQL Injection
        ps = con.prepareStatement(sql);
        
        // Set values from form to the query parameters
        ps.setString(1, title);
        ps.setString(2, author);
        ps.setString(3, category);
        ps.setInt(4, quantity);
        ps.setString(5, description);
        ps.setInt(6, bookId);

        // Execute the update
        int rowsAffected = ps.executeUpdate();
          if (rowsAffected > 0) {
%>
            <!-- Success message -->
            <div class="success-message">
                <h2>Book Updated Successfully!</h2>
                <a href="adminDashboard.jsp" class="btn-back">Go back to Dashboard</a>
            </div>

        <%
        } else {
%>
            <!-- Error message -->
            <div class="error-message">
                <h2>Error: Book Update Failed</h2>
                <a href="adminDashboard.jsp" class="btn-back">Go back to Dashboard</a>
            </div>
<%
        }
    } catch (Exception e) {
%>
        <!-- Exception error message -->
        <div class="error-message">
            <h2>Error: <%= e.getMessage() %></h2>
            <a href="adminDashboard.jsp" class="btn-back">Go back to Dashboard</a>
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
%>
<!-- Style for the page -->
<style>
     body {
     margin: 0;
     padding: 5;
     font-family: Arial, sans-serif;
     background: url('admin-background.jpg') no-repeat center center fixed;
     background-size: cover;
     color: white;
     display: flex;
     justify-content: center;
     align-items: center;
     height: 100vh;
 }
 
     .success-message, .error-message {
         background-color: rgba(45, 44, 44, 0.8);
         border: 1px solid #ddd;
         padding: 20px;
         box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
         text-align: center;
         width: 400px;
         border-radius: 8px;
     }
 
     .success-message h2 {
         color: #dde4dd;
         font-size: 24px;
         margin-bottom: 20px;
     }
 
     .error-message h2 {
         color: #f44336;
         font-size: 24px;
         margin-bottom: 20px;
     }
 
     .btn-back {
         display: inline-block;
         background-color: #2196F3;
         color: #fff;
         padding: 10px 20px;
         text-decoration: none;
         border-radius: 5px;
         font-size: 16px;
     }
 
     .btn-back:hover {
         background-color: #1976D2;
     }
 </style>
