<%@ page import="java.sql.*" %>
<%@ page import="oracle.jdbc.OracleDriver" %>
<%
    // Database connection parameters
    String dbUrl = "jdbc:oracle:thin:@localhost:1521:XE";
    String dbUser = "system";
    String dbPassword = "jake";

    Connection conn = null;
    String message = "";

    try {
        // Load the Oracle JDBC driver
        Class.forName("oracle.jdbc.OracleDriver");

        // Establish the database connection
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        message = "Database connection successful!";
    } catch (ClassNotFoundException e) {
        message = "Error: Oracle JDBC driver not found!";
        e.printStackTrace();
    } catch (SQLException e) {
        message = "Error: Failed to connect to the database!";
        e.printStackTrace();
    } finally {
        // Close the database connection
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Database Connection Test</title>
</head>
<body>
    <h1>Database Connection Test</h1>
    <p><%= message %></p>
</body>
</html>