<%@ page import="java.sql.*" %>
<%@ page import="oracle.jdbc.OracleDriver" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> </title>
</head>
<body>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout Page</title>
</head>
<body>

    <%
        // Invalidate the session
        if (session != null) {
            session.invalidate();
        }
    
    
    
        // Truncate table using JDBC
        Connection connection = null;
        Statement statement = null;
        try {
            // Establish the connection
            Class.forName("oracle.jdbc.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "jake");
          
            // Create a statement
            statement = con.createStatement();
    
            // Truncate the table
            String tableName = "cart_items";
            String truncateQuery = "TRUNCATE TABLE " + tableName;
            statement.executeUpdate(truncateQuery);
    
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        out.println("<script>alert(' truncated successfully.'); </script>");

        // Redirect to index.jsp
        response.sendRedirect("index.jsp");
    %>
    


</body>
</html>

</body>
</html>