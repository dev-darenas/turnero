/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
 package lib;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;


/**
 *
 * @author Administrador
 */
public class ConsultasProducto extends Conexion {
    Connection con=null;
    PreparedStatement pstm = null;
    ResultSet rs = null;
    
        
    public ResultSet ObtenerProductos(){
        try{
            String consulta = "SELECT * FROM producto";
            pstm = getConexion().prepareStatement(consulta);
            
            rs = pstm.executeQuery(consulta);
        } catch(Exception ex){
             Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        }
      
        return rs;
    }
    
    public boolean Registrar_Producto(String nombre,
            String descripcion){
        int resultUpdate=0;
        
        try{
            con = getConexion();
            String sql = "INSERT INTO `turnero`.`producto` (`nombre`, `descripcion`) VALUES (?, ?)"; 
            pstm= con.prepareStatement(sql);
            
            pstm.setString(1, nombre);
            pstm.setString(2, descripcion);
            
            resultUpdate= pstm.executeUpdate();
        
        if(resultUpdate !=0){
            pstm.close();
            return true;
        }else{
            pstm.close();
            return false;
        }
        
    }catch (Exception ex){
        System.out.println("Error en la base de datos.");
        ex.printStackTrace();
        return false;
    }
        
    }
    
    public void editar_modulo(){
        
    }
    
    public ResultSet obtener_modulo(int id){
        return null;
    }
    
    public void close(){
        try {
          if(getConexion() != null) getConexion().close();
          if(pstm != null ) pstm.close();
          if(rs != null ) rs.close();
        } catch (Exception ex) {
          Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        }     
    }
}