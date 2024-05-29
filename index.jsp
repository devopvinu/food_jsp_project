<%@ page import="java.sql.*" %>
<%@ page import="oracle.jdbc.OracleDriver" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!-- Session Retriving -->

<%
    String loggedInUser = (session != null) ? (String) session.getAttribute("loggedInUser") : null;

    if (loggedInUser == null || loggedInUser.isEmpty()) {
        try {
            response.sendRedirect("login.jsp");
        } finally{

        }
    }
%>


<!-- CART COUNT FUNTION  -->
<%
int count = 0;
Connection connection;

try {
  Class.forName("oracle.jdbc.OracleDriver");
  Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "jake");

    String sql2 = "SELECT COUNT(*) AS count FROM cart_items";
    PreparedStatement stmt2 = con.prepareStatement(sql2);
    ResultSet rs = stmt2.executeQuery();

    if (rs.next()) {
       count = rs.getInt("count");
       con.close();
    }

} finally {
   
}

%>
<!-- CART FUNCTION COUNT END -->


<!-- Cart Drawer Delete  Function -->
<%
    String did = null;

    if (request.getMethod().equals("GET")) {
        did = request.getParameter("dele");

        try {
            Class.forName("oracle.jdbc.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "jake");

            PreparedStatement stmt = con.prepareStatement("DELETE FROM cart_items WHERE id = ?");
            stmt.setString(1, did);
            stmt.executeUpdate();

            stmt.close();
            con.close();
%>


<script>
    var urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get("dele")) {
        alert("Deleted From Cart");
        window.location.href = "./index.jsp";
    }
</script>
<%
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    } 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title> Hungry Buddy</title>
    <link rel="stylesheet" href="style.css" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <style>
        html {
        scroll-behavior: smooth;
    }
        a:link{
            text-decoration: none;
        }
        sup{
            margin-left: 5px;
            padding: 3px;
            color: white;
            font-size: 1.2rem;
            background-color: #db7c38;
            border-radius: 20px;
        }
        .btn{
            border: none;
            text-align: center;
            cursor: pointer;
            margin-left: 45px;
        }


.counterr {
    width: 100px;
    /* margin: auto; */
    display: flex;
    align-items: center;
    justify-content: center;
    margin-top: 10px;
}
.counterr input {
    width: 25px;
    border: 0;
    line-height: 10px;
    font-size: 15px;
    text-align: center;
    background: #11d064;
    color: #fff;
    appearance: none;
    outline: 0;
}
.counterr span {
    display: block;
    font-size: 25px;
    padding: 0 10px;
    cursor: pointer;
    color: #11d064;
    user-select: none;
}


/* cart drawer */
.form-popup {
  display: none;
  position: fixed;
  top: 5rem;
  right: 25px;
  border: 3px solid #f1f1f1;
  z-index: 11;
 
}

.popup-container {
  width: 20rem;
  height: auto;
  padding: 3px;
  background-color: rgb(255, 255, 255);
}

.cart-headerr {
  display: flex;
  justify-content: flex-end;
  padding: 2px;
  backdrop-filter: blur(16px) saturate(180%);
    -webkit-backdrop-filter: blur(16px) saturate(180%);
    background-color: rgba(255, 255, 255, 0.75);
    border-radius: 12px;
    border: 1px solid rgba(209, 213, 219, 0.3);
}
.cart-itemss {
  max-height: 300px;
  overflow-y: auto;
  margin-bottom: 20px;

}
.iconn {
  cursor: pointer;
  font-size: 35px;
  padding: 2px;
}
.itemm {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  margin: 1rem;
}

.title-pricee,
.quantity-removee,
.cart-headerr {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.titlee,
.pricee,
.quantityy,
.removee,
.close-iconn,
.iconn {
  display: inline-block;
}

.itemss{
    border-bottom: 1px solid;
    
}
.checkout-buttonn {
  display: block;
  background-color: #333;
  color: #fff;
  border: none;
  padding: 10px;
  font-size: 16px;
  cursor: pointer;
  text-align: center;
  border-radius: 2rem;
}

.content-containe {
    opacity: 0;
    transform: translateY(150px); 
    transition: opacity 0.5s ease, transform 0.5s ease; 
}

.content-container {
    opacity: 0; 
    -webkit-transform: scale(0.5); 
    transform: scale(0.5);
    transition: opacity 0.4s ease-in-out, -webkit-transform 0.4s ease-in-out;
    transition: transform 0.4s ease-in-out, opacity 0.4s ease-in-out; 
    -webkit-transition: -webkit-transform 0.4s ease-in-out, opacity 0.4s ease-in-out; 
}

.im {
  border-radius: 50%;
  width: 300px;
  animation: myAnim 7s ease-in 1s infinite normal forwards;
}

@keyframes myAnim {
  0% {
      transform: rotate(0);
  }
  100% {
      transform: rotate(360deg);
  }
}




    </style>
</head>

<body>
    <div class="main-container">
        <!-- Navbar Section -->
        <header class="navbar">
            <div class="global-nav">
                <div class="nav">
                    <div class="left">
                        <a href="index.jsp" class="logo">
                            <img class="main-logo" src="./img/logom.png" alt="">
                          
                        </a>
                        <div class="location-div">
                            <span class="other">Other</span>
                            <span class="location">Nellore, India</span>
                        </div>
                    </div>
                    <div class="right">
                        <ul class="items">
                            <li>
                                <div class="nav-item">
                                    <a href="./index.jsp">
                                        <svg style="color: rgb(5, 5, 5);" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house" viewBox="0 0 16 16"> <path fill-rule="evenodd" d="M2 13.5V7h1v6.5a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5V7h1v6.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5zm11-11V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z" fill="#050505"></path> <path fill-rule="evenodd" d="M7.293 1.5a1 1 0 0 1 1.414 0l6.647 6.646a.5.5 0 0 1-.708.708L8 2.207 1.354 8.854a.5.5 0 1 1-.708-.708L7.293 1.5z" fill="#050505"></path> </svg>
                                        <span>Home</span>
                                    </a>
                                </div>
                            </li>
                            <li>
                                <div class="nav-item">
                                    <a href="">
                                        <svg class="_1GTCc" viewBox="0 0 32 32" height="19" width="19" fill="#686b78">
                                            <path
                                                d="M14.2 2.864l-1.899 1.38c-0.612 0.447-1.35 0.687-2.11 0.687h-2.352c-0.386 0-0.727 0.248-0.845 0.613l-0.728 2.238c-0.235 0.721-0.691 1.348-1.302 1.79l-1.905 1.385c-0.311 0.226-0.442 0.626-0.323 0.991l0.728 2.241c0.232 0.719 0.232 1.492-0.001 2.211l-0.727 2.237c-0.119 0.366 0.011 0.767 0.323 0.994l1.906 1.384c0.61 0.445 1.064 1.070 1.3 1.79l0.728 2.24c0.118 0.365 0.459 0.613 0.844 0.613h2.352c0.759 0 1.497 0.24 2.107 0.685l1.9 1.381c0.313 0.227 0.736 0.227 1.048 0.001l1.9-1.38c0.613-0.447 1.349-0.687 2.11-0.687h2.352c0.384 0 0.726-0.248 0.845-0.615l0.727-2.235c0.233-0.719 0.688-1.346 1.302-1.794l1.904-1.383c0.311-0.226 0.442-0.627 0.323-0.993l-0.728-2.239c-0.232-0.718-0.232-1.49 0.001-2.213l0.727-2.238c0.119-0.364-0.012-0.765-0.324-0.992l-1.901-1.383c-0.614-0.445-1.070-1.074-1.302-1.793l-0.727-2.236c-0.119-0.366-0.461-0.614-0.845-0.614h-2.352c-0.76 0-1.497-0.239-2.107-0.685l-1.903-1.382c-0.313-0.227-0.736-0.226-1.047-0.001zM16.829 0.683l1.907 1.385c0.151 0.11 0.331 0.168 0.521 0.168h2.352c1.551 0 2.927 1 3.408 2.475l0.728 2.241c0.057 0.177 0.169 0.332 0.321 0.442l1.902 1.383c1.258 0.912 1.784 2.531 1.304 4.006l-0.726 2.234c-0.058 0.182-0.058 0.375-0.001 0.552l0.727 2.237c0.48 1.477-0.046 3.096-1.303 4.007l-1.9 1.38c-0.153 0.112-0.266 0.268-0.324 0.447l-0.727 2.237c-0.48 1.477-1.856 2.477-3.408 2.477h-2.352c-0.19 0-0.37 0.058-0.523 0.17l-1.904 1.383c-1.256 0.911-2.956 0.911-4.213-0.001l-1.903-1.384c-0.15-0.11-0.332-0.168-0.521-0.168h-2.352c-1.554 0-2.931-1.001-3.408-2.477l-0.726-2.234c-0.059-0.18-0.173-0.338-0.324-0.448l-1.902-1.381c-1.258-0.912-1.784-2.53-1.304-4.008l0.727-2.235c0.058-0.179 0.058-0.373 0.001-0.551l-0.727-2.236c-0.481-1.476 0.046-3.095 1.302-4.006l1.905-1.385c0.151-0.11 0.264-0.265 0.323-0.444l0.727-2.235c0.478-1.476 1.855-2.477 3.408-2.477h2.352c0.189 0 0.371-0.059 0.523-0.17l1.902-1.383c1.256-0.911 2.956-0.911 4.212 0zM18.967 23.002c-1.907 0-3.453-1.546-3.453-3.453s1.546-3.453 3.453-3.453c1.907 0 3.453 1.546 3.453 3.453s-1.546 3.453-3.453 3.453zM18.967 20.307c0.419 0 0.758-0.339 0.758-0.758s-0.339-0.758-0.758-0.758c-0.419 0-0.758 0.339-0.758 0.758s0.339 0.758 0.758 0.758zM10.545 14.549c-1.907 0-3.453-1.546-3.453-3.453s1.546-3.453 3.453-3.453c1.907 0 3.453 1.546 3.453 3.453s-1.546 3.453-3.453 3.453zM10.545 11.855c0.419 0 0.758-0.339 0.758-0.758s-0.339-0.758-0.758-0.758c-0.419 0-0.758 0.339-0.758 0.758s0.339 0.758 0.758 0.758zM17.78 7.882l2.331 1.352-7.591 13.090-2.331-1.352 7.591-13.090z">
                                            </path>
                                        </svg>
                                        <span>Offers</span>
                                    </a>
                                </div>
                            </li>
                            <li>
                                <div class="nav-item">
                                    <a href="">
                                        <svg class="_1GTCc" viewBox="6 -1 12 25" height="19" width="19" fill="#686b78">
                                            <path
                                                d="M21.966903,13.2244898 C22.0156989,12.8231523 22.0408163,12.4145094 22.0408163,12 C22.0408163,11.8357822 22.036874,11.6724851 22.029079,11.5101984 L17.8574333,11.5102041 C17.8707569,11.6717062 17.877551,11.8350597 17.877551,12 C17.877551,12.4199029 17.8335181,12.8295214 17.749818,13.2244898 L21.966903,13.2244898 Z M21.5255943,15.1836735 L16.9414724,15.1836735 C15.8950289,16.8045422 14.0728218,17.877551 12,17.877551 C9.92717823,17.877551 8.1049711,16.8045422 7.05852762,15.1836735 L2.47440565,15.1836735 C3.80564362,19.168549 7.56739481,22.0408163 12,22.0408163 C16.4326052,22.0408163 20.1943564,19.168549 21.5255943,15.1836735 Z M21.7400381,9.55102041 C20.6468384,5.18931674 16.7006382,1.95918367 12,1.95918367 C7.2993618,1.95918367 3.3531616,5.18931674 2.25996187,9.55102041 L6.6553883,9.55102041 C7.58404845,7.5276442 9.62792376,6.12244898 12,6.12244898 C14.3720762,6.12244898 16.4159515,7.5276442 17.3446117,9.55102041 L21.7400381,9.55102041 Z M2.03309705,13.2244898 L6.25018203,13.2244898 C6.16648186,12.8295214 6.12244898,12.4199029 6.12244898,12 C6.12244898,11.8350597 6.1292431,11.6717062 6.14256675,11.5102041 L1.97092075,11.5102041 C1.96312595,11.6724851 1.95918367,11.8357822 1.95918367,12 C1.95918367,12.4145094 1.98430112,12.8231523 2.03309705,13.2244898 Z M12,24 C5.372583,24 0,18.627417 0,12 C0,5.372583 5.372583,0 12,0 C18.627417,0 24,5.372583 24,12 C24,18.627417 18.627417,24 12,24 Z M12,15.9183673 C14.1640545,15.9183673 15.9183673,14.1640545 15.9183673,12 C15.9183673,9.83594547 14.1640545,8.08163265 12,8.08163265 C9.83594547,8.08163265 8.08163265,9.83594547 8.08163265,12 C8.08163265,14.1640545 9.83594547,15.9183673 12,15.9183673 Z">
                                            </path>
                                        </svg>
                                        <span>Help</span>
                                    </a>
                                </div>
                            </li>
                            <li>
                                <div class="nav-item dropdown ">
                                    
                                        <svg class="_1GTCc login sv " viewBox="6 0 12 24" height="19" width="18" fill="#686b78">
                                            <path
                                                d="M11.9923172,11.2463768 C8.81761115,11.2463768 6.24400341,8.72878961 6.24400341,5.62318841 C6.24400341,2.5175872 8.81761115,0 11.9923172,0 C15.1670232,0 17.740631,2.5175872 17.740631,5.62318841 C17.740631,8.72878961 15.1670232,11.2463768 11.9923172,11.2463768 Z M11.9923172,9.27536232 C14.0542397,9.27536232 15.7257581,7.64022836 15.7257581,5.62318841 C15.7257581,3.60614845 14.0542397,1.97101449 11.9923172,1.97101449 C9.93039471,1.97101449 8.25887628,3.60614845 8.25887628,5.62318841 C8.25887628,7.64022836 9.93039471,9.27536232 11.9923172,9.27536232 Z M24,24 L0,24 L1.21786143,19.7101449 L2.38352552,15.6939891 C2.85911209,14.0398226 4.59284263,12.7536232 6.3530098,12.7536232 L17.6316246,12.7536232 C19.3874139,12.7536232 21.1256928,14.0404157 21.6011089,15.6939891 L22.9903494,20.5259906 C23.0204168,20.63057 23.0450458,20.7352884 23.0641579,20.8398867 L24,24 Z M21.1127477,21.3339312 L21.0851024,21.2122487 C21.0772161,21.1630075 21.0658093,21.1120821 21.0507301,21.0596341 L19.6614896,16.2276325 C19.4305871,15.4245164 18.4851476,14.7246377 17.6316246,14.7246377 L6.3530098,14.7246377 C5.4959645,14.7246377 4.55444948,15.4231177 4.32314478,16.2276325 L2.75521062,21.6811594 L2.65068631,22.0289855 L21.3185825,22.0289855 L21.1127477,21.3339312 Z">
                                            </path>
                                        </svg>
                                        <%
                                            if (loggedInUser != null && !loggedInUser.isEmpty()) {
                                        %>
                                            <span class="logined-name">  <%= loggedInUser %> </span>
                                            <div class="dropdown-content">
                                                <a href="./logout.jsp">Logout</a>
                                              </div>

                                        <%
                                            } else {
                                        %>
                                        <span> <a href="login.jsp"> Sign In</a> </span> 
                                        <%
                                            }
                                        %>
                                        
                                    
                                </div>
                            </li>
                            <li>
                                <div class="nav-item ">
                                    <div href="" class="open-button" onclick="openForm()" style="font-size: 20px;" >
                                          &#128722;
                                        <span>Cart<sup><%=count %></sup></span>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            </div>
        </header>


<!-- Getting Data From Cart Table -->
<%
   try {
      Class.forName("oracle.jdbc.OracleDriver");
      Connection cone = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "jake");

      Statement stmte = cone.createStatement();
      ResultSet rs = stmte.executeQuery("SELECT * FROM cart_items");
      
%> 



<!-- Cart Drawer -->

  <div class="form-popup" id="myForm">
    <div  class="popup-container">

            <div class="cart-headerr">
                <div class="close-iconn"><h4>Your Cart (<%= count %>)</h4></div>
                <div class="iconn" onclick="closeForm()">&times;</div>
            </div>

            <div class="cart-itemss">
          
                <%
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String title = rs.getString("title");
                    String price = rs.getString("price");
                    int quantity = rs.getInt("quantity");
    
    %>   


                <div class="itemm">
                  <div class="title-pricee">
                    <div class="titlee">
                      <h4><%= title %></h4>
                    </div>
                    <div class="pricee">&#8377; <%= price %></div>
                  </div>
                  <div class="quantity-removee">
                    <div class="quantityy">
                      <div class="counterr">
                        <span class="down" onClick='decreaseCount(event, this)' data-id="<%= id %>" >-</span>
                        <input type="text" value="<%=quantity %>">
                        <span class="up" onClick='increaseCount(event, this)' data-id="<%= id %>">+</span>
                      </div>
                    </div>
                    <div class="removee"style='font-size:21px; color: red;'><a href="./index.jsp?dele=<%= id %>"> <b>  &#128465; </b></a></div>
                  </div>
                </div>
                <hr>
          
<%
            }
                rs.close();
                stmte.close();
                cone.close();
             } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error: " + e.getMessage() + "</p>");
             }
