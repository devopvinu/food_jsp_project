<%@ page import="java.sql.*" %>
<%@ page import="oracle.jdbc.OracleDriver" %>


<!DOCTYPE html>
<html>
<style>
.container{
    width: 50%;
    margin: 0 auto;
}

input[type=text], select {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

input[type=submit] {
  width: 100%;
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=submit]:hover {
  background-color: #45a049;
}

div {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
<body>


    <div class="container">  
        <h3>Add Products</h3>

  <form action="" method="post" enctype="multipart/form-data">
    <label for="image">Image</label>
    <input type="file"  name="image">
<br>
<br>
<br>
    <label for="time">Title</label>
    <input type="text" name="title" placeholder="Your Title..">

    <label for="time">description</label>
    <input type="text" name="description" placeholder="Enter description.">

    <label for="rating">Rating</label>
    <input type="text" name="rating" placeholder="Your Rating">

    <label for="time">Time</label>
    <input type="text" name="time" placeholder="Your Time">

    <label for="text">Single Offer</label>
    <input type="text" name="offer" placeholder="Your offer">

    <label for="mainoffer">main offer</label>
    <input type="text" name="mainoffer" placeholder="Your offer">

    <label for="offertag">offer tag</label>
    <input type="text" name="offertag" placeholder="Your offer tag..">

    <label for="addons">Add ons</label>
    <input type="text" name="addons" placeholder="Your Add-Ons..">

    <label for="price">Price</label>
    <input type="text" name="price" placeholder="Your Price..">
  
    <input type="submit" value="Submit">
  </form>
</div>
</div>




<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%@ page import="java.io.ByteArrayOutputStream" %>



<c:if test="${not empty param.image}">
  <%

    try {
      javax.servlet.http.Part filePart = request.getPart("image");
      java.io.InputStream inputStream = filePart.getInputStream();
      
      ByteArrayOutputStream buffer = new ByteArrayOutputStream();
      int nRead;
      byte[] data = new byte[1024];
      
      while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
        buffer.write(data, 0, nRead);
      }
      
      buffer.flush();
      
      javax.sql.rowset.serial.SerialBlob imageBlob = new javax.sql.rowset.serial.SerialBlob(buffer.toByteArray());
      String title = request.getParameter("title");
      String description = request.getParameter("description");
      String rating = request.getParameter("rating");
      String time = request.getParameter("time");
      String offer = request.getParameter("offer");
      String mainoffer = request.getParameter("mainoffer");
      String offertag = request.getParameter("offertag");
      String addons = request.getParameter("addons");
      String price = request.getParameter("price");

      java.sql.Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "vinod");
      java.sql.PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO items (image, title, description, rating, time, single_offer, main_offer, offer_tag, addons, price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
      preparedStatement.setBlob(1, imageBlob);
      preparedStatement.setString(2, title);
      preparedStatement.setString(3, description);
      preparedStatement.setString(4, rating);
      preparedStatement.setString(5, time);
      preparedStatement.setString(6, offer);
      preparedStatement.setString(7, mainoffer);
      preparedStatement.setString(8, offertag);
      preparedStatement.setString(9, addons);
      preparedStatement.setString(10, price);
      int rowsAffected = preparedStatement.executeUpdate();
      
      if (rowsAffected > 0) {
        out.println("Data inserted successfully!");
      } else {
        out.println("Error inserting data!");
      }

      connection.close();
      // Clean up resources
      inputStream.close();
      buffer.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
  %>
</c:if>





</body>
</html>


