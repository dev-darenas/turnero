/*
SELECT fecha_creacion, Count(num_turno), AVG(Cast(Datediff(minute, fecha_llamado, fecha_atendido) as float)) FROM Turno WHERE fecha_creacion  BETWEEN '2019-05-13' and '2019-05-16' and prioridad = IFNULL(null,prioridad)  and id_historico_modulo = IFNULL ((Select id from Historico_modulo where id_usuario like 'null%'),id_historico_modulo) Group by fecha_creacion
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lib;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jhoan
 */
public class ConsultaReporte extends Conexion {

    public List<List<String>> generarReporte(String fechaIni, String fechaFin, String usuario, String checkPrioridad, String checkTitular, String checkParticular) throws ParseException {

        System.out.println("lib.ConsultaReporte.generaReporte()");

        if (checkParticular == null) {
            checkParticular = "off";
        }
        if (checkPrioridad == null) {
            checkPrioridad = "off";
        }
        if (checkTitular == null) {
            checkTitular = "off";
        }
        if (usuario == null) {
            usuario = null;
        } else if (usuario.equalsIgnoreCase("Todos")) {
            usuario = null;
        }

        if (fechaIni == null) {
            fechaIni = "2019-01-01 00:00:00";
        }
        if (fechaFin == null) {
            fechaFin = "2020-01-01 00:00:00";
        }

        String prioridad = null;

        if (checkPrioridad.equalsIgnoreCase("on") && checkTitular.equalsIgnoreCase("on")) {
            prioridad = "3";
        } else if (checkPrioridad.equalsIgnoreCase("on")) {
            prioridad = "2";
        } else if (checkTitular.equalsIgnoreCase("on")) {
            prioridad = "1";
        } else if (checkParticular.equalsIgnoreCase("on")) {
            prioridad = "0";
        } else {
            prioridad = null;
        }

        List<List<String>> datos = new ArrayList<>();

        for (int i = 0; i <= 3; i++) {
            datos.add(new ArrayList<>());
        }

        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        java.util.Date datei = sdf1.parse(fechaIni);
        java.sql.Date sqlFechaIni = new java.sql.Date(datei.getTime());
        java.util.Date datef = sdf1.parse(fechaFin);
        java.sql.Date sqlFechaFin = new java.sql.Date(datef.getTime());

        PreparedStatement pstm = null;
        ResultSet rs = null;

        try {
            //Select que saca todos los datos en 4 columnas fecha cantidad promediollamada promedioatendido
            String consulta = "SELECT DATE(fecha_creacion), Count(num_turno), Cast(AVG(Cast(Datediff(fecha_llamado, fecha_creacion)as decimal(3,2))) as DateTime)as PromLlamado ,Cast(AVG(Cast(Datediff(fecha_terminado, fecha_llamado)as decimal(3,2))) as DateTime)as PromAtendido FROM Turno WHERE fecha_creacion  BETWEEN ? and ? and prioridad = IFNULL(?,prioridad)  and id_historico_modulo = IFNULL ((Select id from Historico_modulo where id_usuario like '" + usuario + "%'),id_historico_modulo) Group by DATE(fecha_creacion)"; //Cuanto me demore haciendo el sql? no recuerdo... pero fueron muchas
            pstm = getConexion().prepareCall(consulta);
            pstm.setDate(1, sqlFechaIni);
            pstm.setDate(2, sqlFechaFin);
            pstm.setString(3, prioridad);
            rs = pstm.executeQuery();

            int y = 0;
            //Guardar los datos en un arraylist que usa otro arraylist  (El primero trabaja como Columna y el segundo como Fila)

            while (rs.next()) {
                for (int x = 1; x <= 4; x = x + 1) {
                    System.out.println(y + "---" + x + "---" + rs.getString(x));
                    datos.get(y).add(rs.getString(x));                    
                }
                y = y + 1;
            }

            pstm.close();
            return datos;

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

        return null;
    }

    public static void main(String arg[]) throws ParseException {

        ConsultaReporte c = new ConsultaReporte();
        c.generarReporte(null, null, null, null, null, null);
    }

}
