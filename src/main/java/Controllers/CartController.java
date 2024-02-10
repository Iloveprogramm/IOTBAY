/*
<%-- 
    Document   : CartController
    Author     : Chenjun Zheng
--%>
 */
package Controllers;

import DAO.CartDAO;
import java.util.List;
import java.util.Map;

public class CartController {
    private CartDAO cartDAO;

    public CartController() {
        this.cartDAO = new CartDAO();
    }

    public void addProduct(String id, String productName, double productPrice) {
        cartDAO.addProduct(id, productName, productPrice);
    }

    public List<Map<String, Object>> displayShoppingCartProducts() {
        return cartDAO.displayShoppingCartProducts();
    }

    public int showShoppingCartSize() {
        return cartDAO.showShoppingCartSize();
    }

    public void increaseSingleProduct(int productId) {
        cartDAO.increaseSingleProduct(productId);
    }

    public void decreaseSingleProduct(int productId) {
        cartDAO.decreaseSingleProduct(productId);
    }

    public void cancelOrder() {
        cartDAO.cancelOrder();
    }

    public void placeOrder(int userId) {
        cartDAO.placeOrder(userId);
    }
}
