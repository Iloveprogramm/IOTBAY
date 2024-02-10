/*
<%-- 
    Document   : OrderController
    Author     : Chenjun Zheng
--%>
 */
package Controllers;

import Models.Order;
import DAO.OrderDAO;
import java.util.ArrayList;

public class OrderController {
    private OrderDAO orderDAO;

    public OrderController() {
        this.orderDAO = new OrderDAO();
    }

    public ArrayList<Order> searchOrderHistory(String orderId, String startDate) {
        return orderDAO.searchOrderHistory(orderId, startDate);
    }
}

