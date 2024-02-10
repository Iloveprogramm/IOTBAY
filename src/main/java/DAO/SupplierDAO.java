/*
<%-- 
    Document   : SupplierDAO
    Author     : Chenjun Zheng
--%>
 */
package DAO;

import Models.Supplier;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAO {
    static String databaseURL = "jdbc:derby://localhost:1527/41025iotBay;user=ChenjunZheng;password=14208603";

    public SupplierDAO() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    public void deleteSupplier(int id) throws SQLException {
        String sql = "DELETE FROM suppliers WHERE id = ?";

        try (Connection connection = DriverManager.getConnection(databaseURL)) 
        {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }

    public void addSupplier(String contactName, String company, String email, String address, String status) throws SQLException {
        String sql = "INSERT INTO suppliers (contact_name, company, email, address, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DriverManager.getConnection(databaseURL)) {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, contactName);
            statement.setString(2, company);
            statement.setString(3, email);
            statement.setString(4, address);
            statement.setString(5, status);
            statement.executeUpdate();
        }
    }

   public List<Supplier> displayAllSuppliers() throws SQLException {
    List<Supplier> suppliers = new ArrayList<>();
    String sql = "SELECT * FROM suppliers";
    try (Connection connection = DriverManager.getConnection(databaseURL)) {
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String contactName = resultSet.getString("contact_name");
            String company = resultSet.getString("company");
            String email = resultSet.getString("email");
            String address = resultSet.getString("address");
            String status = resultSet.getString("status");
            Supplier supplier = new Supplier(id, contactName, company, email, address, status);
            suppliers.add(supplier);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return suppliers;
}

    public Supplier getSupplierById(int id) throws SQLException 
    {
        Supplier supplier = null;
        String sql = "SELECT * FROM suppliers WHERE id = ?";

        try (Connection connection = DriverManager.getConnection(databaseURL)) {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String contactName = resultSet.getString("contact_name");
                String company = resultSet.getString("company");
                String email = resultSet.getString("email");
                String address = resultSet.getString("address");
                String status = resultSet.getString("status");

                supplier = new Supplier(id, contactName, company, email, address, status);
            }
        }

        return supplier;
    }

    public void updateSupplier(int id, String contactName, String company, String email, String address, String status) throws SQLException {
        String sql = "UPDATE suppliers SET contact_name = ?, company = ?, email = ?, address = ?, status = ? WHERE id = ?";

        try (Connection connection = DriverManager.getConnection(databaseURL)) {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, contactName);
            statement.setString(2, company);
            statement.setString(3, email);
            statement.setString(4, address);
            statement.setString(5, status);
            statement.setInt(6, id);
            statement.executeUpdate();
        }
    }

    public List<Supplier> searchSuppliers(String contactName, String company) throws SQLException 
    {
List<Supplier> searchResults = new ArrayList<>();
   for (Supplier supplier : displayAllSuppliers()) 
   {
        boolean contactNameMatches = contactName == null || contactName.isEmpty() || supplier.getContactName().toLowerCase().contains(contactName.toLowerCase());
        boolean companyMatches = company == null || company.isEmpty() || supplier.getCompany().toLowerCase().contains(company.toLowerCase());

        if (contactNameMatches && companyMatches) 
        {
            searchResults.add(supplier);
        }
    }

    return searchResults;
}
}
