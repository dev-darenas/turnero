/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lib;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Dahian
 */
public class Conexion {
    Connection conn1 = null;
    String dbURL2 = "jdbc:oracle:thin:@localhost:1521:darenas";
    String username = "admin";
    String password = "123456789";
    
    public Conexion(){
        try{
            conn1 = DriverManager.getConnection(dbURL2, username, password);
        } catch(Exception ex){
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Connection getConexion(){
        return conn1;
    }
}
