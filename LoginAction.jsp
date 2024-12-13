<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String userType = request.getParameter("userType"); // Admin or User

    boolean isValidUser = false;

    try {
        // Load MySQL driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/LibraryDB", "root", "Mahadev07ji$");

        // Query to verify user credentials
        String query;
        if ("Admin".equals(userType)) {
            query = "SELECT * FROM Admin WHERE (username = ? OR email = ?) AND password = ?";
        } else {
            query = "SELECT * FROM Users WHERE (username = ? OR email = ?) AND password = ?";
        }

        java.sql.PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, username);
        ps.setString(3, password);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            isValidUser = true;
            session.setAttribute("username", rs.getString("email"));
            session.setAttribute("userType", userType);
        }

        rs.close();
        ps.close();
        con.close();

        // Redirect based on user type
        if (isValidUser) {
            if ("Admin".equals(userType)) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("userDashboard.jsp");
            }
        } else {
            out.println("<h2>Invalid Username or Password</h2>");
            out.println("<a href='index.html'>Try Again</a>");
        }
    } catch (ClassNotFoundException e) {
        out.println("<p>Error: MySQL Driver not found! Ensure the JDBC JAR is added to the project.</p>");
    } catch (SQLException e) {
        out.println("<p>Error: Unable to connect to the database! Check credentials and database configuration.</p>");
        out.println("<p>Details: " + e.getMessage() + "</p>");
    }
%>
