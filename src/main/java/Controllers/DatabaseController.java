/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
       
/**
 *
 * @author griffinframe-szafjanski
 */
public class DatabaseController {
    static String databaseURL = "jdbc:derby://localhost:1527/41025iotBay;user=ChenjunZheng;password=14208603";
    static String shutdownURL = "jdbc:derby:;shutdown=true"; 
    
    public static void main(String[] args){
        editAccount("122", "email","password1","tim","minchin");
    }
    
    // Account Functions //////////////////////////////////////////////////////////////////////////////////////////////////
    
   // takes 4 inputs then adds a Customer account to the database with that information
    public static boolean createAccount(String email, String password, String Fname, String Lname, String accType){
        boolean result = false;
        if (email.equals("")){
            return false;
        }
        
        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");
            String sql = "INSERT INTO accounts (email, password, FirstName, LastName, acc_type) VALUES " 
                    + "('" + email + "', '" + password + "', '"+ Fname + "', '" + Lname + "', '" + accType + "')";
            
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
    
    public static boolean editAccount(String acc_id, String newEmail, String newPass, String newFName, String newLName){
        boolean result = false;

        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");

            String sql = "UPDATE accounts SET email ='"+newEmail+"', password='"+newPass+"', firstname='"+newFName+"', lastname='"+newLName+"' WHERE id ="+ acc_id;
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
    
    // takes 1 input then deletes the account with that email address
    public static String deleteAccount(String email){
        String result = "";
        
        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");

            String sql = "DELETE FROM accounts " 
                    + "WHERE email = '" + email + "'";
            
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate(sql);
                         
            if (rows > 0)
            {
                result = ("Account Deleted");
            }
            
            connection.close();
            
        } catch (SQLException ex) {
            result = "Failed to create account.\n\nReason:" + ex.getMessage();
        }
        System.out.println(result);
        return result;
    }
    
    // takes 2 inputs and return true if there is a matching account
    public static boolean verifyAccount(String email, String pass){
        boolean result = false;
        if (email == null){
            return false;
        }
        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");
            
            String sql = "SELECT password "
                    + "FROM Accounts "
                    + "WHERE email = '" + email +"'";
            
            Statement statement = connection.createStatement();
            ResultSet results = statement.executeQuery(sql);
            if (results.next()){
                String password = results.getString("password");
                System.out.println(password);
                
                if(password.equals(pass)){
                    System.out.println("Account found");
                    System.out.println("Password matched");
                    result = true;
                }else{
                    System.out.println("Account found");
                    System.out.println("Password mismatched");
                }
            }else{
                System.out.println("Invalid email");
            }
            
            connection.close();

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        
        return result;
    }
    
    // takes 2 inputs and returns a String array containing all information for that account
    public static String[] getAccountInfo(String email, String password){
        String[] output = {"","","","","",""};
        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");
            
            String sql = "SELECT * FROM Accounts WHERE email = '" + email + "' AND password = '" + password + "'";
            
            Statement statement = connection.createStatement();
            ResultSet results = statement.executeQuery(sql);
            results.next();
            
            output[0] = results.getString("ID");
            output[1] = results.getString("email");
            output[2] = results.getString("password");
            output[3] = results.getString("firstname");
            output[4] = results.getString("lastname");
            output[5] = results.getString("acc_type");
               
            connection.close();
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            return output;
        }
        return output;
    }
    
    // returns a single string containing all accounts in database (WIP: will return a String array of accounts)
    public static String viewAllAccounts(){
        String output = "";
        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");
            
            String sql = "SELECT * "
                    + "FROM Accounts ";
            
            Statement statement = connection.createStatement();
            ResultSet results = statement.executeQuery(sql);
            int x = 1;
            while (results.next()){
                
                output += "Account ID: " + results.getString("ID") + "<br>";
                output += "  Email: " + results.getString("email") + "<br>";
                output += "  Password: " + results.getString("password") + "<br>";
                output += "  First name: " + results.getString("FirstName") + "<br>";
                output += "  Last name: " + results.getString("LastName") + "<br><br>";

            } 
            
            connection.close();
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            return ex.getMessage();
        }
        
