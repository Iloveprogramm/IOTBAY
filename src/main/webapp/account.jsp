<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IoTBay Account page</title>  
  <link rel="stylesheet" href="landing.css">
  <link rel="stylesheet" href="style1.css" type="text/css"/>
</head>

<jsp:useBean id="account_info" scope="session" class="Controllers.AccountController"/>
<%
    if (request.getParameter("delete") != null) {
    account_info.delete();
    response.sendRedirect("index.jsp");
    }

    %>
<body>
  <header>
        <h1>Account Page</h1>
    <nav>
        <button onclick="location.href='index.jsp'">Home</button>
        <button onclick="location.href='logout.jsp'">Logout</button>
    </nav>
  </header>
  
    <div class = "container_login" style = "align-items: center">
          <h3>Your account Information</h3>
          <table style ="text-align: left;">
              <tr>
                  <th style = "width:200px">Email Address:</th>
                  <td style = "width:200px"><%=account_info.getEmail()%></td>
              </tr>
              <tr>
                  <th>Password:</th>
                  <td><%=account_info.getPassword()%></td>
              </tr>
              <tr>
                  <th>First name:</th>
                  <td><%=account_info.getFname()%></td>
              </tr>
              <tr>
                  <th>Last name:</th>
                  <td><%=account_info.getLname()%></td>
              </tr>
              <tr>
                  <th>Account Type:</th>
                  <td><%=account_info.getAccType() %></td>
              </tr>
          </table><br>
          <form name="add_item" method="POST" action = "Logs.jsp">
            <input type="submit" name="logs" value="Logs"/>
        </form>
          
          <form name="add_item" method="POST" action = "editAccounts.jsp">
            <input type="submit" name="edit" value="Edit account details"/>
        </form>     

        <form name="add_item" method="POST">
            <input type="submit" name="delete" value="delete"/>
        </form><br>
    </div>
  
  <footer>
    <p>&copy; 2023 IoTBay All Rights Reserved</p>
  </footer>
</body>
</html>
