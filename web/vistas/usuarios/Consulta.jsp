
  <%@ page import= "lib.ConexionUsuario" %>
  <%@ page import= "java.sql.*"%>
  <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Usuarios </title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <% 
            ResultSet resultado;
            ConexionUsuario conexion = new ConexionUsuario();
            resultado = conexion.consultarTabla();
        %>
        <%@include file="/componentes/navbar.jsp" %>
        <div class="container">
            <h1> 
                <a class="btn btn-primary" href="/turnero/vistas/usuarios/Registro.jsp">
                    <i class="fas fa-plus"></i>
                </a>
                Usuarios
            </h1>
            <hr>
            <table class="table table-bordered table-hover table-sm">
                <thead class="thead-dark">
                    <tr>
                        <td> Nombre </td>
                        <td> Apellido </td>
                        <td> Cedula </td>
                        <td> Telefono </td>
                        <td> Cargo </td>
                        <td> Email </td>
                        <td> Estado </td>
                        <td colspan="2" > <b> Acciones </b> </td>
                    </tr>   
                </thead>
            <% 
                while (resultado.next())
            {%>

            <tr>
                <td> <%= resultado.getString("nombre")%> </td>
                <td> <%= resultado.getString("apellido")%> </td>
                <td> <%= resultado.getString("cedula")%> </td>
                <td> <%= resultado.getString("telefono")%> </td>
                <td> <%= resultado.getString("rol_id")%> </td>
                <td> <%= resultado.getString("email")%> </td>
                <td> 
                    <% if (resultado.getString("estado").equals("1") ){ %>
                        Activo
                    <% }else{ %>
                        Inactivo
                    <% } %>
                </td>
                <td> 
                    <a href="Editar.jsp?cedula=<%= resultado.getString("cedula")%>" class="btn btn-primary btn-sm" >
                        <i class="fas fa-pencil-alt"></i>
                    </a> 
                </td>
            </tr>

            <%}
                conexion.desconectar();
            %>
            </table>
        </div>
        <%@include file="/source/javascript/javalib.jsp" %>
    </body>
</html>
