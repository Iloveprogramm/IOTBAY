/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

/**
 *
 * @author griffinframe-szafjanski
 */
public class AccountController {

    private String id;
    private String email;
    private String password;
    private String Fname;
    private String Lname;
    private String accType;
    private String status;
    private String typepos;
    private String phonenum;
    private String address;
    
      public static void main(String[] args){
      
    }
    
    
    // verifies the account details, if there is a match, populate with matching information
    public boolean verifyAccount() {
    return DatabaseController.verifyAccount(this.email, this.password);
    }

    public void refreshAccount(){
        String[] results;
            if (DatabaseController.verifyAccount(this.email, this.password)){
                results = DatabaseController.getAccountInfo(this.email, this.password);
                this.id = results[0];
                this.Fname = results[3];
                this.Lname = results[4];
                this.accType = results[5];
            }
    }
    
    // sets all account information
    public boolean login(){
        String[] results;
        if (DatabaseController.verifyAccount(this.email, this.password)){
            results = DatabaseController.getAccountInfo(this.email, this.password);
            this.id = results[0];
            this.Fname = results[3];
            this.Lname = results[4];
            this.accType = results[5];
            DatabaseController.loginLog(Integer.parseInt(this.id));
            return true;             
        }
    return false;
    }
    
    // emptyies all account information
    public void logout(){
        DatabaseController.logoutLog(Integer.parseInt(this.id));
        this.id = null;
        this.email = null;
        this.password = null;
        this.Fname = null;
        this.Lname = null;
        this.accType = null;
    }
    
    public void delete(){
        DatabaseController.deleteAccount(email);
        this.id = null;
        this.email = null;
        this.password = null;
        this.Fname = null;
        this.Lname = null;
        this.accType = null;
    }
    public void setId(String id) {
        this.id = id;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    public void setFname(String Fname) {
        this.Fname = Fname;
    }

    public void setLname(String Lname) {
        this.Lname = Lname;
    }

    public void setAccType(String accType) {
        this.accType = accType;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }
    public String getId() {
        return id;
    }
    public String getFname() {
        return Fname;
    }
    public String getLname() {
        return Lname;
    }

    public String getAccType() {
        return accType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTypepos() {
        return typepos;
    }

    public void setTypepos(String typepos) {
        this.typepos = typepos;
    }

    public String getPhonenum() {
        return phonenum;
    }

    public void setPhonenum(String phonenum) {
        this.phonenum = phonenum;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    
    
}