%>

              </div>
              <a  href="./cart.jsp" class="checkout-buttonn">Checkout</a>
            </div>
          
    </div>
  </div>
  


<!-- Hero section -->
  <div class="banner"  >
  <div class="hero">
    <div class="rowl">
        <div class="tit">
            <h1 class="tx1">Order Your Loved <br> Food Any Time</h1>
            <p class="tx2">Hey Our Delocious Food Is Waiting For You, <br> We Are Always Near To You With Various Items With Taste</p>
            <button class="explore-btn"  onclick="contentScroll()">Explore now</button>

        </div>
    </div>
    <div class="rowr">
        <div class="pic">
            <img id="rotatingImage"  class="im"  src="./img/p2.jpg" alt="" />
        </div>
    </div>
  </div>
</div>

<script>
    function contentScroll() {
      const element = document.getElementById("content");
      element.scrollIntoView({
        behavior: "smooth"
      });
    }
    </script>
    


        <!-- Content Section -->
        <main class="main-container">
            <section class="restaurants">
                <div class="container">
                    <div class="item-bar">
                        <div class="number">506 restaurants</div>
                        <div class="filters">
                            <div class="relevance">Relevance</div>
                            <div class="delivery">Delivery Time</div>
                            <div class="rating">Rating</div>
                            <div class="cost-lh">Cost: Low to High</div>
                            <div class="cost-hl">Cost: High to Low</div>
                        </div>
                    </div>
                </div>
            </section>
        </main>

            <div class="restaurant-list" id="content" >

                        <div class="card">
                            <div class="card__image">
                               <img src="./img/restaurant-5.png" alt="" />
                            </div>
                            <div class="card__info">
                               <div class="car__info--title">
                                  <h3 class="food-title"> Noodles  </h3>
                                  <p class="tags">Italian, Pizzas, Fast Food, Mexican, Desserts, </p>
                               </div>
                               <div class="card__info--price">
                                  <p class="prc" style="font-size: 22px;">&#8377; 399</p>
                               </div>
                            </div>
                            <div class="star">
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star "></span>
                             </div>
                              <div class="adcart-btn">
                                  <form action="" method="post">
                                      <input type="hidden" name="name" value="Pasta">
                                      <input type="hidden" name="price" value="399">
                                      <input type="submit" class="ct-btn third" value="ADD TO CART"></span>
                                  </form>
                              </div>
                          </div>
                          <%
                          if (request.getMethod().equals("POST")) {
                              String name = request.getParameter("name");
                              String price = request.getParameter("price");
                              
                              int quantity = 1;
                              
                              int ct = count + 2;
                          
                              try {
                                  Class.forName("oracle.jdbc.OracleDriver");
                                  Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "jake");
                          
                                  PreparedStatement stmt = con.prepareStatement("INSERT INTO cart_items (id,title,price,quantity) VALUES (?, ?, ?, ?)");
                                  stmt.setInt(1, ct);
                                  stmt.setString(2, name);
                                  stmt.setString(3, price);
                                  stmt.setInt(4, quantity);
                                  stmt.executeUpdate();
%>
                
                    <script>alert("<%= name %>  Item Added To Cart Sucessfully");</script>
                    <script>window.location.href="index.jsp";</script>

<%
                                } catch (Exception e) {
                                  // Handle any errors that may occur
                                  e.printStackTrace();
                                  out.println("Error adding item to cart: " + e.getMessage());
                              }
                          }
                      %>

                        <div class="card" style="background-color: #fff;">
                            <div class="card__image">
                               <img src="./img/restaurant-2.png" alt="" />
                            </div>
                            <div class="card__info">
                               <div class="car__info--title">
                                  <h3 class="food-title">Asian Pizza  </h3>
                                  <p class="tags">Italian, Pizzas, Fast Food, Mexican, Desserts, </p>
                               </div>
                               <div class="card__info--price">
                                  <p class="prc" style="font-size: 22px;">&#8377; 399</p>
                               </div>
                            </div>
                            <div class="star">
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked "></span>
                             </div>
                              <div class="adcart-btn">
                                  <form action="" method="post">
                                      <input type="hidden" name="name" value="Asian Pizza">
                                      <input type="hidden" name="price" value="399">
                                      <input type="submit" class="ct-btn" value="ADD TO CART"></span>
                                  </form>
                              </div>
                          </div>
                        

                        <div class="card">
                            <div class="card__image">
                               <img src="./img/restaurant-3.png" alt="" />
                            </div>
                            <div class="card__info">
                               <div class="car__info--title">
                                  <h3 class="food-title">Burger  </h3>
                                  <p class="tags">Italian, Pizzas, Fast Food, Mexican, Desserts, </p>
                               </div>
                               <div class="card__info--price">
                                  <p class="prc" style="font-size: 22px;">&#8377; 99</p>
                               </div>
                            </div>
                            <div class="star">
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star "></span>
                              <span class="fa fa-star "></span>
                             </div>
                              <div class="adcart-btn">
                                  <form action="" method="post">
                                      <input type="hidden" name="name" value="Burger">
                                      <input type="hidden" name="price" value="99">
                                      <input type="submit" class="ct-btn" value="ADD TO CART"></span>
                                  </form>
                              </div>
                          </div>


                        <div class="card">
                            <div class="card__image">
                               <img src="./img/restaurant-4.png" alt="" />
                            </div>
                            <div class="card__info">
                               <div class="car__info--title">
                                  <h3 class="food-title">Veg Thali  </h3>
                                  <p class="tags">Italian, Pizzas, Fast Food, Mexican, Desserts, </p>
                               </div>
                               <div class="card__info--price">
                                  <p class="prc" style="font-size: 22px;">&#8377; 499</p>
                               </div>
                            </div>
                            <div class="star">
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star "></span>
                             </div>
                              <div class="adcart-btn">
                                  <form action="" method="post">
                                      <input type="hidden" name="name" value="Veg Thali">
                                      <input type="hidden" name="price" value="499">
                                      <input type="submit" class="ct-btn" value="ADD TO CART"></span>
                                  </form>
                              </div>
                          </div>
                        

                        <div class="card">
                            <div class="card__image">
                               <img src="./img/restaurant-6.png" alt="" />
                            </div>
                            <div class="card__info">
                               <div class="car__info--title">
                                  <h3 class="food-title">Chicken Wings  </h3>
                                  <p class="tags">Italian, Pizzas, Fast Food, Mexican, Desserts, </p>
                               </div>
                               <div class="card__info--price">
                                  <p class="prc" style="font-size: 22px;">&#8377; 199</p>
                               </div>
                            </div>
                            <div class="star">
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star "></span>
                             </div>
                              <div class="adcart-btn">
                                  <form action="" method="post">
                                      <input type="hidden" name="name" value="Chicken Wings">
                                      <input type="hidden" name="price" value="199">
                                      <input type="submit" class="ct-btn" value="ADD TO CART"></span>
                                  </form>
                              </div>
                              </div>

                        <div class="card">
                            <div class="card__image">
                               <img src="./img/p9.webp" alt="" />
                            </div>
                            <div class="card__info">
                               <div class="car__info--title">
                                  <h3 class="food-title">Mocktails  </h3>
                                  <p class="tags">Orange, Pine apple, Blue ciao , Mexican, Desserts, </p>
                               </div>
                               <div class="card__info--price">
                                  <p class="prc" style="font-size: 22px;">&#8377; 159</p>
                               </div>
                            </div>
                            <div class="star">
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star "></span>
                             </div>
                              <div class="adcart-btn">
                                  <form action="" method="post">
                                      <input type="hidden" name="name" value="Mocktails">
                                      <input type="hidden" name="price" value="159">
                                      <input type="submit" class="ct-btn" value="ADD TO CART"></span>
                                  </form>
                              </div>
                            </div>


                        <div class="card">
                            <div class="card__image">
                               <img src="./img/p7.webp" alt="" />
                            </div>
                            <div class="card__info">
                               <div class="car__info--title">
                                  <h3 class="food-title">Chicken Biryani  </h3>
                                  <p class="tags">Dum biriryani, Roasted biriyani, Fast Food, Mexican, Desserts, </p>
                               </div>
                               <div class="card__info--price">
                                  <p class="prc" style="font-size: 22px;">&#8377; 449</p>
                               </div>
                            </div>
                            <div class="star">
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star "></span>
                             </div>
                              <div class="adcart-btn">
                                  <form action="" method="post">
                                      <input type="hidden" name="name" value="Chicken Biryani">
                                      <input type="hidden" name="price" value="259">
                                      <input type="submit" class="ct-btn" value="ADD TO CART"></span>
                                  </form>
                              </div>
                          </div>

                        <div class="card">
                            <div class="card__image">
                               <img src="./img/p8.jpg" alt="" />
                            </div>
                            <div class="card__info">
                               <div class="car__info--title">
                                  <h3 class="food-title">Chicken Leg Piece  </h3>
                                  <p class="tags">Chicken fry, Roasted, Juicy Chicken, Mexican, Desserts</p>
                               </div>
                               <div class="card__info--price">
                                  <p class="prc" style="font-size: 22px;">&#8377;149</p>
                               </div>
                            </div>
                            <div class="star">
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star checked"></span>
                              <span class="fa fa-star "></span>
                              <span class="fa fa-star "></span>
                             </div>
                              <div class="adcart-btn">
                                  <form action="" method="post">
                                      <input type="hidden" name="name" value="Chicken leg Piece">
                                      <input type="hidden" name="price" value="149">
                                      <input type="submit" class="ct-btn" value="ADD TO CART"></span>
                                  </form>
                              </div>
                          </div>
                        

