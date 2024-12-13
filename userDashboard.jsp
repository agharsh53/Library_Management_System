<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String email = (String) session.getAttribute("username");
String userType = (String) session.getAttribute("userType");
String username = "";
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
        String query = "SELECT id, username, email FROM Users WHERE email = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            userId = rs.getString("id");
            username = rs.getString("username");
            email = rs.getString("email");
            
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
    <title>User Dashboard</title>
    <link rel="stylesheet" href="dashboard.css">
    <link rel="stylesheet" href="userStyle.css">
    <style>
        .form-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 30vh;
    background: rgba(0, 0, 0, 0.5);
    /* Dark background with transparency */
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
    width: 80%;
    max-width: 400px;
    margin: auto;
}

        .toolbar .active {
     background-color: #d9c8c8;
     color: rgb(18, 18, 18);
     border-radius: 10px;
     
 }
 .user-detail {
    font-size: 1.2em;
    text-shadow: 2px 2px 5px black;
    margin-bottom: 20px;
}
    </style>
</head>
<body>
    <div class="toolbar">
        <a href="userDashboard.jsp">Student Dashboard</a>
        <a href="viewBooks.jsp">View Books</a>
        <a href="searchBook.jsp">Search Book</a>
        <a href="viewProfile.jsp">View Profile</a>
        <a href="logout.jsp">Logout</a>
    </div>

    <h1>Welcome to the Student Dashboard</h1>
    <div class="form-container">
        <h2 style="font-size: 2em; color: gold; ">Student Detail</h2>
        <div class="user-detail">
            <% if (userFound) { %>
                <p><strong>User ID:</strong> <%= userId %></p>
                <p><strong>Username:</strong> <%= username %></p>
                <p><strong>Email:</strong> <%= email %></p>
            <% } else { %>
                <p>No user found with the username: <%= username %></p>
            <% } %>
        </div>
    </div>
    <script src="script.js"></script>
</body>
</html>
