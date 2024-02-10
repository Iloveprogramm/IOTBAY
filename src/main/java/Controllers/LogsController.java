/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;
import java.util.Vector;

/**
 *
 * @author Griffin
 */
public class LogsController {
    Vector<String[]> logs;
    
    public int getSize(int acc_id){
     return DatabaseController.getLogSize(acc_id);
    }
    
    public String[] getLog(int i){
    return logs.get(i);
    }
    
    public void retreiveLogs(int acc_id){
        logs = new Vector<>();
        for(int i = 0; i < getSize(acc_id); i++){
            logs.add(DatabaseController.getLog(acc_id, i));
        }
    }
}
