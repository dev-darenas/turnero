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
public class ConsultasModulo extends Conexion {
    Connection con=null;
    Statement pstm = null;
    ResultSet rs = null;
    private int cod_modulo=0;
     private String nombre="";
     private String descripcion="";
    
        
    public ResultSet obtenerModulos(){
        try{
            String consulta = "SELECT * FROM modulo";
            pstm = getConexion().createStatement();
            
            rs = pstm.executeQuery(consulta);
        } catch(Exception ex){
             Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        }
      
        return rs;
    }
    
    public void guardar_modulo ( int cod_modulo, String nombre,
            String descripcion){
        // va el codito para guardar el Modulo
        this.cod_modulo=cod_modulo;
        this.nombre=nombre;
        this.descripcion=descripcion;
        
                
                          
                 Statement st=null;
                  ResultSet rs=null;
                 try{ 
                 con=getConexion();
                  pstm.executeUpdate("insert into modulo values (" + cod_modulo + ",'"+nombre+"','"+descripcion+"');");
               
                  
               }catch(Exception e){}
                 
                
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
    
    public static void main (String[] args) throws SQLException{
        System.out.println("lib.ConsultasModulo.main()");
        ConsultasModulo conM = new ConsultasModulo();
        
            System.out.println(("NOMBRE"));
        }
    }  

