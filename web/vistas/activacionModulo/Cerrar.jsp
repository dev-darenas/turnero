<%-- 
    Document   : newjsp
    Created on : 27/04/2019, 06:55:04 PM
    Author     : Lider Buitrago
--%>

<%@page import="lib.ConexionAbrirModulo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cerrar Sesion</title>
    </head>
    <body>
        <h1>Cerrar Sesion</h1>
    </body>
</html>
        <%
  
            String id_modulo = request.getParameter("modulo");
            int codigo = Integer.parseInt(request.getParameter("codigo"));
            
           ConexionAbrirModulo conexion = new ConexionAbrirModulo();
         
            conexion.actualizarEstado2(id_modulo);
            conexion.actualizarHora(codigo);
            
            conexion.desconectar();
           response.sendRedirect("../../componentes/navbar.jsp");  

            


        %>