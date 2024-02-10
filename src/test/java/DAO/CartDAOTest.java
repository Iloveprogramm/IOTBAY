/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.util.List;
import java.util.Map;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Chenjun Zheng
 */
public class CartDAOTest {
    
    public CartDAOTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of addProduct method, of class CartDAO.
     */
    @Test
    public void testAddProduct() {
        String id = "1";
        String productName = "";
        double productPrice = 0.0;
        CartDAO instance = new CartDAO();
        instance.addProduct(id, productName, productPrice);
    }

    /**
     * Test of displayShoppingCartProducts method, of class CartDAO.
     */
    @Test
    public void testDisplayShoppingCartProducts() {
        CartDAO instance = new CartDAO();
        List<Map<String, Object>> expResult = null;
        List<Map<String, Object>> result = instance.displayShoppingCartProducts();
    }

    /**
     * Test of showShoppingCartSize method, of class CartDAO.
     */
    @Test
    public void testShowShoppingCartSize() {
        CartDAO instance = new CartDAO();
        int expResult = 0;
        int result = instance.showShoppingCartSize();
    }

    /**
     * Test of increaseSingleProduct method, of class CartDAO.
     */
    @Test
    public void testIncreaseSingleProduct() {
        int productId = 0;
        CartDAO instance = new CartDAO();
        instance.increaseSingleProduct(productId);
    }

    /**
     * Test of decreaseSingleProduct method, of class CartDAO.
     */
    @Test
    public void testDecreaseSingleProduct() {
        int productId = 0;
        CartDAO instance = new CartDAO();
        instance.decreaseSingleProduct(productId);
    }

    /**
     * Test of cancelOrder method, of class CartDAO.
     */
    @Test
    public void testCancelOrder() {
        CartDAO instance = new CartDAO();
        instance.cancelOrder();
    }

    /**
     * Test of placeOrder method, of class CartDAO.
     */
    @Test
    public void testPlaceOrder() {
        int userId = 0;
        CartDAO instance = new CartDAO();
        instance.placeOrder(userId);
    }
    
}
