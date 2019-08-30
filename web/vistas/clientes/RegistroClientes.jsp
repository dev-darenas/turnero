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
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <%@include file="/componentes/navbar.jsp" %>
        <%
            ConsultaClientes con1 = new ConsultaClientes();
            ResultSet rs = con1.realizarConsulta("select * from clientes");
        %>

        <main>
        <div class="container">
            <h1> 
                <a class="btn btn-primary" href="/turnero/vistas/clientes/agregarCliente.jsp">
                    <i class="fas fa-plus"></i>
                </a>
                Clientes
            </h1>
            <hr>
            <table class="table table-bordered table-hover table-sm">
                <thead class="">
                    <tr>
                        <th>CC</th>
                        <th>NOMBRE</th>
                        <th>APELLIDO</th>
                        <th>EMAIL</th>
                        <th>ESTADO</th>
                        <th>ACCIÓN</th>
                    </tr>
                </thead>
                <% while (rs.next()) {%>
                <tr>
                    <td><%=rs.getInt("Cc")%></td>
                    <td><%=rs.getString("Nombre")%></td>
                    <td><%=rs.getString("Apellido")%></td>
                    <td><%=rs.getString("Email")%></td>
                    <td>
                        <% if(rs.getInt("estado") == 1 ){ %>
                            Activado
                        <% }else{ %>
                            Desactivado
                        <% } %>
                    </td>
                    <td>
                        <a href="editarCliente.jsp?id=<%=rs.getInt("id")%>&accion=EDITAR&dd=<%=rs.getInt("id")%>" class="btn btn-primary btn-sm">
                            <i class="fas fa-pencil-alt"></i>
                        </a>
                    </td>
                </tr>
                <%}
                con1.cierraConexion();%>
            </table>
        </div>
        </main>
     <%@include file="/source/javascript/javalib.jsp" %>
</body>
</html>
