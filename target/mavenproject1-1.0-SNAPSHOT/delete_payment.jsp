<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%
    String cardNumber = request.getParameter("cardNumber");
    
    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/41025iotBay;user=ChenjunZheng;password=14208603");
        String query = "SELECT id FROM card_details WHERE card_number = ?";
        PreparedStatement stmt = con.prepareStatement(query);
        stmt.setString(1, cardNumber);
        ResultSet rs = stmt.executeQuery();
        if(rs.next()) {
            int id = rs.getInt("id");
            rs.close();
            stmt.close();
            String deleteQuery = "DELETE FROM card_details WHERE id = ?";
            stmt = con.prepareStatement(deleteQuery);
            stmt.setInt(1, id);
            System.out.println("Delete query: " + stmt); 
            int rowsAffected = stmt.executeUpdate();
            stmt.close();
            con.close();
            if(rowsAffected > 0) {
                out.print("success");
            } else {
                out.print("error: no record found");
            }
        } else {
            out.print("error: no card number found");
        }
    } catch(Exception e) {
        out.print("error: " + e.getMessage());
        e.printStackTrace(); 
    }
%>




