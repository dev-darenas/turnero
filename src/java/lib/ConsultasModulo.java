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
    
    public boolean registrar(int cod_modulo,String nombre,
            String descripcion){
        int resultUpdate=0;
        
        try{
            con=getConexion();
            pstm= con.createStatement();
       
        resultUpdate=
                pstm.executeUpdate("insert into modulo values("
         +cod_modulo+",'"
         +nombre+"','" + descripcion +"');");
        
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
    
    
    public static void main(String args[]){
        System.out.println("lib.ConsultasModulo.main()");
        ConsultasModulo co=new ConsultasModulo();
        co.registrar(500, "TEst1","DEscrip");
    }
}  

