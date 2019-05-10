
package lib;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Lider Buitrago
 */
public class ConexionUsuario extends Conexion {

    private PreparedStatement pst;
    private ResultSet consulta;
   
 // Metodo para consultar toda la tabla
    
    public ResultSet consultarTabla() {

        try {
            String sql = "SELECT * FROM usuarios";
            pst = getConexion().prepareStatement(sql);
            consulta = pst.executeQuery();
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
        return consulta;
    }

// Metodo para buscar por cedula en la tabla
    
    public ResultSet buscar(String cedula) {   
        try {
            String sql = "SELECT * FROM usuarios WHERE cedula= ?";
            pst = getConexion().prepareStatement(sql);
            pst.setString(1, cedula);
            consulta = pst.executeQuery();
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
        return consulta;
    }
   
     public ResultSet buscar(int id) {   
        try {
            String sql = "SELECT * FROM usuarios WHERE id= ?";
            pst = getConexion().prepareStatement(sql);
            pst.setInt(1, id);
            consulta = pst.executeQuery();
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
        return consulta;
    }
    
    //Metodo para registrar Usuarios
            
    public boolean registro (String nombre, String apellido, String cedula, String telefono, 
                              String cargo, String email, String password, String estado) {   
        try {
            
            System.out.println("Entra a registrar el usuario!!");
            
            String sql = "INSERT INTO usuarios (nombre, apellido, cedula, telefono, "
                         + "rol_id, email, password, estado)"
                         + "values (?, ?, ?, ?, ?, ?, ?, ?)";

            pst = getConexion().prepareStatement(sql);
            pst.setString(1, nombre);
            pst.setString(2, apellido);
            pst.setString(3, cedula);
            pst.setString(4, telefono);
            pst.setString(5, cargo);
            pst.setString(6, email);
            pst.setString(7, password);
            pst.setString(8, estado);
            
            System.out.println("ejecuta comando");
            pst.executeUpdate();
                       
            return true;
             
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
        
        return false;
    }

    
//Metodo para Actualizar Usuarios
    
 public boolean modificar (int codigo, String nombre, String apellido, String cedula, String telefono, 
                              String cargo, String email, String password, String estado) {   
        try {

            String sql = "UPDATE USUARIO SET cedula = ?, nombre = ?, apellido = ?, telefono = ?, "
                         + "rol_id = ?, email = ?, estado = ? WHERE id = ?";

            pst = getConexion().prepareStatement(sql);
            pst.setString(1, cedula);
            pst.setString(2, nombre);
            pst.setString(3, apellido);
            pst.setString(4, telefono);
            pst.setString(5, cargo);
            pst.setString(6, email);
            pst.setString(7, estado);
            pst.setInt(8, codigo);
            pst.executeUpdate();

            return true;
             
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
        
        return false;
    }
    

 //Metodo para eliminar Usuarios
 
 public boolean eliminar (String cedula) {   
        try {

            String sql = "delete from usuarios where cedula = ?";
 
            pst = getConexion().prepareStatement(sql);
            pst.setString(1, cedula);
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
   
    
    
    
