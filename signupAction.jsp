<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup Page</title>
    <link rel="stylesheet" href="dashboard.css">
    <style>
     
          .success-message,
.error-message {
     background-color: rgba(0, 0, 0, 0.5);
    padding: 20px;
    margin-top: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    text-align: center;
    max-width: 450px;
    display: flex;
    justify-content: center;
    align-items: center;              
     }

    </style>
</head>
<body style="background-image: url('library-background.jpg'); background-size: cover; background-position: center;">
     <% String userId=request.getParameter("user_id"); 
     String userType=request.getParameter("userType"); 
     String username=request.getParameter("username");
     String email=request.getParameter("email"); 
     String password=request.getParameter("password"); 
     Connection conn=null; PreparedStatement stmt=null; 
     try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryDB", "root" , "Mahadev07ji$" ); 
          String table=userType.equals("Admin") ? "Admin" : "Users" ; 
          String sql="INSERT INTO " + table + " (id, username, email, password) VALUES (?, ?, ?, ?)" ; stmt=conn.prepareStatement(sql); stmt.setString(1,
          userId); stmt.setString(2, username); stmt.setString(3, email); stmt.setString(4, password); int
          rowsInserted=stmt.executeUpdate();
          if (rowsInserted> 0) {
          %>
          <div class="success-message">
               <h2>Registration Successful!</h2>
               <a href="index.html" class="back-button">Login Now</a>
          </div>

          <% } else { %>
               <div class="error-message">
                    <h2>Error: Registration failed!</h2>
                    <a href="signup.jsp" class="back-button">Try Again</a>
               </div>
               <% } } catch (Exception e) { %>
                    <div>
                         <h2>Error: <%= e.getMessage() %>
                         </h2>
                         <a href="signup.jsp">Try Again</a>
                    </div>
                    <% } finally {
                         try {
                             if (conn != null) conn.close(); // This will now work, as conn is declared outside try block
                         } catch (SQLException e) {
                             out.println("<h2>Error closing resources: " + e.getMessage() + "</h2>");
                         }
                     } %>
                    </body>
                    </html>