/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Yuxin Liu
 */
public class PaymentControllerTest {
    
    public PaymentControllerTest() {
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
     * Test of addCardDetails method, of class PaymentController.
     */
    @Test
    public void testAddCardDetails() {
        System.out.println("addCardDetails");
        String cardNumber = "1111111111111";
        String expiryDate = "11/23";
        String cvc = "123";
        boolean savePayment = false;
        PaymentController instance = new PaymentController();
        instance.addCardDetails(cardNumber, expiryDate, cvc, savePayment);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of handlePaymentRequest method, of class PaymentController.
     */


    /**
     * Test of addPaymentRecord method, of class PaymentController.
     */
    @Test
    public void testAddPaymentRecord() {
        System.out.println("addPaymentRecord");
        Payment payment = null;
        PaymentController instance = new PaymentController();
        instance.addPaymentRecord(payment);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of getPaymentIdByOrderId method, of class PaymentController.
     */
    @Test
    public void testGetPaymentIdByOrderId() {
        System.out.println("getPaymentIdByOrderId");
        int orderId = 0;
        PaymentController instance = new PaymentController();
        int expResult = 0;
        int result = instance.getPaymentIdByOrderId(orderId);
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of getAllPaymentHistory method, of class PaymentController.
     */
    @Test
    public void testGetAllPaymentHistory() {
        System.out.println("getAllPaymentHistory");
        PaymentController instance = new PaymentController();
        ArrayList<Payment> expResult = null;
        ArrayList<Payment> result = instance.getAllPaymentHistory();
        // TODO review the generated test code and remove the default call to fail.
    }

    /**
     * Test of searchPaymentHistory method, of class PaymentController.
     */
    @Test
    public void testSearchPaymentHistory() {
        System.out.println("searchPaymentHistory");
        String orderId = "243";
        String paymentId = "108";
        String startDate = "2023-05-17";
        boolean searchAll = false;
        PaymentController instance = new PaymentController();
        ArrayList<Payment> expResult = null;
        ArrayList<Payment> result = instance.searchPaymentHistory(orderId, paymentId, startDate, searchAll);
    }
    
}
