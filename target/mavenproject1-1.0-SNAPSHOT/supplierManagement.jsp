<%-- 
    Document   : supplierManagement.jsp
    Author     : Chenjun Zheng
--%>
<%@page import="Models.Supplier"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Controllers.SupplierController" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Supplier Management</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
         header {
            width: 100%;
            background-color: #3a3a3a;
            padding: 20px 0;
            text-align: center;
            position: relative;
        }

        h1 {
            font-size: 2.5rem;
            margin-top: 20px;
            margin-bottom: 1rem;
            color: #f1f1f1;
        }
        footer {
            width: 100%;
            background-color: #3a3a3a;
            color: #f1f1f1;
            padding: 20px 0;
            position: fixed; 
            bottom: 0;
            text-align: center;
        }
        .footer-message 
        {
            font-size: 220px;
            color: #ffffff;
            text-align: center;
        }
       </style>
</head>
<body>
    <header>
        <h1>IoTBay Supplier Management System</h1>
    </header>
    <br>
    <a class="btn btn-primary" href="staff.jsp">Back to Home page</a>
    
    <div class="container">
    <%
        String action = request.getParameter("action");
        if ("edit".equals(action)) 
        {
            int id = Integer.parseInt(request.getParameter("id"));
            SupplierController supplierController = new SupplierController();
            Supplier supplier = supplierController.getSupplierById(id);
    %>
    
    <h2>Edit Supplier</h2>
    <form method="post">
        <input type="hidden" name="id" value="<%= supplier.getId() %>">
        <div class="form-group">
            <input type="text" class="form-control" name="contact-name" value="<%= supplier.getContactName() %>" placeholder="Contact Name" required>
        </div>
        <div class="form-group">
            <input type="text" class="form-control" name="company" value="<%= supplier.getCompany() %>" placeholder="Company" required>
        </div>
        <div class="form-group">
            <input type="email" class="form-control" name="email" value="<%= supplier.getEmail() %>" placeholder="Email" required>
        </div>
        <div class="form-group">
            <input type="text" class="form-control" name="address" value="<%= supplier.getAddress() %>" placeholder="Address" required>
        </div>
        <div class="form-group">
            <input type="text" class="form-control" name="status" value="<%= supplier.getStatus() %>" placeholder="Status" required>
        </div>
        <button type="submit" class="btn btn-primary">Update Supplier</button>
    </form>
    
    <%
        }
    %>
    
    <h2>Add Supplier</h2>
<form method="post">
    <div class="form-group">
        <input type="text" name="contact-name" placeholder="Please enter Contact Name" required class="form-control">
    </div>
    <div class="form-group">
    <input type="text" name="company" placeholder="Please Enter Supplier Company Name" required class="form-control">
</div>
<div class="form-group">
    <input type="email" name="email" placeholder="Please Enter Your Email Address" required class="form-control">
</div>
<div class="form-group">
    <input type="text" name="address" placeholder="Please Enter Your Company Address" required class="form-control">
</div>
<div class="form-group">
    <input type="text" name="status" placeholder="Please Enter Your Company Status" required class="form-control">
</div>
<input type="submit" value="Add Supplier" class="btn btn-primary">
</form>

<h2>Search Supplier</h2>
<form method="post">
     <div class="form-group">
        <input type="text" name="contactName" placeholder="Search by Contact Name" class="form-control">
    </div>
    <div class="form-group">
        <input type="text" name="company" placeholder="Search by Company" class="form-control">
    </div>
    <input type="submit" value="Search" name="search" class="btn btn-primary">
</form>
<%
if (request.getParameter("contact-name") != null && request.getParameter("id") == null) 
{
String contactName = request.getParameter("contact-name");
String company = request.getParameter("company");
String email = request.getParameter("email");
String address = request.getParameter("address");
String status = request.getParameter("status");
SupplierController supplierController = new SupplierController();
    try 
    {
        //add to the database
        supplierController.addSupplier(contactName, company, email, address, status);
        response.sendRedirect("supplierManagement.jsp");
    } 
    catch (SQLException e) 
    {
        e.printStackTrace();
        request.setAttribute("error", "Error: Supplier could not be added");
        request.getRequestDispatcher("supplierManagement.jsp").forward(request, response);
    }
} 
else if (request.getParameter("contact-name") != null && request.getParameter("id") != null) 
{
    int id = Integer.parseInt(request.getParameter("id"));
    String contactName = request.getParameter("contact-name");
    String company = request.getParameter("company");
    String email = request.getParameter("email");
    String address = request.getParameter("address");
    String status = request.getParameter("status");

    SupplierController supplierController = new SupplierController();
    try {
        supplierController.updateSupplier(id, contactName, company, email, address, status);
        response.sendRedirect("supplierManagement.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("error", "Error: Supplier could not be updated");
        request.getRequestDispatcher("supplierManagement.jsp").forward(request, response);
    }
}

if (request.getParameter("delete-supplier-id") != null) 
{
    int id = Integer.parseInt(request.getParameter("delete-supplier-id"));
    SupplierController supplierController = new SupplierController();
    try 
    {
        supplierController.deleteSupplier(id);
        response.sendRedirect("supplierManagement.jsp");
    } 
    catch (SQLException e) 
    {
        e.printStackTrace();
        request.setAttribute("error", "Error: Supplier could not be deleted");
        request.getRequestDispatcher("supplierManagement.jsp").forward(request, response);
    }
}
%>

<%
SupplierController supplierController = new SupplierController();
List<Supplier> suppliers = new ArrayList<Supplier>();
if (request.getParameter("search") != null) 
{
    String contactName = request.getParameter("contactName");
    String company = request.getParameter("company");
    suppliers = supplierController.searchSuppliers(contactName, company);
} 
else if((request.getParameter("search") == null) )
{
    suppliers = supplierController.displayAllSuppliers();
}
%>

<table class="table table-bordered table-striped">
    <thead>
        <tr>
            <th>ID</th>
            <th>Contact Name</th>
            <th>Company</th>
            <th>Email</th>
            <th>Address</th>
            <th>Status</th>
            <th>Action</th>
    </tr>
</thead>
<tbody>
    <%
        //Show the the supplier data in the database in the interface
        for (Supplier supplier : suppliers) {
    %>
    <tr>
        <td><%= supplier.getId() %></td>
        <td><%= supplier.getContactName() %></td>
        <td><%= supplier.getCompany() %></td>
        <td><%= supplier.getEmail() %></td>
        <td><%= supplier.getAddress() %></td>
        <td><%= supplier.getStatus() %></td>
        <td>
            <a href="?action=edit&id=<%= supplier.getId() %>" class="btn btn-warning">Edit</a>
            <form method="post" style="display:inline;">
                <input type="hidden" name="delete-supplier-id" value="<%= supplier.getId() %>">
                <button type="submit" class="btn btn-danger">Delete</button>
            </form>
        </td>
    </tr>
    <% } %>
</tbody>
</table>
</div> 
</div>
    <div class="footer-message">End of Page</div>
</div>
<footer>
    <p>IoTBay &copy; 2023. All Rights Reserved.</p>
</footer>
</body>
</html>