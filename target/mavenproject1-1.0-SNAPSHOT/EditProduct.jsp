<%-- 
    Document   : EditProduct
    Created on : 5 May 2023, 12:45:12 pm
    Author     : Griffin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="landing.css">
    </head>
    
    <header>
        <h1>View Item Details</h1>
        <nav>
            <button onclick="location.href='staff.jsp'">Staff Home Page</button>
        </nav>
    </header>
    
    <%int proNO = Integer.valueOf(request.getParameter("proNo"));%>
    <jsp:useBean id="product" scope="page" class="Controllers.ProductController" />
    <jsp:setProperty name="product" property="id" value="<%=proNO%>" />
    
    <body>
        <div class="container" style ="height: 800px">
            <%if (product.getInfo()){%>
                <div class = card style ="width: 500px;height: 600px">
                    <%=product.getName()%><br>
                    <img src="<%=product.getImage_dir()%>" alt="<%=product.getName()%>" style ="width:200px ;height:150px"/><br>
                    
                    <form name="edit_item" method="POST" >
                        <input type ="hidden" name="proNo" value="<%=product.getId()%>"/>
                        <label>Name: </label><br><input type="text" name="proName" value="<%=product.getName()%>"/><br><br>
                        <label>Description: </label><br><textarea name="proDesc" rows="4" cols="20" ><%=product.getDescription()%></textarea><br><br>
                        <label>Price: </label><br><input type="text" name="proPrice" value="<%=product.getPrice()%>"/><br><br>
                        <label>Stock: </label><br><input type="text" name="proStock" value="<%=product.getStock()%>"/><br><br>
                        <label>Image directory: </label><br><input type="text" name="proImageDir" value="<%=product.getImage_dir()%>"/><br><br>
                        <select name="FilterType" id = "FilterType">
                            <option>Devices</option>
                            <option>Parts</option>
                            <option>Tools</option>
                        </select><br><br>
                        <input type="submit" value="Change details" name="changeDetails" /><br>
                    </form> 
                    <button onclick="location.href='staffProducts.jsp'">Cancel</button>
                </div>
            <%}%>  
        </div>
        <footer>
            <p>&copy; 2023 IoTBay All Rights Reserved</p>
        </footer>
    </body>
        <%
        
        if (request.getParameter("changeDetails") != null){
            //Get updated product details from request parameters
            //System.out.println("ID: " + product.getId() + " Name: " + product.getName()+ " Description: " + product.getDescription() + " Price: " + product.getPrice() + " Stock: " + product.getStock() + " Image Directory: " + product.getImage_dir() + " Type: " + product.getType());
            String id = request.getParameter("proNo");
            String name =request.getParameter("proName");
            String description = request.getParameter("proDesc");
            String price = request.getParameter("proPrice");
            String stock = request.getParameter("proStock");
            //double price = Double.parseDouble(request.getParameter("proPrice"));
            //int stock = Integer.parseInt(request.getParameter("proStock"));
            String image_dir = request.getParameter("proImageDir");
            String type = request.getParameter("FilterType");
            //System.out.println("Name: " + name + " Description: " + description + " Price: " + price + " Stock: " + stock + " Image Directory: " + image_dir + " Type: " + type);
            //Null check for form values
            if(!name.equals("") && !description.equals("") && !price.equals("") && !stock.equals("") && !image_dir.equals("")){
               //System.out.println("Fields all filled!");
               boolean edited = product.editProduct(id, name, description, price, stock, image_dir, type);
               //System.out.println("ID: " + product.getId() + " Name: " + product.getName()+ " Description: " + product.getDescription() + " Price: " + product.getPrice() + " Stock: " + product.getStock() + " Image Directory: " + product.getImage_dir() + " Type: " + product.getType());
               //System.out.println(edited);
               if(edited){
                    //System.out.println("ID: " + product.getId() + " Name: " + product.getName()+ " Description: " + product.getDescription() + " Price: " + product.getPrice() + " Stock: " + product.getStock() + " Image Directory: " + product.getImage_dir() + " Type: " + product.getType());
                    response.sendRedirect("staffProducts.jsp");
                }
            }    
            else{
               System.out.print("Error: Please fill in all fields");
            }
        }
    %>
</html>

