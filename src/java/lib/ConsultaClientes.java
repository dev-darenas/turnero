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
import java.sql.*;

/**
 *
 * @author Dahian
 */
public class ConsultaClientes extends Conexion{

    PreparedStatement ps;
    ResultSet rs;

    public PreparedStatement getPs() {
        return ps;
    }

    public ResultSet getRs() {
        return rs;
    }

    public ResultSet realizarConsulta(String query) throws SQLException {
        ps = getConexion().prepareStatement(query);
        rs = ps.executeQuery();
        
        return rs;
    }
 
          
    public void ingresarCLiente(int cc,String nombre,String apellido, String email,String cel,String pais,String departamento, String ciudad, String direccion,String id, String estado, String notificar_e, String notificar_s) throws SQLException{
        
//        ps=con.prepareStatement("insert into clientes (Cc,Nombre,Apellido,Email,Cel,Pais,Departamento,Ciudad,Direccion,Id,Estado,Notificar_email,Notificar_sms ) values(?,'?','?','?',?, '?', '?', '?', '?', ?, '?', '?', '?'  )");
//        ps.setInt(1, cc);
//        ps.setString(2, nombre);
//        ps.setString(3, apellido);
//        ps.setString(4, email);
//        ps.setString(5, cel);
//        ps.setString(6, pais);
//        ps.setString(7, departamento);
//        ps.setString(8, ciudad);
//        ps.setString(9, direccion);
//        ps.setString(10, id);
//        ps.setString(11, estado);
//        ps.setString(12, notificar_e);
//        ps.setString(13, notificar_s);
        
        ps= getConexion().prepareStatement("insert into clientes (cc,nombre,apellido,email) values("+cc+",'"+nombre+"','"+apellido+"','"+email+"')");
        ps.executeUpdate();
        
    }
    public void ingresarProducto(int cliente,int producto) throws SQLException{
        int siguiente=1;
        ps= getConexion().prepareStatement("insert into cliente_producto (id_cliente,id_producto ) values(?,?)");
        
        
        ps.setInt(1, cliente);
        ps.setInt(2, producto);
       
        ps.executeUpdate();
        
    }
    public int consultaCodigoProducto(String nombre) throws SQLException{
        rs=realizarConsulta("select id_producto from producto where nombre='"+nombre+"'");
        int codigo=0;
        if(rs.next()){
        codigo=rs.getInt("id_producto");
        }
        return codigo;
    }
    
    public void cierraConexion() {
    try {
        getConexion().close();
    } catch (SQLException sqle) {
        
        Logger.getLogger(ConsultaClientes.class.getName()).log(Level.SEVERE, null, sqle);
    }
}
    
    public PreparedStatement actualizarCliente (int cc,String nombre,String  apellido,String  email, String cel,String  pais,String  departamento,String  ciudad,String  direccion,String  id,String  estado,String  notificar_email,String  notificar_sms){
        PreparedStatement pstm = null;
         try {
             pstm = getConexion().prepareStatement("update clientes set "
                   
                    + "Nombre= '"+nombre+"' , "
                    + "Apellido= '"+apellido+"' , "
                    + "Email= '"+email+"', "
                    + "Cel= '"+cel+"', "
                    + "Pais= '"+pais+"', "
                    + "Departamento= '"+departamento+"', "
                    + "Ciudad= '"+ciudad+"', "
                    + "Direccion= '"+direccion+"', "
                    + "Id= '"+id+"', "
                    + "Estado= '"+estado+"', "
                    + "Notificar_email= '"+notificar_email+"', "
                    + "Notificar_sms= '"+notificar_sms+"' "
                     
                     
                    + "where Cc= " + cc );
            
           
          pstm.executeUpdate();
 
        } catch (SQLException e) {
            System.out.println(e);
        }
       return pstm;
    }
    
    public PreparedStatement eliminarCliente(int cc){
        PreparedStatement pstm = null;
         try {
             pstm = getConexion().prepareStatement("delete from clientes where"
                    + " Cc= "+cc);
            
           
          pstm.executeUpdate();
 
        } catch (SQLException e) {
            System.out.println(e);
        }
       return pstm;
    }
    public PreparedStatement eliminarProducto(int id){
        PreparedStatement pstm = null;
         try {
             pstm = getConexion().prepareStatement("delete from cliente_producto where"
                    + " id_cliente_producto= "+id);
            
           
          pstm.executeUpdate();
 
        } catch (SQLException e) {
            System.out.println(e);
        }
       return pstm;
    }
}
