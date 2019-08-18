package lib;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConexionAbrirModulo extends Conexion {

    private PreparedStatement pst;
    private ResultSet consulta;
   
    public ResultSet getTurnoModulos(){
        
        try {
            String sql = "SELECT modulo.id as id, nombre, accion, turno.estado, IF(turno.tipo_servicio = 3, \"C\", \"A\") as TP, IF(prioridad, \"P\", \"\") as P,turno.num_turno " +
                        "  FROM turnero.modulo " +
                        "  INNER JOIN historico_modulo ON historico_modulo.id_modulo = modulo.id " +
                        "  INNER JOIN turno ON  historico_modulo.id = turno.id_historico_modulo " +
                        "  WHERE modulo.accion = 'Ocupado' AND turno.estado = 'aa'";

            pst = getConexion().prepareStatement(sql);
            consulta = pst.executeQuery();
            return consulta;
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }

        return null;
    }
    
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
 
 public boolean OcuparModulo (String id_modulo) {   
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
 
 public boolean abrirModulo (String id_modulo) {   
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
 
    public Integer llamarTurno(String id_modulo_historico, String rol_id, String stado) throws IOException{
        try{
            String sql= "";
            
            //Actualizar turnos anteriores
            sql = "UPDATE turno SET estado = 'a', fecha_terminado = now() where id_historico_modulo = ?";
            pst = getConexion().prepareStatement(sql);
            pst.setString(1, id_modulo_historico);
            pst.executeUpdate();
            
            int id_turno = 0;
            int id_cliente = 0;
            sql = "SELECT puntaje, id, id_cliente FROM turno where estado = 'e' AND tipo_servicio = ? ORDER BY puntaje DESC LIMIT 1;";
            pst = getConexion().prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(rol_id));
            consulta = pst.executeQuery();
            
            if(consulta.next()){
                id_turno = consulta.getInt("id");
                id_cliente = consulta.getInt("id_cliente");
            }else{
                // este tipo de usuario no tiene turnos
                sql = "SELECT puntaje, id, id_cliente FROM turno where estado = 'e' ORDER BY puntaje DESC LIMIT 1;";
                pst = getConexion().prepareStatement(sql);
                consulta = pst.executeQuery();
                
                if(consulta.next()){
                    id_turno = consulta.getInt("id");
                    id_cliente = consulta.getInt("id_cliente");
                }
            }
          
            
            // verificamos si el usuario tiene metodos de envio
            if(id_cliente != 0){
                sql = "SELECT notificar_email, email  FROM clientes where id = ?;";
                pst = getConexion().prepareStatement(sql);
                pst.setInt(1, id_cliente);
                consulta = pst.executeQuery();
                
                if(consulta.next()){
                    if(consulta.getInt("notificar_email") == 1){
                        
                        
                        System.out.println("lib.ConexionAbrirModulo.llamarTurno() send email");
                        //SendNotification.sendEmail(consulta.getString("email"));
                    }
                }
            }
            
            //Actualizar turno
            sql = "UPDATE turno SET estado = 'aa', id_historico_modulo = ?, fecha_llamado = now() where id = ?";
 
            pst = getConexion().prepareStatement(sql);
            pst.setString(1, id_modulo_historico);
            pst.setInt(2, id_turno);
            pst.executeUpdate();
            
            return id_turno;
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
        return null;
    }
            
 // metodo para consultar el id_hisotrico_modulo
 
 
     public ResultSet codigo (String id_modulo, int id_usuario) {   
        try {

            String sql = "SELECT historico_modulo.id, modulo.nombre as nombre FROM "
                    + "historico_modulo "
                    + "INNER JOIN modulo "
                    + "ON historico_modulo.id_modulo = modulo.id "
                    + "WHERE id_modulo = ? " 
                    + "AND historico_modulo.id_usuario = ? order by fecha_abierto desc limit 1";
            
  
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
 
 
   public ResultSet obtenerTurno(String turno_id){
        try {

            String sql = "SELECT * FROM turno WHERE id = ?";
            pst = getConexion().prepareStatement(sql);
            pst.setString(1, turno_id);
            consulta = pst.executeQuery();
            
            return consulta;
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        } 
       
       return null;
   }
          
   public ResultSet obtenerCliente(String cliente_id){
        try {

            String sql = "SELECT * FROM clientes WHERE id = ?";
            pst = getConexion().prepareStatement(sql);
            pst.setString(1, cliente_id);
            consulta = pst.executeQuery();
            
            return consulta;
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        } 
        
       return null;
   }
   
   public ResultSet obtenerProductos(String cliente_id){
        try {

            String sql = "SELECT producto.nombre as nombre, producto.descripcion as descripcion FROM cliente_producto "
                    + " INNER JOIN producto ON producto.id = cliente_producto.id_producto "
                    + " WHERE cliente_producto.id_cliente = ?";
            pst = getConexion().prepareStatement(sql);
            pst.setString(1, cliente_id);
            consulta = pst.executeQuery();
            
            return consulta;
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
        
        return null;
   }
   
   public void cerrarModulo(String id_historico_modulo, String cliente_id){
        try{
            String sql = "update historico_modulo set fecha_cerrado = now() where id = ?";

            pst = getConexion().prepareStatement(sql);
            pst.setString(1, id_historico_modulo);
            pst.executeUpdate();

            sql = "update modulo set accion = 'Disponible'";

            pst = getConexion().prepareStatement(sql);
            pst.executeUpdate();
            
        } catch (SQLException e) {
            System.out.println("ERROR EN CONSULTA " + e);
        }
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
   
  
    
    

    
    
    
    
    
    
    
    
    

