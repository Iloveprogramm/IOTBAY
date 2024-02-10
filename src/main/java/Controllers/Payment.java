package Controllers;

import java.util.Date;

public class Payment {
    private int orderId;
    private Date orderDate;
    private double totalPrice;
    private int paymentId;
    private Date paymentTime;

    public Payment(int orderId, int paymentId, Date orderDate, Date paymentTime, double totalPrice) {
        this.orderId = orderId;
        this.paymentId = paymentId;
        this.orderDate = orderDate;
        this.paymentTime = paymentTime;
        this.totalPrice = totalPrice;
    }

    public int getOrderId() {
        return this.orderId;
    }

    public Date getOrderDate() {
        return this.orderDate;
    }

    public double getTotalPrice() {
        return this.totalPrice;
    }

    public int getPaymentId() {
        return this.paymentId;
    }

    public Date getPaymentTime() {
        return this.paymentTime;
    }
}



