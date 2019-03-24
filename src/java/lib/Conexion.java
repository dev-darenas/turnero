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
import java.sql.*;

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
    private String CLASSNAME = "com.mysql.jdbc.Driver";
    private String URL = "jdbc:mysql://"+HOST+":"+PORT+"/"+DB+"?useSSL=false";

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

    public ResultSet realizarConsulta(String query) throws SQLException {
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();
        
        return rs;
    }
  
    public void ingresarCLiente(int id,String nombre,String producto, String ciudad) throws SQLException{
        ps=con.prepareStatement("insert into clientes (id,nombre,producto,ciudad ) values("+id+",'"+nombre+"','"+producto+"','"+ciudad+"')");
        ps.executeUpdate();
    }
  
    public void cierraConexion() {
      try {
          con.close();
      } catch (SQLException sqle) {
          Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, sqle);
      }
    }
    
    public PreparedStatement actualizarCliente(int id,String nom,String produ,String ciudad){
        PreparedStatement pstm = null;
         try {
             pstm = con.prepareStatement("update clientes "
                    + "set id= "+id+" ,  "
                    + "nombre= '"+nom+"' , "
                    + "producto= '"+produ+"' , "
                    + "ciudad= '"+ciudad+"' "
                    + "where id= " + id );
          pstm.executeUpdate();
 
        } catch (SQLException e) {
            System.out.println(e);
        }
       return pstm;
    }
  
    public Connection getConexion(){
        return con;
    }
}
