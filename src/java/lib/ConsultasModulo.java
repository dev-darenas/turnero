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
    PreparedStatement pstm = null;
    ResultSet rs = null;
    private ResultSet consulta;
        
    public ResultSet obtenerModulos(){
        try{
            String consulta = "SELECT * FROM modulo";
            pstm = getConexion().prepareStatement(consulta);
            
            rs = pstm.executeQuery(consulta);
        } catch(Exception ex){
             Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        }
      
        return rs;
    }
    
    public boolean registrar(String nombre,
            String descripcion){
        int resultUpdate=0;
        
        try{
            con = getConexion();
            String sql = "INSERT INTO `turnero`.`modulo` (`nombre`, `descripcion`) VALUES (?, ?)"; 
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
    public ResultSet buscar(int cod_modulo) {   
        try {

             String sql = "select * from modulo where cod_modulo= ?";

             pstm = getConexion().prepareStatement(sql);
            pstm.setInt(1, cod_modulo);
            consulta = pstm.executeQuery();

         } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }

         return consulta;
    }

    
    public boolean editar_modulo (String nombre, String descripcion,int cod_modulo) {   
        try {

             String sql = "update modulo set nombre = ?, descripcion = ? where cod_modulo = ?";

             pstm = getConexion().prepareStatement(sql);
            pstm.setString(1, nombre);
            pstm.setString(2, descripcion);
            pstm.setInt(3, cod_modulo);
            pstm.executeUpdate();

             return true;

         } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }

         return false;
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
        co.registrar("TEst1","DEscrip");
    }
}  

