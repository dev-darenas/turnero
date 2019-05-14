<%-- 
    Document   : reporte
    Created on : 13/05/2019, 11:23:55 PM
    Author     : jhoan
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
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
        <%ConsultaReporte cr = new ConsultaReporte();%>
        <form action="" method="Post"> 
            <div class="container row" style="width: 70%; position:relative;top:5%;left:2%">

                <div class="col-md-4">
                    <label>Fecha Inicio</label> <input name="fechaIni" type="date" class="" id=""/>  
                </div> 
                <div class="col-md-4">
                    <label>Fecha Fin</label> <input name="fechaFin" type="date" class="" id=""/>  
                </div>
                <div class="col-md-4">
                    <input type="submit" value="Generar" class="" id=""/> 
                </div>



                <div class="col-md-3">
                    <label>Usuario</label> 
                    <select name="usuario">
                        <option value="Todos">Todos</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                    </select>
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

                <%%>

                <%String fechaIni = request.getParameter("fechaIni");%>
                <%String fechaFin = request.getParameter("fechaFin");%>
                <%String usuario = request.getParameter("usuario");%>
                <%String prioridad = request.getParameter("prioridad");%>
                <%String titular = request.getParameter("titular");%>
                <%String particular = request.getParameter("particular");%>

                <table name="tabla"class="table table-bordered table-hover table-sm">
                    <tr>
                        <th>Fecha</th>
                        <th>Cantidad</th>
                        <th>Promedio Llamado</th>
                        <th>Promedio Atendido</th>
                    </tr>

                    <tr>
                        <th><%= fechaIni%></th>
                        <th><%= prioridad%></th>
                        <th><%= fechaIni%></th>
                        <th><%= cr.generarReporte(fechaIni, fechaFin, usuario, prioridad, titular, particular)%></th>
                    </tr>

                </table>
                
                <label>Total:</label> <label name="total" >#</label>

            </div>

            <div class="" style="width: 20%; position:absolute;top:5%;left:105%">
                graficos si me animo
                exportar como excel si no muero
            </div>
        </form>
    </body>
</html>
