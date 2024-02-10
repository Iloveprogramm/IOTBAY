<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="landing.css" type="text/css"/>
        <link rel="stylesheet" href="payment.css" type="text/css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <title>Payment Detail</title>
    </head>
    <body>
        <header>
            <h1>IoTBay</h1>
        </header>
        <div class="button-container d-flex justify-content-between">
            <a class="Homebtn" href="cart.jsp">Back to Cart page</a>
        </div>
        <div class="container_details">
            <h2>Saved Payment Details</h2>
            <table>
                <tr>
                    <th>Card Number</th>
                    <th>Expiry Date</th>
                    <th>CVC</th>
                    <th>Action</th>
                </tr>
                <% 
                    try {
                        Class.forName("org.apache.derby.jdbc.ClientDriver");
                        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/41025iotBay;user=ChenjunZheng;password=14208603");
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM card_details");
                        while(rs.next()) {
                            String cardNumber = rs.getString("card_number");
                            String expiryDate = rs.getString("expiry_date");
                            String cvc = rs.getString("cvc");
                %>

            <tr>
                <form class="saveForm" action="update_payment.jsp" method="post">
                    <input type="hidden" name="cardNumber" value="<%= cardNumber %>">
                    <td><input type="text" name="updatedCardNumber" value="<%= cardNumber %>"></td>
                    <td><input type="text" name="updatedExpiryDate" value="<%= expiryDate %>"></td>
                    <td><input type="text" name="updatedCvc" value="<%= cvc %>"></td>
                    <td>
                        <button type="submit">Save</button>
                        <button type="button" class="deleteBtn" data-cardnumber="<%= cardNumber %>">Delete</button>
                    </td>
                </form>
            </tr>


                <% 
                        }
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch(Exception e) {
                        e.printStackTrace();
                    }
                %>
            </table>
        </div>
        <footer>
            <p>&copy; 2023 IoTBay All Rights Reserved</p>
        </footer>
        <script type="text/javascript">
            $(document).ready(function() {
                $(".saveForm").on('submit', function(e) {
                    e.preventDefault();
                    $.ajax({
                        url: 'update_payment.jsp',
                        type: 'post',
                        data: $(this).serialize(),
                        success: function(result) {
                            swal({title: "Save successful", button: true});
                        },
                        error: function(error) {
                            swal({title: "Save failed", button: true});
                        }
                    });
                });

                $(".deleteBtn").click(function(e) {
                    e.preventDefault();
                    var row = $(this).closest('tr');
                    var cardNumber = $(this).data("cardnumber");
                    $.ajax({
                        url: 'delete_payment.jsp',
                        type: 'get',
                        data: {cardNumber: cardNumber},
                        success: function(result) {
                            if (result.trim() === "success") {
                                swal({title: "Delete successful", button: true}).then(function() {
                                    row.remove(); 
                                });
                            } else {
                                swal({title: "Delete failed: " + result, button: true});
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            swal({title: "Delete failed", text: textStatus + ": " + errorThrown, button: true});
                        }
                    });
                });
            });       
        </script>
    </body>
</html>
