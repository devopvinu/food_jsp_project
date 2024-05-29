<%@ page import="java.sql.*" %>

<%
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("oracle.jdbc.OracleDriver");
    con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "jake");

    // Get the id and count from the request
    int id = Integer.parseInt(request.getParameter("id"));
    int count = Integer.parseInt(request.getParameter("count"));

    // Update the database
    String sql = "UPDATE cart_items SET quantity=? WHERE id=?";
    pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, count);
    pstmt.setInt(2, id);

    int rowsAffected = pstmt.executeUpdate();

    out.println("<script>window.location.href='./cart.jsp'; </script> ");

}catch (Exception e) {
    e.printStackTrace();
} finally {
    if (rs != null) {
        rs.close();
    }
    if (pstmt != null) {
        pstmt.close();
    }
    if (con != null) {
        con.close();
    }
}
%>

<%= "The count has been updated." %>
