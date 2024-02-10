<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IoTBay main page</title>
  <link rel="stylesheet" href="landing.css">
</head>

<jsp:useBean id="account_info" scope="session" class="Controllers.AccountController" />
<% if (account_info.verifyAccount()){
        if(account_info.getAccType() == "Staff"){
            response.sendRedirect("staff.jsp");
        }
    }
%>

<body>
  <header>
        <h1>IoTBay</h1>
    <nav>
        <button onclick="location.href='shop.jsp'">Shop</button>
        <button onclick="location.href='cart.jsp'">Cart</button>
        <button onclick="location.href='account.jsp'">Account: <%=account_info.getEmail()%></button>
        <button onclick="location.href='logout.jsp'">Logout</button>
    </nav>
  </header>
        
  <main>
    <section class="hero">
      <h1>IoTBay</h1>
      <p><b>Here is some content about IoTBay.</b></p>
      <a href="#" class="gh">Learn More</a>
    <div class="container">
    
     <jsp:useBean id="product" scope="page" class="Controllers.ProductController" />
        <%
        for (int i = 0; i < 100; i++){
        %><jsp:setProperty name="product" property="id" value="<%=i%>" /><%
            if (product.getInfo()){
            %>
                <div class="card">
                    <img src="<%=product.getImage_dir()%>" alt="<%=product.getName()%>" width="200" height="200"/>
                    <h2 class ="card-name"> <%=product.getName()%> </h2>
                </div>
            <%
            }
        }
        %>     
       
    </div>
  </main>
  
  <footer>
    <p>&copy; 2023 IoTBay All Rights Reserved</p>
  </footer>
</body>
</html>
