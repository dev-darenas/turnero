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

            //listar los datos

        %>

        <div class="container">
            <div class="container-contact100">
                <div class="wrap-contact100">

                    <span class="contact100-form-title">
                        REGISTRO DE CLIENTES
                    </span>

                    <div class="wrap-input100 input100-select bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                        <a href="agregarCliente.jsp">
                            <input type="button" class="input100" id="" value="Agregar Cliente" />  
                        </a>
                    </div>

                    <br><br>
                    <center>
                        <div class="container">
                            <table class="table table-bordered table-hover table-sm">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>CC</th>
                                        <th>NOMBRE</th>
                                        <th>APELLIDO</th>
                                        <th>EMAIL</th>
                                        <th>ESTADO</th>
                                        <th>N_EMAIL</th>
                                        <th>N_SMS</th>
                                        <th>ACCIÓN</th>
                                    </tr>
                                </thead>
                                <% while (rs.next()) {%>
                                <tr>
                                    <td><%=rs.getInt("Cc")%></td>
                                    <td><%=rs.getString("Nombre")%></td>
                                    <td><%=rs.getString("Apellido")%></td>
                                    <td><%=rs.getString("Email")%></td>
                                    <td><%=rs.getString("Estado")%></td>
                                    <td><%=rs.getString("Notificar_email")%></td>
                                    <td><%=rs.getString("Notificar_sms")%></td>

                                    <td> <a href="editarCliente.jsp?id=<%=rs.getInt("Cc")%>&accion=EDITAR&dd=<%=rs.getInt("Id")%>">Editar</a>  <a href="editarCliente.jsp?id=<%=rs.getInt("Cc")%>&accion=ELIMINAR&estado=readonly">Eliminar</a> </td>

                                </tr>
                                <%}
                                    con1.cierraConexion();%>
                            </table>
                        </div>

                    </center>
                    <%@include file="/source/javascript/javalib.jsp" %>
                </div>
            </div>
        </div>
    </body>
</html>
