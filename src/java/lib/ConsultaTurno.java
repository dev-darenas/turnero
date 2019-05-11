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

    String turno;

    public String crearTurno(String cedula, String celular, String correo, String tipoServicio, int prioridad, int notwhatsapp, int notemail, int notsms) {

        int numTurno = 0;

        PreparedStatement pstm = null;
        ResultSet rs = null;

        try {
            String consulta = "SELECT * FROM Cliente WHERE cedula = ?";
            pstm = getConexion().prepareCall(consulta);
            pstm.setString(1, cedula);

            rs = pstm.executeQuery();

            if (rs.absolute(1)) {
                prioridad = prioridad + 1;
            } else {

                String insertar = "Insert into Cliente (cedula,email,celular) values (?,?,?)";
                pstm = getConexion().prepareCall(insertar);
                pstm.setString(1, cedula);
                pstm.setString(2, correo);
                pstm.setString(3, celular);
                if (rs.rowInserted()) {
                    pstm.close();
                } else {
                    pstm.close();
                }
            }

            String consulta2 = "Select * from Turno where tipo_servicio = ? order by id desc";
            pstm = getConexion().prepareCall(consulta2);
            pstm.setString(1, tipoServicio);

            rs = pstm.executeQuery();

            if (rs.absolute(1)) {
                numTurno = rs.getInt("num_turno") + 1;

                String insertar = "Insert into Turno (id_cliente,num_turno,tipo_servicio,prioridad,id_historico_modulo,fecha_creacion,fecha_llamado,fecha_terminado,estado) values ((Select id from Cliente where cedula = ?), ? , ? , ? ,0, NOW() , null , null ,1)";
                pstm = getConexion().prepareCall(insertar);
                pstm.setString(1, cedula);
                pstm.setInt(2, numTurno);
                pstm.setString(3, tipoServicio);
                pstm.setInt(4, prioridad);

                if (tipoServicio.equalsIgnoreCase("Caja")) {
                    turno = "C" + numTurno;
                } else {
                    turno = "A" + numTurno;
                }

                if (rs.rowInserted()) {
                    pstm.close();
                    return turno;
                } else {
                    pstm.close();
                    return "turno no generado";
                }

            }

        } catch (SQLException ex) {
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

        return "turno no generado";
    }

    // se corre este archivo para probar la conexion a la bd
    public static void main(String[] args) {
        Consultas c = new Consultas();
        System.out.println("lib.Consultas.main()");
        c.autenticacion("darenas@gmail.com", "123456789");
    }
}
