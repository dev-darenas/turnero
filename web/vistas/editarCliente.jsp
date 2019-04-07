<%-- 
    Document   : editarCliente
    Created on : 14/03/2019, 04:35:44 PM
    Author     : usuario
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="lib.ConsultaClientes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% String titulo = request.getParameter("accion");%>
        <title><%=titulo%></title>
    </head>
    <body>

        <h1><%=titulo%> CLIENTE</h1>
        <%
            int id = Integer.parseInt(request.getParameter("id"));
            ConsultaClientes con = new ConsultaClientes();
           
            ResultSet rs = con.realizarConsulta("select * from clientes where Cc=" + id);
            String est = request.getParameter("estado");
        %>
        <form method="post" action="">
            <table width="100%" border="1">
                <tr>
                    <th>CC</th>
                    <th>NOMBRE</th>
                    <th>APELLIDO</th>
                    <th>EMAIL</th>
                    <th>CELULAR</th>
                    <th>PAIS</th>
                    <th>DEPARTAMENTO</th>
                    <th>CIUDAD</th>
                    <th>DIRECCIÓN</th>
                    <th>ID</th>
                    <th>ESTADO</th>
                    <th>N_EMAIL</th>
                    <th>N_SMS</th>
                    
                </tr>
                <% while (rs.next()) {%>
                <tr>
                    <td><a><%=id%></a></td>
                    <td><input <%= est%> type="text" name="nombre"  value="<%=rs.getString("Nombre")%>" ></td>
                <h4></h4>
                <td><input <%= est%> type="text" name="apellido" value= "<%=rs.getString("Apellido")%>"></td>
                <td><input <%= est%> type="email" name="email" value= "<%=rs.getString("Email")%>"></td>
                
                <td><input <%= est%> type="text" name="cel" value= "<%=rs.getString("Cel")%>"></td>
                <td><input <%= est%> type="text" name="pais" value= "<%=rs.getString("Pais")%>"></td>
                <td><input <%= est%> type="text" name="departamento" value= "<%=rs.getString("Departamento")%>"></td>
                <td><input <%= est%> type="text" name="ciudad" value= "<%=rs.getString("Ciudad")%>"></td>
                <td><input <%= est%> type="text" name="direccion" value= "<%=rs.getString("Direccion")%>"></td>
                <td><input <%= est%> type="text" name="id" value= "<%=rs.getString("Id")%>"></td>
                <td><input <%= est%> type="text" name="estado" value= "<%=rs.getString("Estado")%>"></td>
                <td><input <%= est%> type="text" name="notificar_e" value= "<%=rs.getString("Notificar_email")%>"></td>
                <td><input <%= est%> type="text" name="notificar_s" value= "<%=rs.getString("Notificar_sms")%>"></td>

                </tr>

                <% }
                    %> 


            </table>
                    <br><br>
            <input type="submit" name="Accion" value=<%=titulo%>>
        </form>
        <a href="RegistroClientes.jsp">Atras</a>
        <br>

        <%
           
            String accion = "";
            if (request.getParameter("Accion") != null) {
                accion = request.getParameter("accion");
            }
            if (accion.equals("EDITAR")) {
                int ide = Integer.parseInt(request.getParameter("id"));
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String email = request.getParameter("email");
                
                String cel = request.getParameter("cel");
                String pais = request.getParameter("pais");
                String departamento = request.getParameter("departamento");
                String ciudad = request.getParameter("ciudad");
                String direccion = request.getParameter("direccion");
                String idd = request.getParameter("id");
                String estado = request.getParameter("estado");
                String notificar_e = request.getParameter("notificar_e");
                String notificar_s = request.getParameter("notificar_s");

                out.print("Se actualizó--" + con.actualizarCliente(ide, nombre, apellido, email, cel, pais, departamento, ciudad, direccion, idd, estado, notificar_e, notificar_s));
                response.sendRedirect("RegistroClientes.jsp");
            } else if (accion.equals("ELIMINAR")) {
                int ide = Integer.parseInt(request.getParameter("id"));

                out.print("Se ELIMINÓ--" + con.eliminarCliente(ide));
                response.sendRedirect("RegistroClientes.jsp");

            }
            con.cierraConexion();

        %>

    </body>
</html>
