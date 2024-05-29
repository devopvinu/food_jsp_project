<style>
table {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

table td, table th {
  border: 1px solid #ddd;
  padding: 8px;
}

table th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;

 }

table tr:nth-child(even){background-color: #f2f2f2;}

table tr:hover {background-color: #ddd;}

.container-mba, .container-mca{
   max-width: 75%;
   margin: 0 auto;
   padding: 20px;
}
.tittle{
   text-align: center;
}

</style>

<%@ page import="java.sql.*" %>
<%@ page import="oracle.jdbc.OracleDriver" %>

<div class="container-mba">
<div class="tittle">
   <h3>CART DATA</h3>
</div>

<%
   try {
      Class.forName("oracle.jdbc.OracleDriver");
      Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "jake");

      Statement stmt = con.createStatement();
      ResultSet rs = stmt.executeQuery("SELECT * FROM cart_items");

      out.println("<table>");
         out.println("<tr><th>ID</th><th>Title</th><th>Price</th> </tr>");
         while (rs.next()) {
         
         String id = rs.getString("id");
         String gabsent = rs.getString("title");
         String babsent = rs.getString("price");
         

         out.println("<tr><td>" + id + "</td> <td>" + gabsent + "</td> <td>" + babsent + "</td></tr>");
      }
      out.println("</table>");

      rs.close();
      stmt.close();
      con.close();
   } catch (Exception e) {
      e.printStackTrace();
      out.println("<p>Error: " + e.getMessage() + "</p>");
   }
%>
</div>

<div class="container-mca">
   <div class="tittle">
      <h3> </h3>
   </div>

