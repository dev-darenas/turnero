/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lib;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Dahian
 */
public class Conexion {
    private Connection con;
    private String username = "root";
    private String password = "root";
    private String HOST = "localhost";
    private String PORT = "3306";
    private String DB = "turnero";
    private String CLASSNAME = "com.mysql.jdbc.driver";
    private String URL = "jdbc:mysql://"+HOST+":"+PORT+"/"+DB;

    public Conexion(){
        try{
            Class.forName(CLASSNAME);
            con = DriverManager.getConnection(URL, username, password);
        } catch(ClassNotFoundException ex){
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }catch(Exception ex){
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Connection getConexion(){
        return con;
    }
}