</div>
</div>
</section>
</main>
             
        <!-- Footer Section -->
        <footer class="footer">
            <div class="footer-content">
                <div class="points">
                    COMPANY
                    <ul class="footer-ul">
                        <li class="footer-li"><a href="#">About us</a></li>
                        <li class="footer-li"><a href="#">Team</a></li>                       
                    </ul>
                </div>
                <div class="points">
                    CONTACT
                    <ul class="footer-ul">
                        <li class="footer-li"><a href="#">Help & Support</a></li>
                        <li class="footer-li"><a href="#">Partner with us</a></li>
                    </ul>
                </div>
                <div class="points">
                    LEGAL
                    <ul class="footer-ul">
                        <li class="footer-li"><a href="#">Terms & Conditions</a></li>
                        <li class="footer-li"><a href="#">Refund & Cancellation</a></li>
                    </ul>
                </div>
               
            </div>
        </footer>
    </div>
 
    
    <!-- Cart Drawer -->
    <script>
        function openForm() {
          document.getElementById("myForm").style.display = "block";
        }
        
        function closeForm() {
          document.getElementById("myForm").style.display = "none";
        }
        </script>
      
      <!-- cart counter  -->
         
<script>
    function increaseCount(a, b) {
  var input = b.previousElementSibling;
  var value = parseInt(input.value, 10);
  value = isNaN(value) ? 0 : value;
  value++;
  input.value = value;
}

