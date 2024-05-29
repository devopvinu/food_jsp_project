<%@ page import="java.sql.*" %>
<%@ page import="oracle.jdbc.OracleDriver" %>

<%  boolean showpas = true;   %>

<%
if (request.getMethod().equals("POST")) {

    String name = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        Class.forName("oracle.jdbc.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "jake");

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM log");
        
        boolean matched = false;
        
        while (rs.next()) {
          String us = rs.getString("name");

          if (us.equals(name) ) {
              matched = true;

              showpas = false;
              
              session.setAttribute("loggedInUser", name);
              
              break;
          }
      }
      
      
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error occurred while processing the request: " + e.getMessage());
    }
}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hungry Buddy | Login</title>
    <!-- Google Font -->
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
      rel="stylesheet"/>
    <!-- Stylesheet -->
    <link rel="stylesheet" href="style.css" />
<style>
        * {
  padding: 0;
  margin: 0;
  box-sizing: border-box;
  font-family: "Poppins", sans-serif;
}
body {
  /* background-color: #f4c531; */
  background-image: url('./image.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: cover;
  

}
.container {
  height: 31.25em;
  width: 31.25em;
  position: absolute;
  transform: translate(-50%, -50%);
  top: 50%;
  left: 50%;
}
form {
  width: 27.75em;
  height: 20.75em;
  position: absolute;
  transform: translate(-50%, -50%);
  top: calc(50% + 3.1em);
  left: 50%;
  padding: 0 3.1em;
  display: flex;
  flex-direction: column;
  justify-content: center;
  backdrop-filter: blur(16px) saturate(180%);
    -webkit-backdrop-filter: blur(16px) saturate(180%);
    background-color: rgba(255, 255, 255, 0.76);
    border-radius: 12px;
    border: 1px solid rgba(209, 213, 219, 0.3);
}
form label {
  display: block;
  margin-bottom: 0.2em;
  font-weight: 600;
  color: #2e0d30;
}
form input {
  font-size: 0.95em;
  font-weight: 400;
  color: #3f3554;
  padding: 0.3em;
  border: none;
  border-bottom: 0.12em solid #3f3554;
  outline: none;
}
form input:focus {
  border-color: #f4c531;
}
form input:not(:last-child) {
  margin-bottom: 0.9em;
}
form button {
  font-size: 0.95em;
  padding: 0.8em 0;
  border-radius: 2em;
  border: none;
  outline: none;
  background-color: #f4c531;
  color: #2e0d30;
  text-transform: uppercase;
  font-weight: 600;
  letter-spacing: 0.15em;
  margin-top: 0.8em;
}
.panda-face {
  height: 7.5em;
  width: 8.4em;
  background-color: #ffffff;
  border: 0.18em solid #2e0d30;
  border-radius: 7.5em 7.5em 5.62em 5.62em;
  position: absolute;
  top: 2em;
  margin: auto;
  left: 0;
  right: 0;
}
.ear-l,
.ear-r {
  background-color: #3f3554;
  height: 2.5em;
  width: 2.81em;
  border: 0.18em solid #2e0d30;
  border-radius: 2.5em 2.5em 0 0;
  top: 1.75em;
  position: absolute;
}
.ear-l {
  transform: rotate(-38deg);
  left: 10.75em;
}
.ear-r {
  transform: rotate(38deg);
  right: 10.75em;
}
.blush-l,
.blush-r {
  background-color: #ff8bb1;
  height: 1em;
  width: 1.37em;
  border-radius: 50%;
  position: absolute;
  top: 4em;
}
.blush-l {
  transform: rotate(25deg);
  left: 1em;
}
.blush-r {
  transform: rotate(-25deg);
  right: 1em;
}
.eye-l,
.eye-r {
  background-color: #3f3554;
  height: 2.18em;
  width: 2em;
  border-radius: 2em;
  position: absolute;
  top: 2em;
}
.eye-l {
  left: 1.37em;
  transform: rotate(-20deg);
}
.eye-r {
  right: 1.37em;
  transform: rotate(20deg);
}
.eyeball-l,
.eyeball-r {
  height: 0.6em;
  width: 0.6em;
  background-color: #ffffff;
  border-radius: 50%;
  position: absolute;
  left: 0.6em;
  top: 0.6em;
  transition: 1s all;
}
.eyeball-l {
  transform: rotate(20deg);
}
.eyeball-r {
  transform: rotate(-20deg);
}
.nose {
  height: 1em;
  width: 1em;
  background-color: #3f3554;
  position: absolute;
  top: 4.37em;
  margin: auto;
  left: 0;
  right: 0;
  border-radius: 1.2em 0 0 0.25em;
  transform: rotate(45deg);
}
.nose:before {
  content: "";
  position: absolute;
  background-color: #3f3554;
  height: 0.6em;
  width: 0.1em;
  transform: rotate(-45deg);
  top: 0.75em;
  left: 1em;
}
.mouth,
.mouth:before {
  height: 0.75em;
  width: 0.93em;
  background-color: transparent;
  position: absolute;
  border-radius: 50%;
  box-shadow: 0 0.18em #3f3554;
}
.mouth {
  top: 5.31em;
  left: 3.12em;
}
.mouth:before {
  content: "";
  position: absolute;
  left: 0.87em;
}
.hand-l,
.hand-r {
  background-color: #3f3554;
  height: 2.81em;
  width: 2.5em;
  border: 0.18em solid #2e0d30;
  border-radius: 0.6em 0.6em 2.18em 2.18em;
  transition: 1s all;
  position: absolute;
  top: 8em;
}
.hand-l {
  left: 7.5em;
}
.hand-r {
  right: 7.5em;
}
.paw-l,
.paw-r {
  background-color: #3f3554;
  height: 3.12em;
  width: 3.12em;
  border: 0.18em solid #2e0d30;
  border-radius: 2.5em 2.5em 1.2em 1.2em;
  position: absolute;
  top: 27.56em;
}
.paw-l {
  left: 10em;
}
.paw-r {
  right: 10em;
}
.paw-l:before,
.paw-r:before {
  position: absolute;
  content: "";
  background-color: #ffffff;
  height: 1.37em;
  width: 1.75em;
  top: 1.12em;
  left: 0.55em;
  border-radius: 1.56em 1.56em 0.6em 0.6em;
}
.paw-l:after,
.paw-r:after {
  position: absolute;
  content: "";
  background-color: #ffffff;
  height: 0.5em;
  width: 0.5em;
  border-radius: 50%;
  top: 0.31em;
  left: 1.12em;
  box-shadow: 0.87em 0.37em #ffffff, -0.87em 0.37em #ffffff;
}
@media screen and (max-width: 500px) {
  .container {
    font-size: 14px;
  }
}

a:link{
  text-decoration: none;
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
                            <img class="main-logo" src="logom.png" alt="">
                          
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
                                    <!-- <a href="">
                                        <svg class="_1GTCc" viewBox="5 -1 12 25" height="17" width="17" fill="#686b78">
                                            <path
                                                d="M17.6671481,17.1391632 L22.7253317,22.1973467 L20.9226784,24 L15.7041226,18.7814442 C14.1158488,19.8024478 12.225761,20.3946935 10.1973467,20.3946935 C4.56550765,20.3946935 0,15.8291858 0,10.1973467 C0,4.56550765 4.56550765,0 10.1973467,0 C15.8291858,0 20.3946935,4.56550765 20.3946935,10.1973467 C20.3946935,12.8789625 19.3595949,15.3188181 17.6671481,17.1391632 Z M10.1973467,17.8453568 C14.4212261,17.8453568 17.8453568,14.4212261 17.8453568,10.1973467 C17.8453568,5.97346742 14.4212261,2.54933669 10.1973467,2.54933669 C5.97346742,2.54933669 2.54933669,5.97346742 2.54933669,10.1973467 C2.54933669,14.4212261 5.97346742,17.8453568 10.1973467,17.8453568 Z">
                                            </path>
                                        </svg>
                                        <span>Search</span>
                                    </a> -->
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
                                <div class="nav-item">
                                    <a href="./login.jsp">
                                        <svg class="_1GTCc" viewBox="6 0 12 24" height="19" width="18" fill="#686b78">
                                            <path
                                                d="M11.9923172,11.2463768 C8.81761115,11.2463768 6.24400341,8.72878961 6.24400341,5.62318841 C6.24400341,2.5175872 8.81761115,0 11.9923172,0 C15.1670232,0 17.740631,2.5175872 17.740631,5.62318841 C17.740631,8.72878961 15.1670232,11.2463768 11.9923172,11.2463768 Z M11.9923172,9.27536232 C14.0542397,9.27536232 15.7257581,7.64022836 15.7257581,5.62318841 C15.7257581,3.60614845 14.0542397,1.97101449 11.9923172,1.97101449 C9.93039471,1.97101449 8.25887628,3.60614845 8.25887628,5.62318841 C8.25887628,7.64022836 9.93039471,9.27536232 11.9923172,9.27536232 Z M24,24 L0,24 L1.21786143,19.7101449 L2.38352552,15.6939891 C2.85911209,14.0398226 4.59284263,12.7536232 6.3530098,12.7536232 L17.6316246,12.7536232 C19.3874139,12.7536232 21.1256928,14.0404157 21.6011089,15.6939891 L22.9903494,20.5259906 C23.0204168,20.63057 23.0450458,20.7352884 23.0641579,20.8398867 L24,24 Z M21.1127477,21.3339312 L21.0851024,21.2122487 C21.0772161,21.1630075 21.0658093,21.1120821 21.0507301,21.0596341 L19.6614896,16.2276325 C19.4305871,15.4245164 18.4851476,14.7246377 17.6316246,14.7246377 L6.3530098,14.7246377 C5.4959645,14.7246377 4.55444948,15.4231177 4.32314478,16.2276325 L2.75521062,21.6811594 L2.65068631,22.0289855 L21.3185825,22.0289855 L21.1127477,21.3339312 Z">
                                            </path>
                                        </svg>
                                        <span>Sign In</span>
                                    </a>
                                </div>
                            </li>
                            <li>
                                <div class="nav-item">
                                    <a href="#" style="font-size: 20px;" >
                                          &#128722;
                                        <span>Cart<sup>0</sup></span>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </header>



<%  if(showpas) { %>
    <div class="container">
      <form action="" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" autocomplete="off"  placeholder="Username here..." required />
        <!-- <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="Password here..." required />
       -->
        <button>Login</button> 
        <br>  
        <div class="create">
        
          <a href="login.jsp">Already Have Account</a>
          </div>
      </form>



      
      <div class="ear-l"></div>
      <div class="ear-r"></div>
      <div class="panda-face">
        <div class="blush-l"></div>
        <div class="blush-r"></div>
        <div class="eye-l">
          <div class="eyeball-l"></div>
        </div>
        <div class="eye-r">
          <div class="eyeball-r"></div>
        </div>
        <div class="nose"></div>
        <div class="mouth"></div>
      </div>
      <div class="hand-l"></div>
      <div class="hand-r"></div>
      <div class="paw-l"></div>
      <div class="paw-r"></div>
    </div>
    <!-- Script -->
    <script>
        let usernameRef = document.getElementById("username");
        let passwordRef = document.getElementById("password");
        let eyeL = document.querySelector(".eyeball-l");
        let eyeR = document.querySelector(".eyeball-r");
        let handL = document.querySelector(".hand-l");
        let handR = document.querySelector(".hand-r");
        
        let normalEyeStyle = () => {
          eyeL.style.cssText = `
            left:0.6em;
            top: 0.6em;
          `;
          eyeR.style.cssText = `
          right:0.6em;
          top:0.6em;
          `;
        };
        
        let normalHandStyle = () => {
          handL.style.cssText = `
                height: 2.81em;
                top:8.4em;
                left:7.5em;
                transform: rotate(0deg);
            `;
          handR.style.cssText = `
                height: 2.81em;
                top: 8.4em;
                right: 7.5em;
                transform: rotate(0deg)
            `;
        };
        //When clicked on username input
        usernameRef.addEventListener("focus", () => {
          eyeL.style.cssText = `
            left: 0.75em;
            top: 1.12em;  
          `;
          eyeR.style.cssText = `
            right: 0.75em;
            top: 1.12em;
          `;
          normalHandStyle();
        });
        //When clicked on password input
        passwordRef.addEventListener("focus", () => {
          handL.style.cssText = `
                height: 6.56em;
                top: 3.87em;
                left: 11.75em;
                transform: rotate(-155deg);    
            `;
          handR.style.cssText = `
            height: 6.56em;
            top: 3.87em;
            right: 11.75em;
            transform: rotate(155deg);
          `;
          normalEyeStyle();
        });
        //When clicked outside username and password input
        document.addEventListener("click", (e) => {
          let clickedElem = e.target;
          if (clickedElem != usernameRef && clickedElem != passwordRef) {
            normalEyeStyle();
            normalHandStyle();
          }
        });</script>

<% } %>

<!-- Update pass -->

<%  if(!showpas) { %>


    <%
    String loggedInUser = (session != null) ? (String) session.getAttribute("loggedInUser") : null;

    if (loggedInUser == null || loggedInUser.isEmpty()) {
        try {
            response.sendRedirect("index.jsp");
        } finally{

        }
    }
%>


<%
if (request.getMethod().equals("POST")) {

    String password = request.getParameter("password");

    try {
        Class.forName("oracle.jdbc.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "jake");

        Statement stmt = con.createStatement();
        String sql = "UPDATE log SET pas = '" + password + "' WHERE name = '" + loggedInUser + "'";
        stmt.executeUpdate(sql);

        boolean matched = false;
       
      if (matched) {

        out.println("<script>alert('Changed  Sucessfull');</script>");
        out.println("<script>window.location.href='login.jsp';</script>");

      } else {  
        out.println("<script>alert('Invalid Credintials');</script>");
      }
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error occurred while processing the request: " + e.getMessage());
    }
}
%>





<div class="container">
    <form action="" method="post">
      <!-- <label for="username">Username:</label>
      <input type="text" id="username" name="username" autocomplete="off"  placeholder="Username here..." required />
       -->
      
      <label for="password">Password:</label>
      <input type="password" id="password" name="password" placeholder="Password here..." required />
      <button>Login</button>
      <br>  
      <div class="create">
      
        <a href="register.jsp">Create Account Now</a>
        </div>
    </form>

    
    <div class="ear-l"></div>
    <div class="ear-r"></div>
    <div class="panda-face">
      <div class="blush-l"></div>
      <div class="blush-r"></div>
      <div class="eye-l">
        <div class="eyeball-l"></div>
      </div>
      <div class="eye-r">
        <div class="eyeball-r"></div>
      </div>
      <div class="nose"></div>
      <div class="mouth"></div>
    </div>
    <div class="hand-l"></div>
    <div class="hand-r"></div>
    <div class="paw-l"></div>
    <div class="paw-r"></div>
  </div>
  <!-- Script -->
  <script>
      let usernameRef = document.getElementById("username");
      let passwordRef = document.getElementById("password");
      let eyeL = document.querySelector(".eyeball-l");
      let eyeR = document.querySelector(".eyeball-r");
      let handL = document.querySelector(".hand-l");
      let handR = document.querySelector(".hand-r");
      
      let normalEyeStyle = () => {
        eyeL.style.cssText = `
          left:0.6em;
          top: 0.6em;
        `;
        eyeR.style.cssText = `
        right:0.6em;
        top:0.6em;
        `;
      };
      
      let normalHandStyle = () => {
        handL.style.cssText = `
              height: 2.81em;
              top:8.4em;
              left:7.5em;
              transform: rotate(0deg);
          `;
        handR.style.cssText = `
              height: 2.81em;
              top: 8.4em;
              right: 7.5em;
              transform: rotate(0deg)
          `;
      };
      //When clicked on username input
      usernameRef.addEventListener("focus", () => {
        eyeL.style.cssText = `
          left: 0.75em;
          top: 1.12em;  
        `;
        eyeR.style.cssText = `
          right: 0.75em;
          top: 1.12em;
        `;
        normalHandStyle();
      });
      //When clicked on password input
      passwordRef.addEventListener("focus", () => {
        handL.style.cssText = `
              height: 6.56em;
              top: 3.87em;
              left: 11.75em;
              transform: rotate(-155deg);    
          `;
        handR.style.cssText = `
          height: 6.56em;
          top: 3.87em;
          right: 11.75em;
          transform: rotate(155deg);
        `;
        normalEyeStyle();
      });
      //When clicked outside username and password input
      document.addEventListener("click", (e) => {
        let clickedElem = e.target;
        if (clickedElem != usernameRef && clickedElem != passwordRef) {
          normalEyeStyle();
          normalHandStyle();
        }
      });</script>



<% } %>



</body>
</html>