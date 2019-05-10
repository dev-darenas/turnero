<%-- 
    Document   : Registro clientes
    Created on : 10/03/2019, 12:45:20 PM
    Author     : martinez cuellar michael martinez
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="lib.ConsultaClientes" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro Clientes</title>
    </head>
    <body>

        <%
            ConsultaClientes con1 = new ConsultaClientes();

            
            ResultSet rs = con1.realizarConsulta("select * from clientes");

        //listar los datos

        %>



 
        <h1>REGISTRO DE CLIENTES</h1>
        
        <a href="agregarCliente.jsp">Agregar Cliente</a>
        <br><br><br>
        <center>
        <table width="100%" border="1">
            <tr>
                <th>CC</th>
                <th>NOMBRE</th>
                <th>APELLIDO</th>
                <th>EMAIL</th>
                <th>CELULAR</th>
                <th>PAIS</th>
                <th>DEPARTAMENTO</th>
                <th>CIUDAD</th>
                <th>DIRECCIÓN</th>
                <th>ID</th>
                <th>ESTADO</th>
                <th>N_EMAIL</th>
                <th>N_SMS</th>
                <th>ACCIÓN</th>
            </tr>
            <% while (rs.next()) {%>
            <tr>
                <td><%=rs.getInt("Cc")%></td>
                <td><%=rs.getString("Nombre")%></td>
                <td><%=rs.getString("Apellido")%></td>
                <td><%=rs.getString("Email")%></td>
                
                <td><%=rs.getString("Cel")%></td>
                <td><%=rs.getString("Pais")%></td>
                <td><%=rs.getString("Departamento")%></td>
                <td><%=rs.getString("Ciudad")%></td>
                <td><%=rs.getString("Direccion")%></td>
                <td><%=rs.getString("Id")%></td>
                <td><%=rs.getString("Estado")%></td>
                <td><%=rs.getString("Notificar_email")%></td>
                <td><%=rs.getString("Notificar_sms")%></td>
       
                <td> <a href="editarCliente.jsp?id=<%=rs.getInt("Cc")%>&accion=EDITAR&dd=<%=rs.getInt("Id") %>">Editar</a>  <a href="editarCliente.jsp?id=<%=rs.getInt("Cc")%>&accion=ELIMINAR&estado=readonly">Eliminar</a> </td>

            </tr>
            <%} con1.cierraConexion(); %>
        </table>
        
        </center>
    </body>
</html>
