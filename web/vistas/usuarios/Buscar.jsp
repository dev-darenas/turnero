<%-- 
    Document   : Buscar
    Created on : 24/03/2019, 10:53:21 PM
    Author     : Lider Buitrago
--%>
  <%@ page import= "lib.ConexionUsuario" %>
  <%@ page import= "java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consulta Usuarios</title>
    </head>
    <body>
                 <% 
        
        ResultSet resultado;
        String cedula = request.getParameter("cedula");
        ConexionUsuario conexion = new ConexionUsuario();
        
        resultado = conexion.buscar(cedula);
        
        %>
        

        
                
        <h1> Consulta Usuarios </h1>
        
             <table border ="1" cellpadding="5" cellspacing="2">
            
            <tr bgcolor ="FF8E8E">
                
                <td align ="center"> <b> Codigo </b> </td>
                <td align ="center"> <b> Nombre </b> </td>
                <td align ="center"> <b> Apellido </b> </td>
                <td align ="center"> <b> Cedula </b> </td>
                <td align ="center"> <b> Telefono </b> </td>
                <td align ="center"> <b> Cargo </b> </td>
                <td align ="center"> <b> Email </b> </td>
                <td align ="center"> <b> Estado </b> </td>
                <td colspan="2" align ="center"> <b> Acciones </b> </td>
                
            </tr>   
        
        <% 
            while (resultado.next())
        {%>
        
        <tr>
            <td> <%= resultado.getInt("codigo")%> </td>
            <td> <%= resultado.getString("nombre")%> </td>
            <td> <%= resultado.getString("apellido")%> </td>
            <td> <%= resultado.getString("cedula")%> </td>
            <td> <%= resultado.getString("telefono")%> </td>
            <td> <%= resultado.getString("cargo")%> </td>
            <td> <%= resultado.getString("email")%> </td>
            <td> <%= resultado.getString("estado")%> </td>
            <td> <a href="Editar.jsp?cedula=<%= resultado.getString("cedula")%>"> Editar </a> </td>
        </tr>
        
        <%}
        conexion.desconectar();
        %>
        
             </table> <br> <br>
        
        <a href="Consulta.jsp"> Volver </a>
        
        
    </body>
</html>
        
       
