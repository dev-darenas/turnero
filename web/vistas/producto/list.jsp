<%-- 
    Document   : list
    Created on : 4/04/2019, 07:33:15 PM
    Author     : Administrador
--%>

<%@page import="java.sql.*"%>
<%@page import="lib.ConsultasProducto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modulos</title>
    </head>
    <body>
        
        
        
        <%! ConsultasProducto con = new ConsultasProducto();%>
        <%  ResultSet productos = con.ObtenerProductos(); %>
        
        
                 <table border="1" >
            

            <% while (productos.next()) { %>
            
                <tr bgcolor="skyblue">
                    <th><%= productos.getInt(1) %></th>
                    <th><%= productos.getString(2) %></th>
                    <th><%= productos.getString(3) %></th>
                </tr>
                <right><th><a href="editar.jsp?id_producto=<%= productos.getInt(1)%>">EDITAR PRODUCTO</a></th></right>
    
            <% } %>
            <% productos.close(); %>
        </table>
        
        <a href="crear.jsp" > Registrar Producto </a>
        <br> <br>
        <a href="../../dashboard.jsp">Regresar</a>
        
        
    </body>
</html>