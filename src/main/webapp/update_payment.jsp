<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%
    String cardNumber = request.getParameter("cardNumber");
    String updatedCardNumber = request.getParameter("updatedCardNumber");
    String updatedExpiryDate = request.getParameter("updatedExpiryDate");
    String updatedCvc = request.getParameter("updatedCvc");
    
    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/41025iotBay;user=ChenjunZheng;password=14208603");
        String query = "UPDATE card_details SET card_number = ?, expiry_date = ?, cvc = ? WHERE card_number = ?";
        PreparedStatement stmt = con.prepareStatement(query);
        stmt.setString(1, updatedCardNumber);
        stmt.setString(2, updatedExpiryDate);
        stmt.setString(3, updatedCvc);
        stmt.setString(4, cardNumber);
        stmt.executeUpdate();
        stmt.close();
        con.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
%>

