<%-- 
    Document   : ViewProductDetails
    Created on : 14 May 2023, 7:09:47 pm
    Author     : jishu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="landing.css">
    </head>
    
    <header>
        <h1>Edit Item Details</h1>
  </header>
    
    <%int proNO = Integer.valueOf(request.getParameter("proNo"));%>
    <jsp:useBean id="product" scope="page" class="Controllers.ProductController" />
    <jsp:setProperty name="product" property="id" value="<%=proNO%>" />
    <body>
        <div class="container" style ="height: 700px">
        
        <%if (product.getInfo()){%>
                <div class = card style ="width: 500px;height: 500px">
                    <%=product.getName()%><br>
                    <img src="<%=product.getImage_dir()%>" alt="<%=product.getName()%>" style ="width:200px ;height:150px"/><br>
                    <form name="edit_item" method="POST" action = "test.jsp">
                        <label>Name: </label><br><%=product.getName()%><br><br>
                        <label>Description: </label><br><%=product.getDescription()%><br><br>
                        <label>Price: </label><br><%=product.getPrice()%><br><br>
                        <label>Stock: </label><br><%=product.getStock()%><br><br>
                        <label>Image directory: </label><br><%=product.getImage_dir()%><br><br>
                        <label>Type: </label><br><%=product.getType()%>
                    </form>
                    
                </div>
         <%}%>  
        </div>
         
  <footer>
    <p>&copy; 2023 IoTBay All Rights Reserved</p>
  </footer>
</body>
</html>
