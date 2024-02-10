<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IoTBay main page</title>  
  <link rel="stylesheet" href="landing.css">
  <link rel="stylesheet" href="style1.css" type="text/css"/>
  <%@page import="Controllers.DatabaseController"%>
</head>

<jsp:useBean id="account_info" scope="session" class="Controllers.AccountController"/>
<%
    String errorMsg = "";
    if (request.getParameter("confirm") != null) {
        if(DatabaseController.editAccount(account_info.getId(), request.getParameter("email"), request.getParameter("password"), request.getParameter("fname"), request.getParameter("lname"))){
            account_info.setEmail(request.getParameter("email"));
            account_info.setPassword(request.getParameter("password"));
            account_info.refreshAccount();
            response.sendRedirect("account.jsp");
        }else{
            errorMsg = "invalid account details";
        }
    }

    %>
<body>
  <header>
        <h1>Edit Account Details</h1>
    <nav>
        <button onclick="location.href='index.jsp'">Home</button>
        <button onclick="location.href='account.jsp'">Account</button>
        <button onclick="location.href='logout.jsp'">Logout</button>
    </nav>
  </header>

          <div class = "container_login">
              <h3>Your account Information:</h3>
          <form name="edit_item" method="POST">
                        <label>Email Address: </label>
                        <input type="text" name="email" value="<%=account_info.getEmail()%>"/>
                        <label>Password: </label>
                        <input type="text"name="password" value="<%=account_info.getPassword()%>"/>
                        <label>First name: </label>
                        <input type="text" name="fname" value="<%=account_info.getFname()%>"/>
                        <label>Last name: </label>
                        <input type="text" name="lname" value="<%=account_info.getLname()%>"/>
                        <p id="error-message" style="color:red;"><%=errorMsg%> </p>
                        <input type="submit" name="confirm" value="Confirm changes"/>
           </form>
          </div>   

  
  <footer>
    <p>&copy; 2023 IoTBay All Rights Reserved</p>
  </footer>
</body>
</html>
