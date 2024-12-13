<%@ page import="java.sql.*, java.util.*" %>
<%
// Get the role parameter (admin or user)
String role = (String) session.getAttribute("userType");
String backgroundImage;

// Determine the background image based on the role
if ("admin".equalsIgnoreCase(role)) {
    backgroundImage = "admin-background.jpg"; // Path to the Admin logout image
} else if ("user".equalsIgnoreCase(role)) {
    backgroundImage = "user-background.jpg"; // Path to the User logout image
} else {
    backgroundImage = "default-logout-image.jpg"; // Fallback image if role is not defined
}
    // Check if the logout is confirmed
    String confirm = request.getParameter("confirm");
    if ("yes".equals(confirm)) {
        session.invalidate();
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Logout</title>
    <style>
        /* Body styling with a library-themed background */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: url('<%= backgroundImage %>') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Modal overlay */
        .modal-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }

        /* Modal box styling */
        .modal {
            background: white;
            border-radius: 15px;
            padding: 20px 30px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
            z-index: 2;
            position: relative;
        }

        .modal h2 {
            margin: 0;
            font-size: 24px;
            color: #333;
        }

        .modal p {
            margin: 15px 0;
            font-size: 16px;
            color: #555;
        }

        .modal button {
            padding: 10px 20px;
            margin: 10px;
            font-size: 16px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
        }

        .cancel-button {
            background: #f0f0f0;
            color: #333;
        }

        .cancel-button:hover {
            background: #ddd;
        }

        .logout-button {
            background: #007bff;
            color: white;
        }

        .logout-button:hover {
            background: #0056b3;
        }
    </style>
    <script>
        function confirmLogout(choice) {
            if (choice === 'yes') {
                window.location.href = "logout.jsp?confirm=yes";
            }
        }
    </script>
</head>
<body>
    <div class="modal-overlay"></div>
    <div class="modal">
        <h2>Logout</h2>
        <p>Are you sure you want to logout?</p>
        <button class="cancel-button" onclick="window.history.back()">Cancel</button>
        <button class="logout-button" onclick="confirmLogout('yes')">Logout</button>
    </div>
</body>
</html>
