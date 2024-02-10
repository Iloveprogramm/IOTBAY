<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    DecimalFormat df = new DecimalFormat("0.00");
    String paymentTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>IoTBay payment page</title>
        <link rel="stylesheet" href="landing.css" type="text/css"/>
        <link rel="stylesheet" href="payment.css" type="text/css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    
    <body>
        <header>
            <h1>IoTBay</h1>
        </header>
        <div class="button-container d-flex justify-content-between">
            <a class="Homebtn" href="cart.jsp">Back to Cart page</a>
            <div>
                <a class="Homebtn" href="payment_detail.jsp">View saved payment details</a>
            </div>
        </div>
        <div class="container_payment">
            <h2>Payment Detail</h2>
            <form action="PaymentS.jsp" method="post" onsubmit="return validatePaymentForm();">
                <%
                    Object temp = session.getAttribute("totalPrice");
                    Double totalPrice;
                    if(temp != null && temp instanceof Double){
                        totalPrice = (Double) temp;
                    } else {
                        totalPrice = 0.00; 
                    }
                %>
                <h3>Total Amount: <%=df.format(totalPrice)%></h3>
                <div class="line">
                    <label for="PaymentMethod">Payment Method:</label>
                    <select id="PaymentMethod" name="PaymentMethod">
                        <option value="creditCard">Credit Card</option>
                        <option value="debitCard">Debit Card</option>
                    </select>
                </div>
                <br>
                <div class="container_input">
                    <label for="CardNumber">Card Number:</label>
                    <input class="full-width" type="text" id="CardNumber" name="CardNumber" placeholder ="Card number">
                    <div>
                        <label for="ExpDate">Expiry Date:</label>
                        <input type="text" id="ExpDate" name="ExpDate" placeholder ="MM/YY">
                    </div>
                    <div>
                        <label for="cvc">CVC:</label>
                        <input type="text" id="cvc" name="cvc" placeholder ="123">
                    </div>
                </div>
                <br>
                <div class="container_input" style="transform: scale(0.65); white-space: nowrap; overflow: auto; font-family: Comic Sans MS;">
                    <input type="checkbox" id="savePayment" name="savePayment">
                    <label for="savePayment">Save this payment detail</label>
                </div>
                <br>
                <input type="submit" value="Pay Now">
            </form>
        </div>
    <footer>
        <p>© 2023 IoTBay All Rights Reserved</p>
     </footer>
    <script>
        function validatePaymentForm() {
        const cardNumber = document.getElementById('CardNumber').value;
        const expDate = document.getElementById('ExpDate').value;
        const cvc = document.getElementById('cvc').value;
                    if (cardNumber === "" || expDate === "" || cvc === "") {
                alert("The payment detail cannot be empty.");
                return false;
            }

            return true;
        }
    </script>
    </body>
</html>

