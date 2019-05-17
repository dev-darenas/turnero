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
        <span class="contact100-form-title">
            Eliminando Producto
        </span>

        <%
            if (request.getParameter("id_producto") != null) {
                int id = Integer.parseInt(request.getParameter("id_producto"));
                int cedula = Integer.parseInt(request.getParameter("cedula"));
                int idd = Integer.parseInt(request.getParameter("idd"));
                String acci = (request.getParameter("acci"));

                out.print("Producto id: " + id + "   cedula=" + cedula + "  ide");
                ConsultaClientes con = new ConsultaClientes();
                con.eliminarProducto(id);

                response.sendRedirect("editarCliente.jsp?id=" + cedula + "&accion=" + acci + "&dd=" + idd);

            }


        %>
    </body>
</html>
