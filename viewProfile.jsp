<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String email = (String) session.getAttribute("username");
String userId = "";
if (email == null) {
    response.sendRedirect("index.html");
}

    boolean userFound = false;

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryDB", "root", "Mahadev07ji$");

        // Query to fetch user details
        String query = "SELECT id FROM Users WHERE email = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            userId = rs.getString("id");
            userFound = true;
        }

        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Profile</title>
    <link rel="stylesheet" href="dashboard.css">
    <link rel="stylesheet" href="userStyle.css">
    <style>
        .toolbar .active {
     background-color: #d9c8c8;
     color: rgb(18, 18, 18);
     border-radius: 10px;
     
 }
    </style>
</head>
<body>
    <div class="toolbar">
        <a href="userDashboard.jsp">Student Dashboard</a>
        <a href="viewBooks.jsp">View Books</a>
        <a href="searchBook.jsp">Search Book</a>
        <a href="viewProfile.jsp">View Profile</a>
    </div>
    <div class="profile-container">
     <h1>User Profile</h1>
     <h2 style="color:antiquewhite; margin: 10px;">Books Issued:</h2>
     <table>
         <tr>
             <th>Book ID</th>
             <th>Title</th>
             <th>Author</th>
             <th>Borrow Date</th>
             <th>Return Date</th>
         </tr>
         <%
             // Replace with session or dynamic user ID
             try {
                 Class.forName("com.mysql.cj.jdbc.Driver");
                 Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryDB", "root", "Mahadev07ji$");
                 String query = "SELECT bb.book_id, b.title, b.author, bb.borrow_date, bb.return_date " +
                                "FROM borrowed_books bb " +
                                "JOIN books b ON bb.book_id = b.id " +
                                "WHERE bb.user_id = ?";
                 PreparedStatement ps = con.prepareStatement(query);
                 ps.setString(1, userId);
                 ResultSet rs = ps.executeQuery();

                 while (rs.next()) {
                     int bookId = rs.getInt("book_id");
                     String title = rs.getString("title");
                     String author = rs.getString("author");
                     Date borrowDate = rs.getDate("borrow_date");
                     Date returnDate = rs.getDate("return_date");

                     out.println("<tr>");
                     out.println("<td>" + bookId + "</td>");
                     out.println("<td>" + title + "</td>");
                     out.println("<td>" + author + "</td>");
                     out.println("<td>" + borrowDate + "</td>");
                     out.println("<td>" + returnDate + "</td>");
                     out.println("</tr>");
                 }

                 rs.close();
                 ps.close();
                 con.close();
             } catch (Exception e) {
                 out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
             }
         %>
     </table>
 </div>
 <script src="script.js"></script>
</body>
</html>
