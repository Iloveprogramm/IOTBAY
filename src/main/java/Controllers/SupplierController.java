/*
<%-- 
    Document   : SupplierController
    Author     : Chenjun Zheng
--%>
 */
package Controllers;

import Models.Supplier;
import DAO.SupplierDAO;
import java.sql.SQLException;
import java.util.List;

public class SupplierController {
    private SupplierDAO supplierDAO;

    public SupplierController() {
        this.supplierDAO = new SupplierDAO();
    }

    public void deleteSupplier(int id) throws SQLException {
        supplierDAO.deleteSupplier(id);
    }

    public void addSupplier(String contactName, String company, String email, String address, String status) throws SQLException {
        supplierDAO.addSupplier(contactName, company, email, address, status);
    }

    public List<Supplier> displayAllSuppliers() throws SQLException {
        return supplierDAO.displayAllSuppliers();
    }

    public Supplier getSupplierById(int id) throws SQLException {
        return supplierDAO.getSupplierById(id);
    }

    public void updateSupplier(int id, String contactName, String company, String email, String address, String status) throws SQLException {
        supplierDAO.updateSupplier(id, contactName, company, email, address, status);
    }

    public List<Supplier> searchSuppliers(String contactName, String company) throws SQLException {
        return supplierDAO.searchSuppliers(contactName, company);
    }
}
