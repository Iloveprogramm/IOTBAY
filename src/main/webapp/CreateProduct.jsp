<%-- 
    Document   : EditProduct
    Created on : 5 May 2023, 12:45:12 pm
    Author     : Griffin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@page import="Controllers.ProductController"%>
<!DOCTYPE html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="landing.css">
    </head>
    
    <header>
        <h1>Add Product</h1>
        <nav>
            <button onclick="location.href='staff.jsp'">Staff Home</button>
        </nav>
    </header>    
    <jsp:useBean id="product" scope="page" class="Controllers.ProductController" />
    <body>
        <div class="container" style ="height: 800px">
            <div class = card style ="width: 500px;height: 600px">   
                    <form name="edit_item" method="POST" >
                        <label>Name: </label><br><input type="text" name="proName"/><br><br>
                        <label>Description: </label><br><textarea name="proDesc" rows="4" cols="20" ></textarea><br><br>
                        <label>Price: </label><br><input type="text" name="proPrice"/><br><br>
                        <label>Stock: </label><br><input type="text" name="proStock"/><br><br>
                        <label>Image directory: </label><br><input type="text" name="proImageDir"/><br><br>
                        <select name="FilterType" id = "FilterType">
                            <option>Devices</option>
                            <option>Parts</option>
                            <option>Tools</option>
                        </select><br><br>
                        <input type="submit" value="Add Product" name="addItem" /><br>
                    </form> 
                    <button onclick="location.href='staffProducts.jsp'">Cancel</button>
                </div>
        </div>
        <footer>
            <p>&copy; 2023 IoTBay All Rights Reserved</p>
        </footer>
    </body>
        <%
        if (request.getParameter("addItem") != null){
            //Get product details from request parameters
            //System.out.println("ID: " + product.getId() + " Name: " + product.getName()+ " Description: " + product.getDescription() + " Price: " + product.getPrice() + " Stock: " + product.getStock() + " Image Directory: " + product.getImage_dir() + " Type: " + product.getType());
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
               boolean added = product.addProduct(name, description, price, stock, image_dir, type);
               //System.out.println("ID: " + product.getId() + " Name: " + product.getName()+ " Description: " + product.getDescription() + " Price: " + product.getPrice() + " Stock: " + product.getStock() + " Image Directory: " + product.getImage_dir() + " Type: " + product.getType());
               System.out.println(added);
               if(added){
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

