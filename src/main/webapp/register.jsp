<html>
        <%@page import="Controllers.DatabaseController"%>
    <head>
        <link rel="stylesheet" href="landing.css" type="text/css"/>
        <link rel="stylesheet" href="style1.css" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>IoTBay register page</title>
    </head>
    
    <body>
        
        <header>
       
        <h1>IoTBay</h1>
    </header>
        
        <div class="container_login">
            <h2>Register</h2>
            <div>
            <%
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String Fname = request.getParameter("first name");
                String Lname = request.getParameter("last name");
                String accType = request.getParameter("accountType");
                
                String errorMessage = "";

                if (email != null && password != null) {
                    boolean accountCreated = DatabaseController.createAccount(email, password, Fname, Lname, accType);
                    if (!accountCreated) {
                        errorMessage = "Invalid username, password, first name or last name";
                    } else {
                        response.sendRedirect("login.jsp");
                    }
                }
            %>

            <form method="post">
                <label for="email">Email Address:</label>
                <input type="text" id="email" name="email" placeholder="Enter your email address" required>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                <label for="first name">First name:</label>
                <input type="text" id="first name" name="first name" placeholder="Enter your first name" required>
                <label for="last name">Last name:</label>
                <input type="text" id="last name" name="last name" placeholder="Enter your last name" required>
                <label for="accountType">Account type:</label>
                <select id="accountType" name="accountType">
                  <option value="Customer">Customer</option>
                  <option value="Staff">Staff</option>
                </select>
                <input type="submit" value="Submit">  
                
            </form>
        </div>
        <% if (!errorMessage.isEmpty()) { %>
            <p id="error-message" style="color:red;"><%= errorMessage %></p>
        <% } %>
        <br><br>
            <div class="back-button">
            <a href="index.jsp"> Back to Landing Page</a>
        </div>
        </div>
        <footer>
        <p>&copy; 2023 IoTBay All Rights Reserved</p>
        </footer>
    </body>
</html>