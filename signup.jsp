<%@ page import="java.sql.*" %>
     <!DOCTYPE html>
     <html lang="en">

     <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Sign Up</title>
          <style>
               body {
                    margin: 0;
                    padding: 0;
                    font-family: Arial, sans-serif;
                    background: url('library-background.jpg') repeat center center fixed;
                    background-size: cover;
                    justify-content: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
               }

               .signup-container {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 130vh;
                    background-color: rgba(0, 0, 0, 0.5);
                    /* Transparent overlay */
               }

               .signup-box {
                    background: rgb(170, 195, 216);
                    padding: 30px;
                    border-radius: 10px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                    text-align: center;
                    width: 350px;
               }

               .signup-box img {
                    width: 80px;
                    height: 80px;
                    border-radius: 50%;
                    margin-bottom: 20px;
               }

               .signup-box h2 {
                    margin: 0;
                    font-size: 24px;
                    color: #333;
                    margin-bottom: 20px;
               }

               .signup-box input {
                    width: 80%;
                    padding: 10px;
                    margin: 10px 0;
                    border: 1px solid #ccc;
                    border-radius: 5px;
               }

               .signup-box button {
                    width: 82%;
                    padding: 10px;
                    border: none;
                    border-radius: 5px;
                    background-color: #2d97a5;
                    color: white;
                    font-size: 16px;
                    cursor: pointer;
               }

               .signup-box button:hover {
                    background-color: #0056b3;
               }
          </style>
     </head>

     <body>
          <div class="signup-container">
               <div class="signup-box">
                    <img src="user-icon.png" alt="User Icon">
                    <h2>Library Signup</h2>
                    <form action="signupAction.jsp" method="post">
                         <label for="user_id">Enter your Id:</label>
                         <input type="text" id="id" name="user_id" required><br>
                         <label for="Username">Username:</label>
                         <input type="text" id="Username" name="username" required><br>
                         <label for="email">Email:</label>
                         <input type="email" id="email" name="email" required><br>
                         <label for="Password">Password:</label>
                         <input type="password" id="password" name="password" required><br>
                         <label>User Type:</label>
                         <select name="userType">
                              <option value="Admin">Admin</option>
                              <option value="User">User</option>
                         </select><br><br>
                         <button type="submit">Signup</button>
                    </form>
                    <p>Already have an account? </p>
                    <form action="index.html" method="get">
                         <button type="submit">Login</button>
                    </form>
               </div>


          </div>
     </body>

     </html>