function decreaseCount(a, b) {
  var input = b.nextElementSibling;
  var value = parseInt(input.value, 10);
  if (value > 1) {
    value = isNaN(value) ? 0 : value;
    value--;
    input.value = value;
  }
}
</script>


<!-- quantity Increase/Decrease -->
<script>
    function decreaseCount(event, element) {
        var input = element.nextElementSibling;
        var value = parseInt(input.value, 10);
        value = isNaN(value) ? 0 : value;
        if (value > 1) {
            value--;
            input.value = value;
    
            // Update the database
            var id = element.getAttribute("data-id");
            var count = value;
            var url = "update_cart_home.jsp?id=" + id + "&count=" + count;
            window.location.href = url;
        }
    }
    
    function increaseCount(event, element) {
        var input = element.previousElementSibling;
        var value = parseInt(input.value, 10);
        value = isNaN(value) ? 0 : value;
        value++;
        input.value = value;
    
        // Update the database
        var id = element.getAttribute("data-id");
        var count = value;
        var url = "update_cart_home.jsp?id=" + id + "&count=" + count;
        window.location.href = url;
    }
    

    </script>
 
 <script>
        
    const imageUrls = [
        './img/food-2.png',
        './img/food-1.png',
        './img/food-3.png',
        './img/p2.jpg', 
        './img/p3.jpg' 
       
          
    ];

    // Function to rotate the images
    function rotateImages() {
        const rotatingImage = document.getElementById('rotatingImage');
        let currentImageIndex = 0;

        function nextImage() {
            rotatingImage.src = imageUrls[currentImageIndex];
            currentImageIndex = (currentImageIndex + 1) % imageUrls.length;
        }

        rotatingImage.addEventListener('animationiteration', nextImage);
        nextImage(); 
    }

    window.onload = rotateImages;
</script>



    
</body>
</html>