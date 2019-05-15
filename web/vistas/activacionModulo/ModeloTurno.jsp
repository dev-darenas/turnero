<%-- 
    Document   : ModeloTurno
    Created on : 18/04/2019, 06:52:54 PM
    Author     : Lider Buitrago
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="lib.ConexionAbrirModulo"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Llamar turnos</title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <%@include file="/componentes/navbar.jsp" %>
        <div class="container">

            <h1> Modulo: <%= request.getParameter("nombre") %></h1>
            <br>

            <div class="row">
                <div class="offset-md-1 col-md-10 card">
                    <% if(request.getParameter("id_turno") != null && !request.getParameter("id_turno").equals("0") ){ %>
                        <%
                            ConexionAbrirModulo conexion = new ConexionAbrirModulo();
                            ResultSet turno_info = conexion.obtenerTurno(request.getParameter("id_turno"));
                            turno_info.next();
                            String cod_turno = "";

                            if(turno_info.getString("prioridad") != null){
                             cod_turno = "P";
                            }

                            if(turno_info.getString("tipo_servicio").equalsIgnoreCase("2")){
                                cod_turno += "A";
                            }else{
                                cod_turno += "C";
                            }

                            cod_turno += turno_info.getString("num_turno") ;
                        %>

                        <div class="card-header">
                          Turno: <%= cod_turno %>
                        </div>
                        
                        <div class="card-body">
                            <% 
                                ResultSet cliente = conexion.obtenerCliente(turno_info.getString("id_cliente"));
                                cliente.next();
                            %>
                            
                            Nombre: <%= cliente.getString("nombre") %> <br>
                            Apellido: <%= cliente.getString("apellido") %>  <br>
                            CC: <%= cliente.getString("cc") %>  <br>
                            Email: <%= cliente.getString("email") %>  <br>
                            Estado: 
                            
                            <% if(cliente.getInt("estado") == 1 ){ %>
                                <strong>Activo</strong>
                            <% }else{ %>
                                <strong>Desactivado</strong>
                            <% } %>
                            <br>
                            <br>
                            <h4>Productos</h4>
                            <hr>
                            
                            <%
                                ResultSet productos = conexion.obtenerProductos(turno_info.getString("id_cliente"));
                            %>
                            
                            <ul class="list-group">
                                <% while(productos.next()){ %>
                                    <li class="list-group-item"><%= productos.getString("nombre") %> - <%= productos.getString("descripcion") %> </li>
                                <% }%>
                            </ul>
                        </div>
                    <% } else { %>
                        <div class="card-body">
                            <div class="alert alert-warning" role="alert">
                                Ningun turno Seleccionado
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
            <hr>  
            <div class="row">  
                <form action = "/turnero/llamarTurno" method = "post" class="col-md-3">
                    <input name="nombre" type="hidden" value="<%= request.getParameter("nombre") %>">
                    <input name="codigo" type="hidden" value="<%= request.getParameter("codigo") %>">
                    <input type ="submit" value ="Llamar turno" class="btn btn-primary">
                </form>

                <form action = "/turnero/CancelarTurno" method = "post" class="col-md-3">
                    <input name="nombre" type="hidden" value="<%= request.getParameter("nombre") %>">
                    <input name="codigo" type="hidden" value="<%= request.getParameter("codigo") %>">
                    <input type ="submit" value ="Cancelar Turno" class="btn btn-warning">
                </form>

                <form action = "Cerrar.jsp" method = "post" class="col-md-3">       
                    <input type ="submit" value ="Cerrar Sesion" class="btn btn-danger">
                </form> 
            </div>
        </div>
 
    </body>
    <%@include file="/source/javascript/javalib.jsp" %>
</html>
