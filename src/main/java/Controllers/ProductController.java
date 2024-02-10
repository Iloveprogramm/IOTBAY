/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import static Controllers.DatabaseController.databaseURL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Griffin
 */
public class ProductController {
    private int id;
    private String name;
    private String description;
    private String image_dir;
    private int stock;
    private double price;
    private String type;

    public void setId(int id) {
        this.id = id;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public void setImageDir(String image_dir) {
        this.image_dir = image_dir;
    }
    
    public void setStock(int stock) {
        this.stock = stock;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return this.name;
    }

    public String getDescription() {
        return this.description;
    }

    public String getImage_dir() {
        return this.image_dir;
    }

    public String getStock() {
        return Integer.toString(this.stock);
    }

    public int getId() {
        return this.id;
    }
    
    public String getPrice() {
        return Double.toString(this.price);
    }
    
    public String getType() {
        return this.type;
    }
    
     // verifies the product id, if there is a match, populate with matching information
    public boolean getInfo() {
        String[] productInfo;
        if (DatabaseController.verifyProduct(id)){
            productInfo = DatabaseController.getProductInfo(id);
            this.name = productInfo[1];
            this.description = productInfo[2];
            this.stock = Integer.parseInt(productInfo[3]);
            this.image_dir = productInfo[4];
            this.price = Double.parseDouble(productInfo[5]);
            this.type = productInfo[6];
            return true;
        }
        return false;
    }
    public static boolean editProduct(String id, String name, String description, String price, String stock, String image_dir, String type){
        boolean result = false;
        //int id = Integer.parseInt(idNum);
        //double newPrice = Double.parseDouble(price);
        //int newStock = Integer.parseInt(stock);

        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");

            String sql = "UPDATE products SET name ='"+name+"', description='"+description+"', price="+price+", stock="+stock+" , image_dir='"+ image_dir + "' , type='" + type +"' WHERE id ="+ id;
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate(sql);
                         
            if (rows > 0)
            {
                result = true;
                
            }
            
            connection.close();
            
        } catch (SQLException ex) {
            result = false;
        }
        System.out.println(result);
        return result;   
    }
    
    public static boolean addProduct(String name, String description, String price, String stock, String image_dir, String type){
        boolean result = false;
        //int id = Integer.parseInt(idNum);
        //double newPrice = Double.parseDouble(price);
        //int newStock = Integer.parseInt(stock);

        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");

            String sql = "INSERT INTO products (name, description, price, stock, image_dir, type) VALUES " + "('" + name + "', '" + description + "', "+ price + ", " + stock + ", '" + image_dir + "', '"+ type+"')";
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate(sql);
                         
            if (rows > 0)
            {
                result = true;
                
            }
            
            connection.close();
            
        } catch (SQLException ex) {
            result = false;
        }
        System.out.println(result);
        return result;   
    }
    
    public static boolean removeProduct(String id){
        boolean result = false;
        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");

            String sql = "DELETE FROM Products WHERE id = " + id;
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate(sql);
                         
            if (rows > 0)
            {
                result = true;
                
            }
            
            connection.close();
            
        } catch (SQLException ex) {
            result = false;
        }
        System.out.println(result);
        return result;
    }
    
}
