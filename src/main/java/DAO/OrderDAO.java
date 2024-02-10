/*
<%-- 
    Document   : OrderDAO
    Author     : Chenjun Zheng
--%>
 */
package DAO;

import Models.Order;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class OrderDAO {
   public ArrayList<Order> searchOrderHistory(String orderId, String startDate) 
    {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        ArrayList<Order> resultOrders = new ArrayList<>();

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection = DriverManager.getConnection("jdbc:derby://localhost:1527/41025iotBay;user=ChenjunZheng;password=14208603");

            String query = "SELECT * FROM orders WHERE 1=1";
            if (orderId != null && !orderId.isEmpty()) 
            {
                query += " AND order_id = ?";
            }
            if (startDate != null && !startDate.isEmpty()) 
            {
                query += " AND order_date = ?";
            }
            preparedStatement = connection.prepareStatement(query);
            int paramIndex = 1;
            if (orderId != null && !orderId.isEmpty()) 
            {
                preparedStatement.setString(paramIndex++, orderId);
            }
            if (startDate != null && !startDate.isEmpty()) 
            {
                java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
                java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                preparedStatement.setDate(paramIndex++, sqlDate);
            }

            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) 
            {
                Order order = new Order(
                    resultSet.getInt("order_id"), 
                    resultSet.getInt("user_id"), 
                    resultSet.getDate("order_date"), 
                    resultSet.getDouble("total_price")
                );
                resultOrders.add(order);
            }
        } 
        catch (Exception e) 
        {
            e.printStackTrace();
        } 
        finally 
        {
            if (resultSet != null) 
            {
                try 
                {
                    resultSet.close();
                } 
                catch (Exception e) 
                {
                    e.printStackTrace();
                }
            }
            if (preparedStatement != null) {
                try 
                {
                    preparedStatement.close();
                } 
                catch (Exception e) 
                {
                    e.printStackTrace();
                }
            }
            if (connection != null) 
            {
                try 
                {
                    connection.close();
                } 
                catch (Exception e) 
                {
                    e.printStackTrace();
                }
            }
        }
        return resultOrders;
    }
}