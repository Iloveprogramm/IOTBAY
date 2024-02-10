<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IoTBay main page</title>
  <link rel="stylesheet" href="landing.css">
</head>

<jsp:useBean id="cart" scope="session" class="Controllers.CartController" />

<%
    String filter = "";
    if (request.getParameter("searchButton") != null) {
        if (request.getParameter("searchButton").equals("Clear")){
            filter = "";
        }else{
            filter = request.getParameter("searchBar");
        }
    }
    
    if (request.getParameter("submit") != null) {
        String productId = request.getParameter("proNo");
        String productName = request.getParameter("proName");
        double productPrice = Double.parseDouble(request.getParameter("proPrice"));

        cart.addProduct(productId, productName, productPrice);
    }
%>
    
<body>
  <header>
        <h1>Shop</h1>
    <nav>
      <button onclick="location.href='cart.jsp'">Cart: <%=cart.showShoppingCartSize()%></button>
    </nav>
  </header>
  
  <main>

    <div class="container">
        <form name="FilterForm" method="POST">
            <input type="text" name="searchBar" value="<%=filter%>" size="30"/>
            <label for="FilterType">Filter by</label>
            <select name="FilterType" id = "FilterType">
                <option>All</option>
                <option>Devices</option>
                <option>Parts</option>
                <option>Tools</option>
            </select>
            <input type="submit" value="Search" name="searchButton" />
            <input type="submit" value="Clear" name="searchButton" />
        </form>
    </div>
    <div class="container">
        <jsp:useBean id="product" scope="page" class="Controllers.ProductController" />
        <%
        for (int i = 0; i < 100; i++){
        %><jsp:setProperty name="product" property="id" value="<%=i%>" /><%
            if (product.getInfo()){
                if (filter.equals("")){
            %>
                <div class = card style ="width: 210px;height: 250px">
                    <%=product.getName()%><br>
                    <img src="<%=product.getImage_dir()%>" alt="<%=product.getName()%>" style ="width:200px ;height:150px"/><br>
                    <form name="add_item" method="POST">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type ="hidden" name="proName" value="<%=product.getName()%>"/>
                        <input type ="hidden" name="proPrice" value="<%=product.getPrice()%>"/>
                        <input type="submit" name="submit" value="Add to cart"/>
                    </form>
                    <form name="add_item" method="POST" action = "ViewProductDetails.jsp">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="details" value="View details"/>
                    </form>
                </div>
            <%
                }else if (product.getName().toLowerCase().contains(filter.toLowerCase())){
                    %>
                <div class = card style ="width: 210px;height: 250px">
                    <%=product.getName()%><br>
                    <img src="<%=product.getImage_dir()%>" alt="<%=product.getName()%>" style="width:200px ;height:150px"/>
                    <form name="add_item" method="POST">
                        <input type="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="hidden" name="proName" value="<%=product.getName()%>"/>
                        <input type="hidden" name="proPrice" value="<%=product.getPrice()%>"/>
                        <input type="submit" name="submit" value="Add to cart"/>
                    </form>
                    <form name="add_item" method="POST" action="test.jsp">
                        <input type="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="details" value="View details"/>
                    </form>
                </div>
            <%
                }
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