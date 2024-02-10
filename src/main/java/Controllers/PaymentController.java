package Controllers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;

public class PaymentController {
    static String databaseURL = "jdbc:derby://localhost:1527/41025iotBay;user=ChenjunZheng;password=14208603";

    public void addCardDetails(String cardNumber, String expiryDate, String cvc, boolean savePayment) {
        try (Connection connection = DriverManager.getConnection(databaseURL)) {
            String sql = "INSERT INTO CARD_DETAILS (CARD_NUMBER, EXPIRY_DATE, CVC, SAVE_PAYMENT) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, cardNumber);
            statement.setString(2, expiryDate);
            statement.setString(3, cvc);
            statement.setBoolean(4, savePayment);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void handlePaymentRequest(HttpServletRequest request) {
        String cardNumber = request.getParameter("CardNumber");
        String expiryDate = request.getParameter("ExpDate");
        String cvc = request.getParameter("cvc");
        String savePayment = request.getParameter("savePayment");

        if (savePayment != null && savePayment.equals("on")) {
            addCardDetails(cardNumber, expiryDate, cvc, true);
        }
    }

    public void addPaymentRecord(Payment payment) {
        try (Connection connection = DriverManager.getConnection(databaseURL)) {
            String sql = "INSERT INTO PAYMENTLIST (payment_id, order_id, order_date, payment_time, total_price) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, payment.getPaymentId());
            statement.setInt(2, payment.getOrderId());
            statement.setDate(3, new java.sql.Date(payment.getOrderDate().getTime()));
            statement.setDate(4, new java.sql.Date(payment.getPaymentTime().getTime()));
            statement.setDouble(5, payment.getTotalPrice());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getPaymentIdByOrderId(int orderId) {
        int paymentId = -1;
        try (Connection connection = DriverManager.getConnection(databaseURL)) {
            String sql = "SELECT payment_id FROM paymentlist WHERE order_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, orderId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                paymentId = resultSet.getInt("payment_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentId;
    }

    public ArrayList<Payment> getAllPaymentHistory() {
        ArrayList<Payment> resultPayments = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(databaseURL)) {
            String query = "SELECT * FROM paymentlist";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Payment payment = new Payment(
                        resultSet.getInt("order_id"),
                        resultSet.getInt("payment_id"),
                        resultSet.getDate("order_date"),
                        resultSet.getDate("payment_time"),
                        resultSet.getDouble("total_price")
                );
                resultPayments.add(payment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultPayments;
    }

    public ArrayList<Payment> searchPaymentHistory(String orderId, String paymentId, String startDate, boolean searchAll) {
        ArrayList<Payment> resultPayments = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(databaseURL)) {
            String query = "SELECT * FROM paymentlist";
            if (!searchAll) {
                query += " WHERE 1=1";
                if (orderId != null && !orderId.isEmpty()) {
                    query += " AND order_id = ?";
                }
                if (paymentId != null && !paymentId.isEmpty()) {
                    query += " AND payment_id = ?";
                }
                if (startDate != null && !startDate.isEmpty()) {
                    query += " AND order_date >= ?";
                }
            }
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            int paramIndex = 1;
            if (!searchAll) {
                if (orderId != null && !orderId.isEmpty()) {
                    preparedStatement.setInt(paramIndex++, Integer.parseInt(orderId));
                }
                if (paymentId != null && !paymentId.isEmpty()) {
                    preparedStatement.setInt(paramIndex++, Integer.parseInt(paymentId));
                }
                if (startDate != null && !startDate.isEmpty()) {
                    java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
                    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                    preparedStatement.setDate(paramIndex++, sqlDate);
                }
            }

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Payment payment = new Payment(
                        resultSet.getInt("order_id"),
                        resultSet.getInt("payment_id"),
                        resultSet.getDate("order_date"),
                        resultSet.getTime("payment_time"), 
                        resultSet.getDouble("total_price")
                );
                resultPayments.add(payment);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("SQL state: " + ((SQLException) e).getSQLState());
            System.out.println("Error code: " + ((SQLException) e).getErrorCode());
            System.out.println("Message: " + e.getMessage());
            Throwable t = e.getCause();
            while(t != null) {
                System.out.println("Cause: " + t);
                t = t.getCause();
            }
        } 
        return resultPayments;
    }


}




