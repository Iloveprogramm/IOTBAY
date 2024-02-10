/*
<%-- 
    Document   : Supplier
    Author     : Chenjun Zheng
--%>
 */
package Models;
public class Supplier 
    {
    private int id;
    private String contactName;
    private String company;
    private String email;
    private String address;
    private String status;

    public Supplier(int id, String contactName, String company, String email, String address, String status) 
    {
        this.id = id;
        this.contactName = contactName;
        this.company = company;
        this.email = email;
        this.address = address;
        this.status = status;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}