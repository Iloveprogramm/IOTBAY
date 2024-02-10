<html>
    <%@page import="Controllers.DatabaseController"%>
<head>
    <link rel="stylesheet" href="landing.css" type="text/css"/>
    <link rel="stylesheet" href="style1.css" type="text/css"/>
    <title>IoTBay login page</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
</head>
<body>
    <header>
        <h1>IoTBay</h1>
    </header>

    <div class="container_login">
        <h2>Login</h2>
        <div>

            <jsp:useBean id="account_info" scope="session" class="Controllers.AccountController" />
            <jsp:setProperty name="account_info" property="email" value= "<%=request.getParameter("email")%>" />
            <jsp:setProperty name="account_info" property="password" value="<%=request.getParameter("password")%>" />
            <%  
                String email;
                if (account_info.getEmail() == null){
                    email = "";
                }else{
                    email = account_info.getEmail();
                }
                   

                boolean accountVerified = account_info.login();
                
                String errorMessage = "";

                if (account_info.getEmail() != null && account_info.getPassword() != null) {
                    // Check username and password
                    if (accountVerified) {
                        if(account_info.getAccType().equals("Staff")){
                            response.sendRedirect("staff.jsp");
                        }
                        else if(account_info.getAccType().equals("Admin")){
                            response.sendRedirect("admin.jsp");
                        }else{
                            response.sendRedirect("welcome.html");
                        }
                    }else{
                        errorMessage = "Incorrect username or password";
                    }
                }
            %>
            <form method="post">
                <label for="email">Email Address:</label>
                <input type="text" id="email" name="email" placeholder ="Enter your email address" value ="<%=email%>" required>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder ="Enter your password" required>
                <input type="submit" value="Submit">
            </form>
        </div>
            <p id="error-message" style="color:red;"><%= errorMessage %> <br></p>
        <br>
        <p>Don't have an account? <br>
            <a href="register.jsp">register an account</a>.</p>
        <div class="back-button">
            <a href="index.jsp">Back to Landing Page</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2023 IoTBay All Rights Reserved</p>
    </footer>
</body>
</html>