        return output;
    }
    public static boolean adminCreateAccount(String email, String password, String Fname, String Lname, String accType, String status, String typePos, String phoneNum, String address) {
    boolean result = false;
    
    if (email.equals("")) {
        return false;
    }
    
    try {
        Connection connection = DriverManager.getConnection(databaseURL);
        System.out.println("Connected to the database");
        
        String sql = "INSERT INTO accounts (email, password, FirstName, LastName, acc_type, status, typepos, phonenum, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, email);
        statement.setString(2, password);
        statement.setString(3, Fname);
        statement.setString(4, Lname);
        statement.setString(5, accType);
        statement.setString(6, status);
        statement.setString(7, typePos);
        statement.setString(8, phoneNum);
        statement.setString(9, address);
        
        int rows = statement.executeUpdate();
        
        if (rows > 0) {
            result = true;
        }
        
        connection.close();
    } catch (SQLException ex) {
        result = false;
        ex.printStackTrace();
    }
    
    System.out.println(result);
    return result;
}

    public static List<AccountController> adminGetAccounts() {
    List<AccountController> accounts = new ArrayList<>();
    try {
        Connection connection = DriverManager.getConnection(databaseURL);
        System.out.println("Connected to the database");

        String sql = "SELECT * FROM Accounts";

        Statement statement = connection.createStatement();
        ResultSet results = statement.executeQuery(sql);
        while (results.next()) {
            if (results.getString("ACC_TYPE").equals("admin")) {
                continue;
            }
            AccountController account = new AccountController();
            account.setId(results.getString("ID"));
            account.setEmail(results.getString("email"));
            account.setPassword(results.getString("password"));
            account.setFname(results.getString("FirstName"));
            account.setLname(results.getString("LastName"));
            account.setAccType(results.getString("ACC_TYPE"));
            account.setStatus(results.getString("status"));
            account.setTypepos(results.getString("typepos"));
            account.setPhonenum(results.getString("phonenum"));
            account.setAddress(results.getString("address"));

            accounts.add(account);
        }

        connection.close();
    } catch (SQLException ex) {
        ex.printStackTrace();
        return null;
    }

    return accounts;
}

    
    public static boolean adminEditAccount(String acc_id, String newEmail, String newPass, String newFName, String newLName, String newAccType, String newStatus, String newTypePos, String newPhoneNum, String newAddress){
        boolean result = false;

        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");

            String sql = "UPDATE accounts SET email ='"+newEmail+"', password='"+newPass+"', firstname='"+newFName+"', lastname='"+newLName+"', acc_type='"+newAccType+"' , status='"+newStatus+"', typepos='"+newTypePos+"', phonenum='"+newPhoneNum+"', address='"+newAddress+"' WHERE id ="+ acc_id;
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
    
    public static List<AccountController> adminGetCustomerAccounts() {
    List<AccountController> customerAccounts = new ArrayList<>();
    try {
        Connection connection = DriverManager.getConnection(databaseURL);
        System.out.println("Connected to the database");

        String sql = "SELECT * "
                + "FROM Accounts ";

        Statement statement = connection.createStatement();
        ResultSet results = statement.executeQuery(sql);
        while (results.next()) {
            if (results.getString("ACC_TYPE").equals("admin") || results.getString("ACC_TYPE").equals("Staff")) {
                continue;
            }
            AccountController account = new AccountController();
            account.setId(results.getString("ID"));
            account.setEmail(results.getString("email"));
            account.setPassword(results.getString("password"));
            account.setFname(results.getString("FirstName"));
            account.setLname(results.getString("LastName"));
            account.setAccType(results.getString("ACC_TYPE"));
            account.setStatus(results.getString("status"));
            account.setTypepos(results.getString("typepos"));
            account.setPhonenum(results.getString("phonenum"));
            account.setAddress(results.getString("address"));
            customerAccounts.add(account);
        }

        connection.close();
    } catch (SQLException ex) {
        ex.printStackTrace();
        return null;
    }

    return customerAccounts;
}

public static List<AccountController> adminGetStaffAccounts() {
    List<AccountController> staffAccounts = new ArrayList<>();
    try {
        Connection connection = DriverManager.getConnection(databaseURL);
        System.out.println("Connected to the database");

        String sql = "SELECT * "
                + "FROM Accounts ";

        Statement statement = connection.createStatement();
        ResultSet results = statement.executeQuery(sql);
        while (results.next()) {
            if (results.getString("ACC_TYPE").equals("admin") || results.getString("ACC_TYPE").equals("Customer")) {
                continue;
            }
            AccountController account = new AccountController();
            account.setId(results.getString("ID"));
            account.setEmail(results.getString("email"));
            account.setPassword(results.getString("password"));
            account.setFname(results.getString("FirstName"));
            account.setLname(results.getString("LastName"));
            account.setAccType(results.getString("ACC_TYPE"));
            account.setStatus(results.getString("status"));
            account.setTypepos(results.getString("typepos"));
            account.setPhonenum(results.getString("phonenum"));
            account.setAddress(results.getString("address"));
            staffAccounts.add(account);
        }

        connection.close();
    } catch (SQLException ex) {
        ex.printStackTrace();
        return null;
    }

    return staffAccounts;
}
    
    
    // Product Functions ////////////////////////////////////////////////////////////////////////////////////
    
   // takes 5 inputs and adds a product to the database (WIP: ID does not auto generate, so not usable atm)
    public static boolean createProduct(String name, String description, int stock, String image_directory, double price){
        boolean result = false;
        if (name.equals("")){
            return false;
        }
        
        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");
            String sql = "INSERT INTO Products (name, description, stock, image_dir, price) VALUES " 
                    + "('" + name + "', '" + description + "', '" + stock + "', '" + image_directory +  "', '"+ price +"')";
            Statement statement = connection.createStatement();
            int rows = statement.executeUpdate(sql);
                         
            if (rows > 0){
                result = true;   
            }
            
            connection.close();
            
        } catch (SQLException ex) {
            result = false;
        }
        System.out.println(result);
        return result;
    }
    
    // takes 1 input returns true if a product matches that id in the database
    public static boolean verifyProduct(int ID){
        boolean result = false;

        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            
            
            String sql = "SELECT ID "
                    + "FROM Products "
                    + "WHERE id = " + ID;
            
            Statement statement = connection.createStatement();
            ResultSet results = statement.executeQuery(sql);
            
            if (results.next()){
                    result = true;
            }
            
            connection.close();

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return result;
    }
    
    // takes 1 input returns an array of all information matching that id
    public static String[] getProductInfo(int ID){
        String[] output = {"","","","","","",""};
        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            
            
            String sql = "SELECT * FROM Products WHERE ID = " + ID;
            
            Statement statement = connection.createStatement();
            ResultSet results = statement.executeQuery(sql);
            results.next();
            
            output[0] = results.getString("ID");
            output[1] = results.getString("name");
            output[2] = results.getString("description");
            output[3] = results.getString("stock");
            output[4] = results.getString("image_dir");
            output[5] = results.getString("price");
            output[6] = results.getString("Type");
            connection.close();    

        } catch (SQLException ex) {
            ex.printStackTrace();    
            return output;
        }
        return output;
    }
    
    /// Logs Functions
    
    public static boolean loginLog(int acc_id){
        boolean result = false;

        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");
            
            int amount = 1;
            String sql = "SELECT * FROM acc_logs WHERE Acc_ID = " + acc_id;
            
            Statement statement = connection.createStatement();
            ResultSet results = statement.executeQuery(sql);
            while(results.next()){
             amount++;
            }
            System.out.println(amount);
            
            sql = "INSERT INTO ACC_LOGS (acc_id,log_id) VALUES " 
                    + "(" + acc_id + ","+ amount +")";
            
            statement = connection.createStatement();
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
    public static boolean logoutLog(int acc_id){
        boolean result = false;

        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");
            
            int amount = 0;
            String sql = "SELECT * FROM acc_logs WHERE Acc_ID = " + acc_id;
            
            Statement statement = connection.createStatement();
            ResultSet results = statement.executeQuery(sql);
            while(results.next()){
             amount++;
            }
            System.out.println(amount);     
            
            sql = "UPDATE Acc_Logs SET Logout_time = CURRENT_TIMESTAMP WHERE Log_id="+ amount + " and acc_id ="+ acc_id;
            statement = connection.createStatement();
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
    
    public static String[] getLog(int acc, int log){
        String[] output = {"","","",""};
        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");
            
            String sql = "SELECT * FROM acc_logs WHERE acc_id = " + acc + " AND log_id = " + log;
            
            Statement statement = connection.createStatement();
            ResultSet results = statement.executeQuery(sql);
            results.next();
            
            output[0] = results.getString("log_id");
            output[1] = results.getString("login_time");
            output[2] = results.getString("logout_time");
               
            connection.close();
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            return output;
        }
        return output;
    }
    
    public static int getLogSize(int acc){
        int output = 0;
        try {
            Connection connection = DriverManager.getConnection(databaseURL);
            System.out.println("Connected to database");
            
            String sql = "SELECT COUNT( * ) as number FROM acc_logs WHERE acc_id = "+ acc;

            Statement statement = connection.createStatement();
            ResultSet results = statement.executeQuery(sql);
            results.next();
            
            output = Integer.parseInt(results.getString("number"));

               
            connection.close();
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            return output;
        }
        return output;
    }
    
}