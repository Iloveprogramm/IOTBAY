<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IoTBay main page</title>
  <link rel="stylesheet" href="landing.css">
</head>
<%@ page import="Controllers.ProductController" %>

<jsp:useBean id="product" scope="page" class="Controllers.ProductController" />
<%
       String filter = "";
       String type = "All";

       if (request.getParameter("searchButton") != null) {
           if (request.getParameter("searchButton").equals("Clear")){
               filter = "";
               type = "All";
            }
            else{
              filter = request.getParameter("searchBar");
              System.out.println(filter);
              type = request.getParameter("FilterType");
              System.out.println(type);
            }
        }
        
        if (request.getParameter("delPro") != null) {
            //System.out.println("Product being removed!");   
            product.removeProduct(request.getParameter("proNo"));
        }
    %>
    
<body>
  <header>
        <h1>Edit Products</h1>
    <nav>
      <button onclick="location.href='staff.jsp'">Staff Home</button>
    </nav>
  </header>
  
  <main>
    <div class="container">
         <form name="createPro" action="CreateProduct.jsp">
            <input type="submit" value="Create New Product" name="createPro" />
        </form>
    </div>
         
    <div class="container">
         <form name="FilterForm" method="POST">
            <input type="text" name="searchBar" value="<%=filter%>" size="30"/>
            <label for="FilterType">Filter by</label>
            <select name="FilterType" id = "FilterType">
                <option value="All">All</option>
                <option value="Devices">Devices</option>
                <option value="Parts">Parts</option>
                <option value="Tools">Tools</option>
            </select>
            <input type="submit" value="Search" name="searchButton" />
            <input type="submit" value="Clear" name="searchButton" />
        </form>
     </div>
    <div class="container">
            
        <%
        for (int i = 0; i < 100; i++){
        %><jsp:setProperty name="product" property="id" value="<%=i%>" /><%
            if (product.getInfo()){
                //has no name or type
                if(filter.equals("") && type.equals("All")){
            %>
                <div class = card style ="width: 210px;height: 250px">
                    <%=product.getName()%><br>
                    <img src="<%=product.getImage_dir()%>" alt="<%=product.getName()%>" style ="width:200px ;height:150px"/><br>
                    <form name="add_item" method="POST" action = "ViewProductDetails.jsp">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="details" value="View details"/>
                    </form>
                    <form name="add_item" method="POST" action="EditProduct.jsp">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="submit" value="Edit item"/>
                    </form>
                    <form name="add_item" method="POST">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="delPro" value="Delete item"/>
                    </form>
                    
                </div>
            <%
                }
                //has search no type
                else if(!filter.equals("") && type.equals("All")){
                    if (product.getName().toLowerCase().contains(filter.toLowerCase())){
                    %>
                <div class = card style ="width: 210px;height: 250px">
                    <%=product.getName()%><br>
                    <img src="<%=product.getImage_dir()%>" alt="<%=product.getName()%>" style ="width:200px ;height:150px"/>
                    <form name="add_item" method="POST">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="submit" value="Edit item"/>
                    </form>
                    <form name="add_item" method="POST" action = "test.jsp">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="details" value="View details"/>
                    </form>
                    <form name="add_item" method="POST">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="delPro" value="Delete item"/>
                    </form>
                </div>
            <%      }
                }
                //no search has type
                else if(filter.equals("") && !type.contains("All")){
                    if (product.getType().equals(type)){%>
                    <div class = card style ="width: 210px;height: 250px">
                    <%=product.getName()%><br>
                    <img src="<%=product.getImage_dir()%>" alt="<%=product.getName()%>" style ="width:200px ;height:150px"/>
                    <form name="add_item" method="POST">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="submit" value="Edit item"/>
                    </form>
                    <form name="add_item" method="POST" action = "test.jsp">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="details" value="View details"/>
                    </form>
                    <form name="add_item" method="POST">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="delPro" value="Delete item"/>
                    </form>
                </div>
                    <%}
                }
                //has search and type
                else if(!filter.equals("") && !type.equals("All")){
                    if (product.getName().toLowerCase().contains(filter.toLowerCase()) && product.getType().equals(type)){
                    %>    
                    <div class = card style ="width: 210px;height: 250px">
                    <%=product.getName()%><br>
                    <img src="<%=product.getImage_dir()%>" alt="<%=product.getName()%>" style ="width:200px ;height:150px"/>
                    <form name="add_item" method="POST">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="submit" value="Edit item"/>
                    </form>
                    <form name="add_item" method="POST" action = "test.jsp">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="details" value="View details"/>
                    </form>
                    <form name="add_item" method="POST">
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <input type="submit" name="delPro" value="Delete item"/>
                    </form>
                    </div>
            <%
                }
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
