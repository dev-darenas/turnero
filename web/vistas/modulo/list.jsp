<%-- 
    Document   : list
    Created on : 4/04/2019, 07:33:15 PM
    Author     : Administrador
--%>

<%@page import="java.sql.*"%>
<%@page import="lib.ConsultasModulo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modulos</title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        
        
        
        <%! ConsultasModulo con = new ConsultasModulo();%>
        <%  ResultSet modulos = con.obtenerModulos(); %>
        
        
                 <table border="1" >
            

            <% while (modulos.next()) { %>
            
                <tr bgcolor="skyblue">
                    <th><%= modulos.getInt(1) %></th>
                    <th><%= modulos.getString(2) %></th>
                    <th><%= modulos.getString(3) %></th>
                </tr>
                <right><th><a href="editar.jsp?cod_modulo=<%= modulos.getInt(1)%>">EDITAR MODULO</a></th></right>
    
            <% } %>
            <% modulos.close(); %>
        </table>
        
        <a href="crear.jsp" > Registrar Modulo </a>
        <br> <br>
        <a href="../../dashboard.jsp">Regresar</a>
        
        
    </body>
</html>
