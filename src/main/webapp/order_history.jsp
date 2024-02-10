<%-- 
    Document   : order_history.jsp
    Author     : Chenjun Zheng
--%>
 <%@page import="Models.Order"%>
<%@page import="Controllers.OrderController"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
    <link rel="stylesheet" href="landing.css" type="text/css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<style>
 .footer-message
 {
  font-size: 220px;
  color: white;
  text-align: center;
}
</style>
<body>

    <header>
        <h1>IoTBay</h1>
    </header>
    
    <a class="Homebtn" href="cart.jsp">Back to Cart page</a>
    <h1>Order History</h1>

    <!-- Search form -->
    <form id="searchOrderForm" method="GET" action="" name="searchOrderForm" class="mt-3 mb-3">
        <div class="form-row">
            <div class="form-group col-md-4">
                <label for="orderId" class="sr-only">Order ID</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroupPrepend">Order ID</span>
                    </div>
                    <input type="text" class="form-control" name="orderId" id="orderId" placeholder="Order ID" aria-describedby="inputGroupPrepend">
                </div>
            </div>
            <div class="form-group col-md-4">
                <label for="startDate" class="sr-only">Start Date</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text" id="inputGroupPrepend2">Start Date</span>
                    </div>
                    <input type="date" class="form-control" name="startDate" id="startDate" aria-describedby="inputGroupPrepend2">
                </div>
            </div>
            <div class="form-group col-md-4">
                <button class="btn btn-outline-secondary" type="submit">Search</button>
            </div>
        </div>
    </form>

    <%
    String orderId = request.getParameter("orderId");
    String startDate = request.getParameter("startDate");

    OrderController orderController = new OrderController();
    ArrayList<Order> orders = orderController.searchOrderHistory(orderId, startDate);

    if (orders.size() > 0) {
    %>

    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Order Date</th>
                <th>Total Price</th>
            </tr>
        </thead>
        <tbody>
            <% for(Order order : orders) { %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getOrderDate() %></td>
                    <td><%= String.format("%.2f", order.getTotalPrice()) %></td>
                </tr>
            <% } %>
        </tbody>
     </table>

    <% } else { %>
        <p>No orders found. Please try again.</p>
    <% } %>

<div class="footer-message">End of Page</div>
<footer>
    <p>&copy; 2023 IoTBay All Rights Reserved</p>
</footer>
</body>
</html>
