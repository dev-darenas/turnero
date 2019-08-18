/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lib;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jhoan
 */
public class ConsultaTurno extends Conexion {

    String turno="";
    
    public int promedioEspera(){
        int espera = 0;
        ResultSet turnos = null;
        PreparedStatement pstm = null;
        
        try{
            String consulta = "SELECT ROUND(time_to_sec((TIMEDIFF(turno.fecha_llamado, turno.fecha_creacion))) / 60) as diff " +
                                "FROM turnero.turno " +
                                "WHERE fecha_llamado IS NOT NULL " +
                                "ORDER BY id DESC LIMIT 10;";
            
            pstm = getConexion().prepareCall(consulta);   
            turnos = pstm.executeQuery();
            
            while (turnos.next()) {
                espera += turnos.getInt("diff");
            }
            
        }catch (SQLException ex) {
            Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            System.out.println("lib.ConsultaTurno.promedioEspera() Finnally");
            
        }
        
        return espera / 10;
    }

    public int promedioAtencio(){
        int espera = 0;
        ResultSet turnos = null;
        PreparedStatement pstm = null;
        
        try{
            String consulta = "SELECT ROUND(time_to_sec((TIMEDIFF(turno.fecha_terminado, turno.fecha_llamado))) / 60) as diff " +
                                "FROM turnero.turno " +
                                "ORDER BY id DESC LIMIT 10;";
            
            pstm = getConexion().prepareCall(consulta);   
            turnos = pstm.executeQuery();
            
            while (turnos.next()) {
                espera += turnos.getInt("diff");
            }
            
        }catch (SQLException ex) {
            Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            System.out.println("lib.ConsultaTurno.promedioEspera() Finnally");
            
        }
        
        return espera / 10;
    }

    public ResultSet obtenerTodosLosTurnos(){
        ResultSet turnos = null;
        try {
            PreparedStatement pstm = null;

            String consulta = "SELECT " +
                            "	num_turno," +
                            "    if(prioridad = 1, \"P\", \"\") as p ," +
                            "    if(tipo_servicio = 2, \"A\", \"C\") as TS, " +
                            "    ROUND(time_to_sec((TIMEDIFF(turno.fecha_llamado, turno.fecha_creacion))) / 60) as TiempoEspera, " +
                            "    ROUND(time_to_sec((TIMEDIFF(turno.fecha_terminado, turno.fecha_llamado))) / 60) as TiempoAencion, " +
                            "    clientes.nombre as nombre, " +
                            "    clientes.apellido as apellido, " +
                            "    usuarios.nombre as nombre_em, " +
                            "    usuarios.apellido as apellido_em " +
                            "FROM  " +
                            "turnero.turno " +
                            "INNER JOIN clientes " +
                            "on clientes.id = turno.id_cliente " +
                            "INNER JOIN historico_modulo " +
                            "on historico_modulo.id = turno.id_historico_modulo " +
                            "INNER JOIN usuarios " +
                            "on usuarios.id = historico_modulo.id_usuario " +
                            "where turno.estado = 'a' OR turno.estado = 'c' " +
                            "ORDER BY turno.id DESC";

            pstm = getConexion().prepareCall(consulta);
            turnos = pstm.executeQuery();
            
        } catch (SQLException ex) {
            Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return turnos;
    }
        
    public ResultSet obtenerTurnos(){
        ResultSet turnos = null;
        try {
            PreparedStatement pstm = null;

            String consulta = "SELECT IF(turno.tipo_servicio = 3, \"C\", \"A\") as TP, IF(prioridad, \"P\", \"\") as P,turno.num_turno, "
                    + " ROUND(time_to_sec((TIMEDIFF(NOW(), turno.fecha_creacion))) / 60) as diff  "
                    + "FROM turnero.turno where estado = 'e' ORDER BY puntaje DESC;";
            pstm = getConexion().prepareCall(consulta);
            
            turnos = pstm.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return turnos;
    }
    
    public String crearTurno(String cedula, String celular, String correo, String tipoServicio, String prioridad, String notwhatsapp, String notemail, String notsms) {
        
        //Estados del turno
        // e = espera
        // aa = atendiendo
        // a = Atendido
        // c = cancelado
        
        int numTurno = 0;

        PreparedStatement pstm = null;
        ResultSet rs = null;
        int puntaje = 0;
        
        try {
            String consulta = "SELECT * FROM clientes WHERE cc = ?";
            pstm = getConexion().prepareCall(consulta);
            pstm.setString(1, cedula);

            rs = pstm.executeQuery();

            if (rs.absolute(1)) {
                //Quiere decir que es cliente
                puntaje = 1;
            } else {
                // si no es cliente lo inserta
                String insertar = "Insert into clientes (cc,email,cel,estado,notificar_email,notificar_sms,notificar_wp) values (?,?,?,?,?,?,?)";
                pstm = getConexion().prepareCall(insertar);
                pstm.setString(1, cedula);
                pstm.setString(2, correo);
                pstm.setString(3, celular);
                pstm.setString(4, "0");
                pstm.setString(5, notemail);
                pstm.setString(6, notsms);
                pstm.setString(7, notwhatsapp);
                pstm.executeUpdate();
                pstm.close();
            }
            
            //Consulto la cantidad de turnos con ese tipo de servicio
            String consulta_cantidad_turnos = "SELECT * FROM turno WHERE tipo_servicio = ? order by id desc";
            pstm = getConexion().prepareCall(consulta_cantidad_turnos);
            pstm.setString(1, tipoServicio);

            rs = pstm.executeQuery();

            if (rs.absolute(1)) {
               numTurno = rs.getInt("num_turno") + 1; 
            }else{
               numTurno = 1;
            }
            
            // Sumar un punto a los turnos antiguos
            String sql = "UPDATE turno set puntaje = puntaje + 1 where estado = 'e'";
            PreparedStatement pst = getConexion().prepareStatement(sql);

            pst.executeUpdate();
            // Fin actualizar los turnos

            if(prioridad != null && prioridad.equals("1")){
                puntaje = puntaje + 2;
                turno += "P";
            }
            
            System.out.println("lib.ConsultaTurno.crearTurno() -- 1");
            String insertar = "Insert into turno (id_cliente,num_turno,tipo_servicio,prioridad,id_historico_modulo,fecha_creacion,estado,puntaje) values "
                                             + "((Select id from clientes where cc = ? LIMIT 1), ? , ? , ? ,0, NOW(),'e', ?)";
            
            pstm = getConexion().prepareCall(insertar);
            pstm.setString(1, cedula);
            pstm.setInt(2, numTurno);
            pstm.setString(3, tipoServicio);
            pstm.setString(4, prioridad);
            pstm.setInt(5, puntaje);
            
            System.out.println("lib.ConsultaTurno.crearTurno() -- 2");
            
            pstm.executeUpdate();
            
            System.out.println("lib.ConsultaTurno.crearTurno() -- 3");
            
            if (tipoServicio.equalsIgnoreCase("2")) {
                turno += "A" + numTurno;
            } else {
                turno += "C" + numTurno;
            }

            pstm.close();
            return turno;

        } catch (SQLException ex) {
            System.out.println(" ** Error ** ");
            System.out.println(ex);
            Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pstm != null) {
                    pstm.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return "";
    }
    
}