<%-- 
    Document   : eliminarProducto
    Created on : 29/04/2019, 09:15:02 PM
    Author     : usuario
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="lib.ConsultaClientes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminando Producto</title>
    </head>
    <body>
        <h1>Eliminando Producto</h1>
        
        <%
            if(request.getParameter("id")!=null){
                  int id=Integer.parseInt(request.getParameter("id"));
                  int idc=Integer.parseInt(request.getParameter("idd"));
                  String acci=(request.getParameter("acci"));
         ConsultaClientes con = new ConsultaClientes();
         con.eliminarProducto(id);
         response.sendRedirect("editarCliente.jsp?id="+idc+"&accion="+acci);
         
            }
      
         
        %>
    </body>
</html>
