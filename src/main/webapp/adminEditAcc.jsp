<%@ page import="Controllers.AccountController" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="Controllers.DatabaseController" %>

<jsp:useBean id="database" scope="session" class="Controllers.DatabaseController"/>
<%
    String accountId = request.getParameter("accountId");
    String newAccType = request.getParameter("newAccType");
    AccountController account = null;
    boolean isCreatingUser = false;
    
    // Retrieve the selected account based on the accountId
    if (accountId != null) {
        List<AccountController> accounts = database.adminGetAccounts();
        if (accounts != null) {
            for (AccountController acc : accounts) {
                if (acc.getId().equals(accountId)) {
                    account = acc;
                    isCreatingUser = false;
                    break;
                }
            }
        }
    }

    // If account not found, create a new user
    if (account == null) {
        isCreatingUser = true;
        account = new AccountController();
        // Set the account ID
        account.setId(accountId);
        account.setStatus("activated");
        account.setAccType(newAccType);
    }

    if (request.getParameter("Update") != null && accountId != null) {
        // Get the updated account details from the request parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String accType = request.getParameter("accountType");
        String status = request.getParameter("status");
        String typepos = request.getParameter("typepos");
        String phonenum = request.getParameter("phonenum");
        String address = request.getParameter("address");
        
        // Perform null check for the string values
        if (email != null && password != null && firstName != null && lastName != null && accType != null && status != null && typepos != null && phonenum != null && address != null && !accType.equals("")) {             if(isCreatingUser){
                boolean success = database.adminCreateAccount(email, password, firstName, lastName, accType, status, typepos, phonenum, address);
                if(success){
                response.sendRedirect("admin.jsp");
                }
            }
            else{
                // Update the account details
                database.adminEditAccount(accountId, email, password, firstName, lastName, accType, status, typepos, phonenum, address);
                response.sendRedirect("admin.jsp");
            }
            
        } else {
            // Handle the case when any of the values are null
            // You can display an error message or perform any other desired action
            // For example:
            out.println("Error: Please fill in all the fields.");
            out.println("Null values: ");
    if (email == null) out.println("Email is null. ");
    if (password == null) out.println("Password is null. ");
    if (firstName == null) out.println("First Name is null. ");
    if (lastName == null) out.println("Last Name is null. ");
    if (accType == null) out.println("Account Type is null. ");
    if (status == null) out.println("Status is null. ");
    if (typepos == null) out.println("Type/Position is null. ");
    if (phonenum == null) out.println("Phone Number is null. ");
    if (address == null) out.println("Address is null. ");
        }
    }
%>


<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IoTBay Admin - Edit Account</title>
    <link rel="stylesheet" href="landing.css">
    <link rel="stylesheet" href="style1.css" type="text/css"/>
</head>
<body>
    <h1>Edit Account</h1>
    <form name="edit_item" method="POST">
        <input type="hidden" name="accountId" value="<%= account.getId() %>">
        <label for="status">Activate:</label>
        <!--<input type="text" id="status" name="status" value="<%= account.getStatus() != null ? account.getStatus() : "" %>"><br>-->
        <select id="status" name="status">
            <option value="activated" <%= account.getStatus() != null && account.getStatus().equals("activated") ? "selected" : "" %>>activated</option>
            <option value="deactivated" <%= account.getStatus() != null && account.getStatus().equals("deactivated") ? "selected" : "" %>>deactivated</option>
        </select><br>
        <label for="email">Email:</label>
        <input type="text" id="email" name="email" value="<%= account.getEmail() != null ? account.getEmail() : "" %>"><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" value="<%= account.getPassword() != null ? account.getPassword() : "" %>"><br>
        <label for="firstName">First Name:</label>
        <input type="text" id="firstName" name="firstName" value="<%= account.getFname() != null ? account.getFname() : "" %>"><br>
        <label for="lastName">Last Name:</label>
        <input type="text" id="lastName" name="lastName" value="<%= account.getLname() != null ? account.getLname() : "" %>"><br>
        <label for="accountType">Account Type:</label>
        <select id="accountType" name="accountType">
            <option value="Staff" <%= account.getAccType() != null && account.getAccType().equals("Staff") ? "selected" : "" %>>Staff</option>
            <option value="Customer" <%= account.getAccType() != null && account.getAccType().equals("Customer") ? "selected" : "" %>>Customer</option>
            <option value="" <%= account.getAccType() == null ? "selected" : "" %>>Select Type</option>
        </select><br>
       <% if (account.getAccType() != null) { %>
    <% if (account.getAccType().equals("Customer")) { %>
        <label for="typepos">Type:</label>
        <select id="typepos" name="typepos">
            <option value="Individual" <%= account.getTypepos() != null && account.getTypepos().equals("Individual") ? "selected" : "" %>>Individual</option>
            <option value="Company" <%= account.getTypepos() != null && account.getTypepos().equals("Company") ? "selected" : "" %>>Company</option>
        </select><br>
    <% } else { %>
        <label for="typepos">Position:</label>
        <input type="text" id="typepos" name="typepos" value="<%= account.getTypepos() %>"><br>
    <% } %>
<% } else { %>
    <label for="typepos">Type(Company or Individual)/Position:</label>
    <input type="text" id="typepos" name="typepos"><br>
<% } %>

        <label for="phonenum">Phone Number:</label>
        <input type="text" id="phonenum" name="phonenum" value="<%= account.getPhonenum() != null ? account.getPhonenum() : "" %>"><br>
        <label for="address">Address:</label>
        <input type="text" id="address" name="address" value="<%= account.getAddress() != null ? account.getAddress() : "" %>"><br>
        <input type="submit" name="Update" value="Update">
    </form>
    
    <button onclick="location.href='admin.jsp'">Cancel</button>
</body>

</html>
