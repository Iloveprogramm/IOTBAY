<%-- 
    Document   : cart.jsp
    Author     : Chenjun Zheng
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IoTBay Shopping Cart</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="landing.css" type="text/css"/>
</head>
<style>
 .footer-message
 {
  font-size: 220px;
  color: #f7f7f7;
  text-align: center;
}
 .centered-alert {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 50%;
    z-index: 9999;
  }
</style>
<body>
    <header>
        <h1>IoTBay</h1>
    </header>
    <div class="button-container d-flex justify-content-between">
        <a class="Homebtn" href="main.jsp">Back to Home page</a>
        <div>
            <a class="Homebtn" href="order_history.jsp">View Order History</a>
        </div>
    </div>

    <table class="table">
        <thead>
            <tr>
                <th>Product Image</th>
                <th>Product Name</th>
                <th>Single Cost</th>
                <th>Quality</th>
                <th>Add/Remove</th>
            </tr>
        </thead>
        <%-- import cartcontroller productcontroller--%>
        <%@page import="java.util.Map, java.util.List, Controllers.CartController, Controllers.ProductController"%>
<%
    CartController cartController = new CartController();  // Create an instance of CartController.
    String action = request.getParameter("action");  
    String productIdStr = request.getParameter("productId");  
    
    if (action != null && productIdStr != null) 
    {
        int productId = Integer.parseInt(productIdStr);  
        if ("increase".equals(action)) // If the action parameter's value is "create"
        {
            cartController.increaseSingleProduct(productId);  // To add more items, call the CartController's increaseQuantity function.
        }
        else if ("decrease".equals(action))  // If the action parameter's value is "decrease"
        {
            cartController.decreaseSingleProduct(productId);  // To fewer items, use the decreaseQuantity method of the CartController.
        }
    } 
    else if (action != null && "cancel".equals(action))  // if the action parameter has the value "cancel"
    {
        cartController.cancelOrder();  // To cancel an order, use the CartController's cancelOrder function.
    }

    List<Map<String, Object>> cartItems = cartController.displayShoppingCartProducts();  // Obtain a list of the things you have in your shopping cart.
    double totalPrice = 0;  // Set the total price to 0 at the start.
    
    for (Map<String, Object> item : cartItems) 
    { 
        // Get information about shopping cart items
        Integer id = (Integer) item.get("id"); 
        String name = (String) item.get("name"); 
        Integer quantity = (Integer) item.get("quantity"); 
        Double price = (Double) item.get("price"); 
        double itemTotalPrice = price * quantity;
        totalPrice += itemTotalPrice; 
    }
        
    //once the order is in the shopping cart, customer can place order 
if ("POST".equalsIgnoreCase(request.getMethod()) && "placeOrder".equals(request.getParameter("action"))) 
{
    try {
        int userId = 1; 
        cartController.placeOrder(userId);
        session.setAttribute("totalPrice", totalPrice); 
        Double checkTotalPrice = (Double) session.getAttribute("totalPrice");
        out.println("Total price in cart page: " + checkTotalPrice);
        response.sendRedirect("Payment.jsp");
        return;
    } catch (Exception e) {
        out.println("<p style='color:red;'>Sorry, we cannot process your order at the moment. Please try again later.</p>");
    }
}

%>
     <tbody>
    <%  totalPrice = 0; 
        for (Map<String, Object> item : cartItems) 
    { 
        // Get information about shopping cart items
        Integer id = (Integer) item.get("id"); 
        String name = (String) item.get("name"); 
        Integer quantity = (Integer) item.get("quantity"); 
        Double price = (Double) item.get("price"); 
        double itemTotalPrice = price * quantity;
        totalPrice += itemTotalPrice; 

        ProductController product = new ProductController();
        product.setId(id);
        try {
            if (product.getInfo()) {
    %>
    <tr>
        <td><img src="<%=product.getImage_dir()%>" alt="<%=name%>" width="50" height="50"/></td>
        <td><%=name%></td>
        <td><%=price%></td>
        <td><%=quantity%></td>
        <td>
            <! -- Form to increase the number of items -->
            <form action="cart.jsp?editMode=true" method="post">
                <input type="hidden" name="action" value="increase">
                <input type="hidden" name="productId" value="<%=id%>">
                <input type="submit" class="btn btn-primary" value="+">
            </form>
            <br>
            <! -- Form to reduce the number of items -->
            <form action="cart.jsp?editMode=true" method="post">
                <input type="hidden" name="action" value="decrease">
                <input type="hidden" name="productId" value="<%=id%>">
                <input type="submit" class="btn btn-primary" value="-">
            </form>
        </td>
    </tr>
    <% } 
    } catch (Exception e) {
        e.printStackTrace();
    }
    } %>
</tbody>
</table>

<! -- Show total price -->
<h4>Total Price $: <%=String.format("%.2f", totalPrice)%></h4>
<br><br>
<div class="button-container d-flex justify-content-between">
    <! -- Cancel form for orders -->
    <form action="cart.jsp" method="post">
        <input type="hidden" name="action" value="cancel">
        <input type="submit" class="Homebtn" value="Cancel Order">
    </form>
    <! -- button for placing an order -->
    <% if (cartItems != null && !cartItems.isEmpty()) { %>
    <form action="cart.jsp" method="post">
        <input type="hidden" name="action" value="placeOrder">
        <input type="submit" class="Homebtn" value="Place Order">
    </form>
<% } else { %>
    <div class="alert alert-warning text-center centered-alert" role="alert" style="font-size: larger;">
       Your current shopping cart is empty. Please add items to place your order.
    </div>
<% } %>
</div>
<% session.setAttribute("cartItems", cartItems); %>

<div class="footer-message">End of Page</div>
</div>
<footer>
    <p> &copy; 2023 IoTBay All Rights Reserved </p>
</footer>
</body>
</html>