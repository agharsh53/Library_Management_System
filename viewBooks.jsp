<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
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


    <%-- Database Integration for Books Table --%>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryDB", "root", "Mahadev07ji$");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM Books");

            out.println("<h1>Available Books</h1>");
            out.println("<table>");
            out.println("<tr><th>Book Id</th><th>Title</th><th>Author</th><th>Category</th><th>Quantity</th></tr>");
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("id") + "</td>");
                out.println("<td>" + rs.getString("title") + "</td>");
                out.println("<td>" + rs.getString("author") + "</td>");
                out.println("<td>" + rs.getString("category") + "</td>");
                out.println("<td>" + rs.getInt("quantity") + "</td>");
                
                out.println("</tr>");
            }
            out.println("</table>");
            rs.close();
            st.close();
            con.close();
        } catch (Exception e) {
            out.println("<h2>Error: " + e.getMessage() + "</h2>");
        }
    %>
    <script src="script.js"></script>
</body>
</html>
