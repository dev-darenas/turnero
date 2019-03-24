<%-- 
    Document   : editarCliente
    Created on : 14/03/2019, 04:35:44 PM
    Author     : usuario
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="lib.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>eDITAR CLIENTES</title>
    </head>
    <body>
        <h1>EDITAR CLIENTE</h1>
        <%
        int id=Integer.parseInt(request.getParameter("id"));
        Conexion con=new Conexion();
        con.Conectar();
         ResultSet rs = con.realizarConsulta("select * from clientes where id="+id);
        %>
        <form method="post" action="">
        <table>
            <tr>
                <th>ID </th>
                <th>NOMBRE </th>
                <th>PRODUCTO  </th>
                <th> CIUDAD</th>
            </tr>
            <% while(rs.next()){ %>
            <tr>
                <td><input type="text" name="id" value= <%=id%> ></td>
                <td><input type="text" name="nombre" value= <%=rs.getString("nombre")%>></td>
                <td><input type="text" name="producto" value= <%=rs.getString("producto")%>></td>
                <td><input type="text" name="ciudad" value= <%=rs.getString("ciudad")%>></td>
                
            </tr>
            
              <% } con.cierraConexion(); %> 
             
        </table>
              <input type="submit" name="accion" value="Actualizar">
              </form>
                <a href="RegistroClientes.jsp">Atras</a>
              <br>
              
              <%
              con.Conectar();
              String accion="";
            if(request.getParameter("accion")!=null){
             accion = request.getParameter("accion");
            }
             if(accion.equals("Actualizar")){
              int ide=Integer.parseInt(request.getParameter("id"));
              String nombre=request.getParameter("nombre");
              String producto=request.getParameter("producto");
              String ciudad=request.getParameter("ciudad");
              
              out.print(""+ide+"-");
              out.print(""+nombre+"-");
              out.print(""+producto+"-");
              out.print(""+ciudad+"-");
              
              
             
              out.print("Se actualizó--" + con.actualizarCliente(ide, nombre, producto, ciudad));
              response.sendRedirect("RegistroClientes.jsp");
              }
              con.cierraConexion();
              
              %>
              
    </body>
</html>
