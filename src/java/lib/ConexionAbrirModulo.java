package lib;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConexionAbrirModulo extends Conexion {
    

    private PreparedStatement pst;
    private ResultSet consulta;
   

    //Metodo para consultar modulos disponibles
 
     public ResultSet ModuloDisponibles(String modulo_tipe_id) {
        try {
            String sql = "SELECT id, nombre FROM modulo WHERE estado = 1 AND accion = 'Disponible'";
            if(!modulo_tipe_id.equals("1")){
                sql += " AND tipo_modulo_id = " + modulo_tipe_id;
            }

            pst = getConexion().prepareStatement(sql);
            consulta = pst.executeQuery();
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }

        return consulta;
    }

     //Metodo para insertar datos a la tabla historico_modulo
     public boolean ActivarModulo (String id_modulo, int id_usuario) {   
        
         try {
             
            String sql = "insert into historico_modulo (id_modulo, id_usuario, fecha_abierto, fecha_cerrado)"
                         + "values (?, ?, now(), ?)";
            
            pst = getConexion().prepareStatement(sql);
            pst.setString(1, id_modulo);
            pst.setInt(2, id_usuario);
            pst.setDate(3,null );
  
            pst.executeUpdate();
                       
            return true;
             
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
        
        return false;
    }
     
     //Metodo para consultar el nombre del empleado
 
     public ResultSet ObtenerNombre(int id_usuario) {   
        try {

            String sql = "select nombre from usuarios where id= ?";

            pst = getConexion().prepareStatement(sql);
            pst.setInt(1, id_usuario);
            consulta = pst.executeQuery();

        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
        
        return consulta;
    }
 
 
  //Metodo para actualizar el estado a ocupado
 
 public boolean actualizarEstado1 (String id_modulo) {   
        try {

            String sql = "update modulo set accion = 'Ocupado' where id = ?";
 
            pst = getConexion().prepareStatement(sql);
            pst.setString(1, id_modulo);
            pst.executeUpdate();
           
            return true;
             
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
        
        return false;
    }
    

  //Metodo para actualizar el estado a disponible
 
 public boolean actualizarEstado2 (String id_modulo) {   
        try {

            String sql = "update modulo set accion = 'Disponible' where id = ?";
 
            pst = getConexion().prepareStatement(sql);
            pst.setString(1, id_modulo);
            pst.executeUpdate();
           
            return true;
             
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
        
        return false;
    } 
 
 
 // metodo para consultar el id_hisotrico_modulo
 
 
     public ResultSet codigo (String id_modulo, int id_usuario) {   
        try {

            String sql = "select id from historico_modulo where id_modulo = ? " 
                  + "and id_usuario = ? order by fecha_abierto desc limit 1";
            
  
            pst = getConexion().prepareStatement(sql);
            pst.setString(1, id_modulo);
            pst.setInt(2, id_usuario);
            consulta = pst.executeQuery();

        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
        
        return consulta;
    }
 
  //Metodo para actualizar el cirre del modulo del empleado
 
 public boolean actualizarHora (int codigo) {   
        try {

            String sql = "update historico_modulo set fecha_cerrado = now() where id = ?";
 
            pst = getConexion().prepareStatement(sql);
            pst.setInt(1, codigo);
            pst.executeUpdate();
           
            return true;
             
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
        
        return false;
    } 
 
 
 
  //Metodo para desconectar la base de datos
 
    public void desconectar() {

        try {
            if (consulta != null) {
                consulta.close();
            }
            pst.close();
            getConexion().close();
            System.out.println("Se desconecto Exitosamente");
        } catch (SQLException error) {
            System.out.println("ERROR EN DESCONEXION: " + error);
        }

    }
}
   
     

     
     ////////////////////////////////////////////////////////////////////////
     //////////////////////////////////////////////////////////////////////////
     ///////////////////////////////////////////////////////////////////////////
   
  
    
    

    
    
    
    
    
    
    
    
    

