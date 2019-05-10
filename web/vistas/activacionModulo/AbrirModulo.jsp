<%-- 
    Document   : AbrirModulo
    Created on : 18/04/2019, 05:12:15 PM
    Author     : Lider Buitrago
--%>

<%@page import="lib.ConexionAbrirModulo"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Asignacion de Modulo</title>
    </head>
    <body>
        
         <%@include file="/componentes/navbar.jsp" %> 
        
        <% 
            ResultSet resultado;
            ConexionAbrirModulo conexion = new ConexionAbrirModulo();
            resultado = conexion.ModuloDisponibles();
        %>

        <h1>Asignacion de Modulo</h1>
        
        <form action="ModeloTurno.jsp" method="post">
            <label> <b> Ingresar Codigo </b> </label>
            <br>
            <input type ="text" name= "id_usuario">
            <br><br>

            <label> <b> Seleccione el modulo abrir </b> </label>
            <br>

            <select name="id_modulo">
               <% while (resultado.next())
                { 
               %>
                <option value="<%= resultado.getString("id")%>" > <%= resultado.getString("nombre")%>  </option>
                <%
                  }
                   conexion.desconectar();
                %>
            </select>

            <br> <br>
            <input type ="submit" value="Abrir modulo">
        </form>
        
        <a href="Inicio.jsp"> Volver </a>
    </body>
</html>




