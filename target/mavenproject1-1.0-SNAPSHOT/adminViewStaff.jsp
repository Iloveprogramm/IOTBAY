<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Controllers.AccountController" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IoTBay Admin page</title>  
  <link rel="stylesheet" href="landing.css">
  <link rel="stylesheet" href="style1.css" type="text/css"/>
</head>
<style>
 .footer-message
 {
  font-size: 220px;
  color: #f7f7f7;
  text-align: center;
}
</style>
<jsp:useBean id="account_info" scope="session" class="Controllers.AccountController"/>
<%
%>
<jsp:useBean id="database" scope="session" class="Controllers.DatabaseController"/>
<%
    List<AccountController> accounts = database.adminGetStaffAccounts();
    if (request.getParameter("delete") != null) {
        String accEmail = request.getParameter("accountEmail");
        database.deleteAccount(accEmail);
        for (AccountController account : accounts) {
            if (account.getEmail().equals(accEmail)) {
                accounts.remove(account);
                break;
            }
        }
        response.sendRedirect("adminViewStaff.jsp");
    }
    String filter = "";
    Boolean isFilter;
    if (request.getParameter("searchBtn") != null) {
        filter = request.getParameter("searchName");
    }
    List<AccountController> filteredAccounts = new ArrayList<AccountController>();
    if (filter != null && !filter.trim().isEmpty()) {
        isFilter = true;
        for (AccountController account : accounts) {
            if ((account.getFname() != null && account.getFname().toLowerCase().contains(filter.toLowerCase())) ||
    (account.getLname() != null && account.getLname().toLowerCase().contains(filter.toLowerCase())) ||
    (account.getTypepos() != null && account.getTypepos().toLowerCase().contains(filter.toLowerCase()))) {
                filteredAccounts.add(account);
                
            }        
        }
        
    } else {
        isFilter = false;
        filteredAccounts = accounts;
    }
%>
<body>
  <header>
        <h1>admin View Staff Page</h1>
    <nav>
        <button onclick="location.href='admin.jsp'">Back</button>
        <button onclick="location.href='logout.jsp'">Logout</button>
    </nav>
  </header>
  <h1>Account List</h1>
  <form method="GET" action="adminViewStaff.jsp">
    <input type="text" name="searchName" placeholder="Search by name">
    <input type="submit" name="searchBtn"value="Search">
  </form>
  <table>
  <thead>
    <tr>
      <th>ID</th>
      <th>Email</th>
      <th>Password</th>
      <th>First Name</th>
      <th>Last Name</th>
      <th>Account Type</th>
      <th>Status</th>
      <th>Position</th>
      <th>Phone Number</th>
      <th>Address</th>
    </tr>
  </thead>
  <tbody>
    <% 
      if (accounts != null) {
        for (AccountController account : filteredAccounts) {
    %>
      <tr>
        <td><%= account.getId() %></td>
        <td><%= account.getEmail() %></td>
        <td><%= account.getPassword() %></td>
        <td><%= account.getFname() %></td>
        <td><%= account.getLname() %></td>
        <td><%= account.getAccType() %></td>
        <td><%= account.getStatus() %></td>
        <td><%= account.getTypepos() %></td>
        <td><%= account.getPhonenum() %></td>
        <td><%= account.getAddress() %></td>
        <td>
          <form method="POST" action="adminEditAcc.jsp">
            <input type="hidden" name="accountId" value="<%= account.getId() %>">
            <input type="submit" value="Modify">
          </form>
        </td>
        <td>
          <form method="POST" action="adminViewStaff.jsp">
            <input type="hidden" name="accountEmail" value="<%= account.getEmail() %>">
            <input type="submit" name="delete" value="Delete">
          </form>
        </td>
      </tr>
    <% }} %>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>
        <form method="POST" action="adminEditAcc.jsp">
          <input type="hidden" name="accountId">
          <input type="hidden" name="newAccType" value = "Staff">
          <input type="submit" name="new" value="New User">
        </form>
      </td>
    </tr>
  </tbody>
</table>

    <div class = "container_login" style = "align-items: center">
          <h3>Your account Information</h3>
          
          <table style ="text-align: left;">
              <tr>
                  <th style = "width:200px">Email Address:</th>
                  <td style = "width:200px"><%=account_info.getEmail()%></td>
              </tr>
              <tr>
                  <th>Account Type:</th>
                  <td><%=account_info.getAccType() %></td>
              </tr>
          </table><br>
    </div>
  </div>
<div class="footer-message">End of Page</div>
</div>
  <footer>
    <p>&copy; 2023 IoTBay All Rights Reserved</p>
  </footer>
</body>
</html>
