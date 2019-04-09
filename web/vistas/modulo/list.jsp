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
    </head>
    <body>
        
        
        
        <%! ConsultasModulo con = new ConsultasModulo();%>
        <%  ResultSet modulos = con.obtenerModulos(); %>
        
        
                 <table border="1" >
            <tr>
                <th><a href="crear.jsp" > Registrar Modulo </a></th>
                 
            </tr>

            <% while (modulos.next()) { %>
            
                <tr bgcolor="skyblue">
                    <th><%= modulos.getInt(1) %></th>
                    <th><%= modulos.getString(2) %></th>
                    <th><%= modulos.getString(3) %></th>
                </tr>
            <% } %>
            <% modulos.close(); %>
        </table>
        <a href="../../index.jsp">Regresar</a>
        
        
    </body>
</html>
