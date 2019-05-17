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
        <%@include file="/componentes/navbar.jsp" %>

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

            if (fechaIni == null || fechaIni.equals("")) {
                fechaIni = "2001-01-01 00:00:00";
            } else {
                fechaIni = fechaIni + " 00:00:00";
            }

            if (fechaFin == null || fechaFin.equals("")) {
                fechaFin = "2050-01-01 23:59:59";
            } else {
                fechaFin = fechaFin + " 23:59:59";
            }

            if (usuario == null || usuario.equalsIgnoreCase("Todos")) {
                usuario = "";
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

            String consulta = "SELECT DATE(fecha_creacion), Count(num_turno) as cantidad, Cast(AVG(Cast(Datediff(fecha_llamado, fecha_creacion)as decimal(3,2))) as Time)as PromLlamado ,Cast(AVG(Cast(Datediff(fecha_terminado, fecha_llamado)as decimal(3,2))) as Time)as PromAtendido FROM turno WHERE fecha_creacion  BETWEEN ? and ? and prioridad = IFNULL(?,prioridad)  and id_historico_modulo = IFNULL ((Select id from historico_modulo where id_usuario  like '" + usuario + "' limit 1),id_historico_modulo) Group by DATE(fecha_creacion)";
            pstm = co.getConexion().prepareCall(consulta);
            pstm.setString(1, sqlFechaIni);
            pstm.setString(2, sqlFechaFin);
            pstm.setString(3, prioridad);
            rs = pstm.executeQuery();

            int y = 0;

        %>


        <div class="container">
            <div class="container-contact100">
                <div class="wrap-contact100">
                    <form action="" class="contact100-form validate-form" method="Post"> 
                        <span class="contact100-form-title">
                            Reporte de Datos
                        </span>
                        <div class="wrap-input100 input100-select bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Fecha de Inicio</span>
                            <input name="fechaIni" type="text" class="input100" id="" placeholder="YYYY-MM-DD" />  

                        </div>

                        <div class="wrap-input100 input100-select bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Fecha de Fin</span>
                            <input name="fechaFin" type="text" class="input100" id="" placeholder="YYYY-MM-DD" /> 
                        </div>

                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Mostrar Solo Prioritarios</span>
                            <div class="pretty p-switch">
                                <input name="prioridad" type="checkbox" class="" id=""/>
                                <div class="state">
                                    <label>Activo?</label>
                                </div>
                            </div>
                        </div>

                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Mostrar Solo Titulares</span>
                            <div class="pretty p-switch">
                                <input name="titular" type="checkbox" class="" id=""/>
                                <div class="state">
                                    <label>Activo?</label>
                                </div>
                            </div>
                        </div>

                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Mostrar Solo Preferenciales</span>
                            <div class="pretty p-switch">
                                <input name="particular" type="checkbox" class="" id=""/>
                                <div class="state">
                                    <label>Activo?</label>
                                </div>
                            </div>
                        </div>

                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Mostrar un Usuario en especifico</span>

                            <input name="usuario" type="text" placeholder="Todos"/>

                        </div>

                        <div class="container-contact100-form-btn">
                            <input type="submit" value="Generar" name="boton" class="contact100-form-btn"/>                         
                        </div>
                        <div class="container" style="margin-top:40px">
                            <table name="tabla"class="table table-bordered table-hover table-sm">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>Fecha</th>
                                        <th>Cantidad</th>
                                        <th>Promedio Llamado</th>
                                        <th>Promedio Atendido</th>
                                    </tr>
                                </thead>
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
                        </div>
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100" Style="font-size:20px">Total de Turnos:</span>
                            <span class="label-input100" Style="font-size:20px"><%out.print(" " + totall);%></span>
                        </div>

                        <% co.cierraConexion();%>
                    </form>
                </div>
            </div>
        </div>

    </body>
</html>