<%-- 
    Document   : list
    Created on : 4/04/2019, 07:33:15 PM
    Author     : Administrador
--%>

<%@page import="java.sql.*"%>
<%@page import="lib.ConsultasModulo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modulos</title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        
        
        
        <%! ConsultasModulo con = new ConsultasModulo();%>
        <%  ResultSet modulos = con.obtenerModulos(); %>
        
        <%@include file="/componentes/navbar.jsp" %>
        <div class="container">
            <h1> 
                <a class="btn btn-primary" href="/turnero6/vistas/modulo/crear.jsp">
                    <i class="fas fa-plus"></i>
                </a>
                Modulo
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
            <% while (modulos.next()) { %>
            
                <tr>
                    
                    <th>
                        <%= modulos.getString(2) %>
                    </th>
                    
                    <th> 
                    <% if (modulos.getString(3).equals("1") ){ %>
                        Activo
                    <% }else{ %>
                        Inactivo
                    <% } %>
                    </th>
                
                    <th>
                        <%= modulos.getString(4) %>
                    </th>
                    
                    <th>
                   <a href="editar.jsp?cod_modulo=<%= modulos.getInt("cod_modulo")%>" class="btn btn-primary btn-sm">
                       <i class="fas fa-pencil-alt"></i>
                   </a>
                    </th>
    
                </tr>
                
               
            <% } %>
            <% modulos.close(); %>
        </table>
        
        
        
        </div>
        <%@include file="/source/javascript/javalib.jsp" %>
    </body>
     <% if(request.getParameter("succes") != null){ %>
        <script>
            $( document ).ready(function() {
                swal("Turnero", "Modulo creado!!", "success");
            });
        </script>
    <% } %>
</html>