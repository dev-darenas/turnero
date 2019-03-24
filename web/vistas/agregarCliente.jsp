<%-- 
    Document   : agregarCliente
    Created on : 14/03/2019, 03:17:10 PM
    Author     : usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="lib.Conexion" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Agregar Cliente</h1>
        <hr>
        <form method="post" action="">
            ID:
            <input type="text" name="txt_id">
            NOMBRE:
            <input type="text" name="txt_nombre">
            PRODUCTO: 
            <input type="text" name="txt_producto">
            CIUDAD:
            <input type="text" name="txt_ciudad">
            <br>
            <hr>
            <a href="RegistroClientes.jsp">Regresar</a>

            <input type="submit" name="accion" value="Registrar">

        </form>
        <%
            String accion="";
            if(request.getParameter("accion")!=null){
             accion = request.getParameter("accion");
            }
            int id=0;
            if (request.getParameter("txt_id") != null) {
                 id = Integer.parseInt(request.getParameter("txt_id"));
            }
            if (accion.equals("Registrar")) {

                String nombre = request.getParameter("txt_nombre");
                String producto = request.getParameter("txt_producto");
                String ciudad = request.getParameter("txt_ciudad");
                Conexion con = new Conexion();
                con.Conectar();
                con.ingresarCLiente(id, nombre, producto, ciudad);
                con.cierraConexion();
            }
           
           
        %>


    </body>
</html>
