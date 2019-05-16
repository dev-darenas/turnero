<%-- 
    Document   : reporte
    Created on : 13/05/2019, 11:23:55 PM
    Author     : jhoan
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="lib.Conexion"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="lib.ConsultaReporte"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/source/styles/styleslib.jsp" %>
        <title>Reporte</title>
    </head>
    <body>


        <%String fechaIni = request.getParameter("fechaIni");%>
        <%String fechaFin = request.getParameter("fechaFin");%>
        <%String usuario = request.getParameter("usuario");%>
        <%String checkPrioridad = request.getParameter("prioridad");%>
        <%String checkParticular = request.getParameter("particular");%>
        <%String checkTitular = request.getParameter("titular");%>


        <%
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
            } else {
                fechaIni = fechaIni + " 00:00:00";
            }

            if (fechaFin == null) {
                fechaFin = "2020-01-01 23:59:59";
            } else {
                fechaFin = fechaFin + " 23:59:59";
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

            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            java.util.Date datei = sdf1.parse(fechaIni);
            java.sql.Date qlFechaIni = new java.sql.Date(datei.getTime());
            java.util.Date datef = sdf1.parse(fechaFin);
            java.sql.Date qlFechaFin = new java.sql.Date(datef.getTime());

            String sqlFechaIni = qlFechaIni + " 00:00:00";
            String sqlFechaFin = qlFechaFin + " 23:59:59";

            PreparedStatement pstm = null;
            ResultSet rs = null;


            Conexion co = new Conexion();

            String consulta = "SELECT DATE(fecha_creacion), Count(num_turno) as cantidad, Cast(AVG(Cast(Datediff(fecha_llamado, fecha_creacion)as decimal(3,2))) as DateTime)as PromLlamado ,Cast(AVG(Cast(Datediff(fecha_terminado, fecha_llamado)as decimal(3,2))) as DateTime)as PromAtendido FROM Turno WHERE fecha_creacion  BETWEEN ? and ? and prioridad = IFNULL(?,prioridad)  and id_historico_modulo = IFNULL ((Select id from Historico_modulo where id_usuario like '" + usuario + "%'),id_historico_modulo) Group by DATE(fecha_creacion)"; //Cuanto me demore haciendo el sql? no recuerdo... pero fueron muchas
            pstm = co.getConexion().prepareCall(consulta);
            pstm.setString(1, sqlFechaIni);
            pstm.setString(2, sqlFechaFin);
            pstm.setString(3, prioridad);
            rs = pstm.executeQuery();

            int y = 0;

        %>

        <form action="" method="Post"> 
            <div class="container row" style="width: 90%; position:relative;top:5%;left:2%">

                <div class="col-md-4">
                    <label>Fecha Inicio</label> <input name="fechaIni" type="text" class="" id="" placeholder="YYYY-MM-DD" value="2000-01-01"/>  
                </div> 
                <div class="col-md-4">
                    <label>Fecha Fin</label> <input name="fechaFin" type="text" class="" id="" placeholder="YYYY-MM-DD" value="2020-01-01"/>  
                </div>
                <div class="col-md-4">
                    <input type="submit" value="Generar" class="" id=""/> 
                </div>



                <div class="col-md-3">
                    <label>Usuario</label> 
                    <input name="usuario" type="text" value="1"/>
                </div>
                <div class="col-md-3">
                    <label>Prioridad</label> <input name="prioridad" type="checkbox" class="" id=""/>
                </div>
                <div class="col-md-3">
                    <label>Titular</label> <input name="titular" type="checkbox" class="" id=""/> 
                </div>
                <div class="col-md-3">
                    <label>Particular</label> <input name="particular" type="checkbox" class="" id=""/> 
                </div>

                <table name="tabla"class="table table-bordered table-hover table-sm">
                    <tr>
                        <th>Fecha</th>
                        <th>Cantidad</th>
                        <th>Promedio Llamado</th>
                        <th>Promedio Atendido</th>
                    </tr>

                    <%                        int totall = 0;
                        while (rs.next()) {
                            totall = totall + rs.getInt("cantidad");
                            out.print("<tr>");
                            for (int x = 1; x <= 4; x = x + 1) {
                                out.print("<th>" + rs.getString(x) + "</th>");
                            }
                            out.print("</tr>");
                            y = y + 1;
                        }
                    %>


                </table>

                <label>Total:</label> <label name="total" ><%out.print(totall);%></label>

            </div>

        </form>
    </body>
</html>
