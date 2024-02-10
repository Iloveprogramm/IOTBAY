/*
<%-- 
    Document   : CartDao
    Author     : Chenjun Zheng
--%>
 */
package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CartDAO {
    static String databaseURL = "jdbc:derby://localhost:1527/41025iotBay;user=ChenjunZheng;password=14208603";

     public void addProduct(String id, String productName, double productPrice) 
   {
       int Id = Integer.parseInt(id);

        try (Connection connection = DriverManager.getConnection(databaseURL)) 
        {
             String sql = "UPDATE CART SET PRODUCT_QUANTITY = PRODUCT_QUANTITY + 1 WHERE PRODUCT_ID = ?";
             PreparedStatement statement = connection.prepareStatement(sql);
             statement.setInt(1, Id);
             int productUpdated = statement.executeUpdate();

             if (productUpdated == 0) 
             {
                sql = "INSERT INTO CART (PRODUCT_ID, PRODUCT_NAME, PRODUCT_QUANTITY, PRODUCT_PRICE) VALUES (?, ?, ?, ?)";
                statement = connection.prepareStatement(sql);
                statement.setInt(1, Id);
                statement.setString(2, productName);
                statement.setInt(3, 1);
                statement.setDouble(4, productPrice);
                statement.executeUpdate();
              }
        } catch (SQLException e) 
        {
             e.printStackTrace();
        }
    }

     public List<Map<String, Object>> displayShoppingCartProducts() 
   {
    List<Map<String, Object>> shoppingCartPruduct = new ArrayList<>();

    try (Connection connection = DriverManager.getConnection(databaseURL)) {
        String sql = "SELECT PRODUCT_ID, PRODUCT_NAME, PRODUCT_QUANTITY, PRODUCT_PRICE FROM CART";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("id", resultSet.getInt("PRODUCT_ID"));
            item.put("name", resultSet.getString("PRODUCT_NAME"));
            item.put("quantity", resultSet.getInt("PRODUCT_QUANTITY"));
            item.put("price", resultSet.getDouble("PRODUCT_PRICE"));
            shoppingCartPruduct.add(item);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return shoppingCartPruduct;
}
   
  public int showShoppingCartSize()
  {
    int cartSize = 0;
    try (Connection connection = DriverManager.getConnection(databaseURL)) 
    {
        String sql = "SELECT SUM(PRODUCT_QUANTITY) as TOTAL_QUANTITY FROM CART";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) 
        {
            cartSize = resultSet.getInt("TOTAL_QUANTITY");
        }
    } catch (SQLException e) 
    {
        e.printStackTrace();
    }
    return cartSize;
}
  public void increaseSingleProduct(int productId) {
    try (Connection connection = DriverManager.getConnection(databaseURL)) 
    {
        String sql = "UPDATE CART SET PRODUCT_QUANTITY = PRODUCT_QUANTITY + 1 WHERE PRODUCT_ID = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, productId);
        statement.executeUpdate();
    } catch (SQLException e) 
    {
        e.printStackTrace();
    }
}

public void decreaseSingleProduct(int productId) 
{
    try (Connection connection = DriverManager.getConnection(databaseURL)) {
        String sql = "UPDATE CART SET PRODUCT_QUANTITY = PRODUCT_QUANTITY - 1 WHERE PRODUCT_ID = ? AND PRODUCT_QUANTITY > 0";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, productId);
        statement.executeUpdate();

        sql = "DELETE FROM CART WHERE PRODUCT_ID = ? AND PRODUCT_QUANTITY = 0";
        statement = connection.prepareStatement(sql);
        statement.setInt(1, productId);
        statement.executeUpdate();
    } catch (SQLException e)
    {
        e.printStackTrace();
    }
}

 public void cancelOrder() 
 {
        try (Connection connection = DriverManager.getConnection(databaseURL)) 
        {
            String sql = "DELETE FROM CART";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.executeUpdate();
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
        }
    }
 
 public void placeOrder(int userId) 
 {
    List<Map<String, Object>> cartItems = displayShoppingCartProducts();
    double sumUpPrice = 0;
    for (Map<String, Object> item : cartItems) 
    {
        Double productPrice = (Double) item.get("price");
        Integer productQuantity = (Integer) item.get("quantity");
        sumUpPrice += productPrice * productQuantity;
    }

    try (Connection connection = DriverManager.getConnection(databaseURL)) 
    {
        String query = "INSERT INTO ORDERS (USER_ID, ORDER_DATE, TOTAL_PRICE) VALUES (?, ?, ?)";

        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, userId);
        preparedStatement.setDate(2, new java.sql.Date(new java.util.Date().getTime()));
        preparedStatement.setDouble(3, sumUpPrice);

        int affectedRows = preparedStatement.executeUpdate();
        if (affectedRows > 0) 
        {
            cancelOrder();
        }
    } 
    catch (SQLException e) 
    {
        e.printStackTrace();
    }
 }
}
