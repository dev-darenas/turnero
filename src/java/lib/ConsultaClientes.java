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

//    Connection con;
//    String url = "jdbc:mysql://localhost:3306/turnero";
//    String Driver = "com.mysql.jdbc.Driver";
//    String user = "root";
//    String clave = "";

    PreparedStatement ps;
    ResultSet rs;

    public Connection getCon() {
        return con;
    }

    public PreparedStatement getPs() {
        return ps;
    }

    public ResultSet getRs() {
        return rs;
    }

    public Connection getConexion() {
        return con;
    }

    

    public ResultSet realizarConsulta(String query) throws SQLException {
        ps = con.prepareStatement(query);
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
        
         ps=con.prepareStatement("insert into clientes (Cc,Nombre,Apellido,Email,Cel,Pais,Departamento,Ciudad,Direccion,Id,Estado,Notificar_email,Notificar_sms ) values("+cc+",'"+nombre+"','"+apellido+"','"+email+"',"+cel +", '"+pais+"', '"+departamento+"', '"+ciudad+"', '"+direccion+"', "+id+", '"+estado+"', '"+notificar_e+"', '"+notificar_s+"'  )");
   
        ps.executeUpdate();
        
    }
    public void ingresarProducto(int cliente,int producto) throws SQLException{
        int siguiente=1;
        ps=con.prepareStatement("insert into cliente_producto (id_cliente_producto,id_cliente,id_producto ) values(?,?,?)");
        
        ps.setInt(1,siguiente );
        ps.setInt(2, cliente);
        ps.setInt(3, producto);
       
        ps.executeUpdate();
        
    }
    public int consultaCodigoProducto(String nombre) throws SQLException{
        rs=realizarConsulta("select id_producto from producto where nombre_producto='"+nombre+"'");
        int codigo=0;
        if(rs.next()){
        codigo=rs.getInt("id_producto");
        }
        return codigo;
    }
    
    public void cierraConexion() {
    try {
        con.close();
    } catch (SQLException sqle) {
        
        Logger.getLogger(ConsultaClientes.class.getName()).log(Level.SEVERE, null, sqle);
    }
}
    
    public PreparedStatement actualizarCliente (int cc,String nombre,String  apellido,String  email, String cel,String  pais,String  departamento,String  ciudad,String  direccion,String  id,String  estado,String  notificar_email,String  notificar_sms){
        PreparedStatement pstm = null;
         try {
             pstm = con.prepareStatement("update clientes set "
                   
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
             pstm = con.prepareStatement("delete from clientes where"
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
             pstm = con.prepareStatement("delete from cliente_producto where"
                    + " id_cliente_producto= "+id);
            
           
          pstm.executeUpdate();
 
        } catch (SQLException e) {
            System.out.println(e);
        }
       return pstm;
    }
}
