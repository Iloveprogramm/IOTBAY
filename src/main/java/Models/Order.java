/*
<%-- 
    Document   : Order
    Author     : Chenjun Zheng
--%>
 */
package Models;

import java.util.Date;

public class Order {
    private int orderId;
    private int userId;
    private Date orderDate;
    private double totalPrice;

    public Order(int orderId, int userId, Date orderDate, double totalPrice) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;
    }

    public int getOrderId() {
        return orderId;
    }

    public int getUserId() {
        return userId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }
}
