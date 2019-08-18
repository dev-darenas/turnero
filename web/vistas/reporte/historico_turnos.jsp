<%-- 
    Document   : historico_turnos
    Created on : 17/05/2019, 10:17:50 AM
    Author     : Dahian
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="lib.ConsultaTurno"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historico</title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <%@include file="/componentes/navbar.jsp" %>
        <%
            ConsultaTurno con = new ConsultaTurno();
            ResultSet turnos = con.obtenerTodosLosTurnos();
        %>
        
        <main>
            <div class="container">
                <table class="table table-bordered table-hover table-sm">
                    <thead class="thead-dark">
                        <tr>
                            <td> COD</td>
                            <td> Cliente</td>
                            <td> Tiempo Espera (min) </td>
                            <td> Tiempo Atencion (min) </td>
                            <td> Empleado </td>
                        </tr>   
                    </thead>
                    <tbody>
                        <% while (turnos.next()) { %>
                            <tr>
                                <th><%= turnos.getString("P") %> <%= turnos.getString("TS") %> <%= turnos.getString("num_turno") %> </th>
                                <th> <%= turnos.getString("nombre") %> <%= turnos.getString("apellido") %> </th>
                                <th> <%= turnos.getString("TiempoEspera") %> </th>
                                <th> <%= turnos.getString("TiempoAencion") %> </th>
                                <th> <%= turnos.getString("nombre_em") %> <%= turnos.getString("apellido_em") %> </th>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </main>
    </body>
</html>
