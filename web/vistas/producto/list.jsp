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
        <title>Producto</title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <%! ConsultasProducto con = new ConsultasProducto();%>
        <%  ResultSet productos = con.obtenerProducto();%>
        
        <%@include file="/componentes/navbar.jsp" %>
        <div class="container">
            <h1> 
                <a class="btn btn-primary" href="/turnero/vistas/producto/crear.jsp">
                    <i class="fas fa-plus"></i>
                </a>
                Producto
            </h1>
            <hr>
              <table class="table table-bordered table-hover table-sm" >   
            
             <thead class="thead-dark">
                    <tr>
                        
                        <td> Nombre</td>
                        <td> Estado</td>
                        <td> descripcion </td>
                        
                        <td colspan="2" > <b> Editar </b> </td>
                    </tr>    
                </thead>
            <% while (productos.next()) { %>
            
                <tr>
                    
                    <th>
                        <%= productos.getString(2) %>
                    </th>
                    
                    <th> 
                    <% if (productos.getString(3).equals("1") ){ %>
                        Activo
                    <% }else{ %>
                        Inactivo
                    <% } %>
                    </th>
                
                    <th>
                        <%= productos.getString(4) %>
                    </th>
                    
                    <th>
                   <a href="/turnero/vistas/producto/editar.jsp?id_producto=<%= productos.getInt("id")%>" class="btn btn-primary btn-sm">
                       <i class="fas fa-pencil-alt"></i>
                   </a>
                    </th>
                </tr>
            <% } %>
            <% productos.close(); %>
        
        </table>
        
        </div>
        
        <%@include file="/source/javascript/javalib.jsp" %>
    </body>
     <% if(request.getParameter("succes") != null){ %>
        <script>
            $( document ).ready(function() {
                swal("Turnero", "Producto creado!!", "success");
            });
        </script>
    <% } %>
</html>
