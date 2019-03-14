<%-- 
    Document   : Registro clientes
    Created on : 10/03/2019, 12:45:20 PM
    Author     : usuario
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="lib.Conexion" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro Clientes</title>
    </head>
    <body>

        <%
            Conexion con1 = new Conexion();

            con1.Conectar();
            ResultSet rs = con1.realizarConsulta("select * from clientes");

        //listar los datos

        %>




        <h1>REGISTRO DE CLIENTES</h1>

        <table>
            <tr>
                <th>ID</th>
                <th>NOMBRE</th>
                <th>PRODUCTO</th>
                <th>CIUDAD</th>
                <th>ACCIÓN</th>
            </tr>
            <% while (rs.next()) {%>
            <tr>
                <td><%=rs.getInt("id")%></td>
                <td><%=rs.getString("nombre")%></td>
                <td><%=rs.getString("producto")%></td>
                <td><%=rs.getString("ciudad")%></td>
                <td> <a href="#">Editar</a>  <a href="#">Eliminar</a> </td>

            </tr>
            <%} con1.cierraConexion(); %>
        </table>
    </body>
</html>
