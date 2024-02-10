<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Controllers.PaymentController" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="Controllers.PaymentController" %>
<%@page import="Controllers.ProductController" %>
<%@page import="Controllers.Payment" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="landing.css" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="payments.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Payment Success</title>
</head>
<body>
<header>
    <h1>IoTBay</h1>
</header>
<%
    PaymentController controller = new PaymentController();
    controller.handlePaymentRequest(request);
%>


<div class="button-container d-flex justify-content-between">
    <a class="Homebtn" href="main.jsp">Back to Home page</a>
    <div>
        <a class="Homebtn" href="payment_history.jsp">View Payment History</a>
    </div>
</div>
<div class="payment-success">
    <h2>Payment Success</h2>
    <br>
    <h3>Your payment has been successfully processed.</h3>
    <br>

    <%
        List<Map<String, Object>> cartItems = (List<Map<String, Object>>) session.getAttribute("cartItems");
        if (cartItems != null) {
            ProductController productController = new ProductController();
    %>
    <table>
        <tr>
            <%
                for (Map<String, Object> item : cartItems) {
                    Integer id = (Integer) item.get("id");
                    String name = (String) item.get("name");
                    Integer quantity = (Integer) item.get("quantity");
                    Double price = (Double) item.get("price");

                    productController.setId(id);

                    try {
                        if (productController.getInfo()) {
            %>
            <td><img src="<%=productController.getImage_dir()%>" alt="<%=name%>" width="100" height="100"
                     class="product-image"/></td>
            <td>
                <div class="product-details">
                    <div class="product-name">Product Name: <%=name%></div>
                    <div class="product-quantity">Quantity: <%=quantity%></div>
                    <div class="product-price">Price: $<%=price%></div>
                </div>
            </td>
            <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
        </tr>
    </table>
    <%
        }
    %>
</div>


<%
    String paymentMethod = request.getParameter("PaymentMethod");
    String cardNumber = request.getParameter("CardNumber");
    String expDate = request.getParameter("ExpDate");
    String cvc = request.getParameter("cvc");
    Double totalPrice = (Double) session.getAttribute("totalPrice");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    Integer order_ID = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/41025iotBay;user=ChenjunZheng;password=14208603");

        // Retrieve the order_ID for user_ID = 1
        String sql = "SELECT MAX(order_ID) AS maxOrderID FROM orders WHERE user_ID = 1";
        pstmt = conn.prepareStatement(sql);

        rs = pstmt.executeQuery();
        if (rs.next()) {
            order_ID = rs.getInt("maxOrderID");
            if (rs.wasNull()) {
                throw new Exception("No order found");
            }
        } else {
            throw new Exception("No result returned from order_ID query");
        }


        if (order_ID != null && order_ID != 0) {
            sql = "INSERT INTO paymentlist (order_ID, ORDER_DATE, PAYMENT_TIME, TOTAL_PRICE) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, order_ID);
            pstmt.setDate(2, new java.sql.Date(System.currentTimeMillis()));
            pstmt.setTime(3, new java.sql.Time(System.currentTimeMillis()));
            pstmt.setDouble(4, totalPrice);
            pstmt.executeUpdate();
        } else {
            out.println("Invalid order_ID: " + order_ID);
        }
    } catch (Exception e) {
        out.println(e);
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                out.println(e);
            }
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                out.println(e);
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                out.println(e);
            }
        }

    }
%>

<footer>
    <p>&copy; 2023 IoTBay All Rights Reserved</p>
</footer>
</body>
</html>

