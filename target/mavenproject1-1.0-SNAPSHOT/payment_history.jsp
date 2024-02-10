<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Controllers.PaymentController"%>
<%@page import="Controllers.Payment"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="landing.css" type="text/css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title>Payment History</title>
</head>
<body>
<header>
    <h1>IoTBay</h1>
</header>
<a class="Homebtn" href="PaymentS.jsp">Back to Summary page</a>
<h2>Payment History</h2>
<form id="searchPaymentForm" method="GET" action="payment_history.jsp" name="searchPaymentForm" class="mt-3 mb-3">
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
            <label for="paymentId" class="sr-only">Payment ID</label>
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="inputGroupPrepend2">Payment ID</span>
                </div>
                <input type="text" class="form-control" name="paymentId" id="paymentId" placeholder="Payment ID" aria-describedby="inputGroupPrepend2">
            </div>
        </div>
        <div class="form-group col-md-4">
            <label for="startDate" class="sr-only">Start Date</label>
            <div class="input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="inputGroupPrepend3">Start Date</span>
                </div>
                <input type="date" class="form-control" name="startDate" id="startDate" aria-describedby="inputGroupPrepend3">
            </div>
        </div>
        <div class="form-group col-md-4">
            <button class="btn btn-outline-secondary" type="submit">Search</button>
            <button class="btn btn-outline-secondary" type="button" onclick="showAll()">Show All</button>
        </div>
    </div>
</form>

<%
    String orderId = request.getParameter("orderId");
    String paymentId = request.getParameter("paymentId");
    String startDate = request.getParameter("startDate");

    PaymentController paymentController = new PaymentController();
    ArrayList<Payment> payments = paymentController.searchPaymentHistory(orderId, paymentId, startDate, orderId == null && paymentId == null && startDate == null); 
    out.println("Payment list: " + payments.size());
    if (payments.size() > 0) {
%>

    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Payment ID</th>
                <th>Order Date</th>
                <th>Payment Time</th>
                <th>Total Price</th>
            </tr>
        </thead>
        <tbody>
            <% for(Payment payment : payments) { %>
                <tr>
                    <td><%= payment.getOrderId() %></td>
                    <td><%= payment.getPaymentId() %></td>
                    <td><%= payment.getOrderDate() %></td>
                    <td><%= payment.getPaymentTime() %></td>
                    <td><%= String.format("%.2f", payment.getTotalPrice()) %></td>
                </tr>
            <% } %>
        </tbody>
    </table>
<% } else { %>
    <p>No payments found. Please try again.</p>
<% } %>

<script>
    function showAll() {
        document.getElementById("orderId").value = ""; 
        document.getElementById("paymentId").value = "";
        document.getElementById("startDate").value = "";
        document.getElementById("searchPaymentForm").submit(); 
    }
</script>

<footer>
    <p>&copy; 2023 IoTBay All Rights Reserved</p>
</footer>
</body>
</html>



