<%-- 
    Document   : editarCliente
    Created on : 14/03/2019, 04:35:44 PM
    Author     : MICHAEL MARTINEZ
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="lib.ConsultaClientes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% String titulo = request.getParameter("accion");%>
         <%@include file="/source/styles/styleslib.jsp" %>
        <title><%=titulo%></title>
    </head>
    <body>
          <%@include file="/componentes/navbar.jsp" %>

        <h1><%=titulo%> CLIENTE</h1>
        <%
            int id = Integer.parseInt(request.getParameter("id"));
            ConsultaClientes con = new ConsultaClientes();

            ResultSet rs = con.realizarConsulta("select * from clientes where id=" + id);
            String est = request.getParameter("estado");
        %>
    <center>
        <form method="post" action="">
            <table width="80%" border="1">
                <% while (rs.next()) {%>
                
                <tr>
                    <th>CC</th>
                    <td><a><%=id%></a></td>
                </tr>
                <tr>
                    <th>NOMBRE</th>
                    <td><input <%= est%> type="text" name="nombre"  value="<%=rs.getString("Nombre")%>" ></td>

                </tr>
                <tr>
                    <th>APELLIDO</th>
                    <td><input <%= est%> type="text" name="apellido" value= "<%=rs.getString("Apellido")%>"></td>


                </tr>
                <tr>
                    <th>EMAIL</th>
                    <td><input <%= est%> type="email" name="email" value= "<%=rs.getString("Email")%>"></td>

                </tr>
                <tr>
                    <th>CELULAR</th>
                    <td><input <%= est%> type="text" name="cel" value= "<%=rs.getString("Cel")%>"></td>

                </tr>
                <tr>
                    <th>PAIS</th>
                    <td><input <%= est%> type="text" name="pais" value= "Colombia"></td>


                </tr>
                <tr>
                    <th>DEPARTAMENTO</th>
                    <td><input <%= est%> type="text" name="departamento" value= "Valle"></td>

                </tr>
                <tr>
                    <th>CIUDAD</th>
                    <td><input <%= est%> type="text" name="ciudad" value= "Cali"></td>

                </tr>

                <tr>
                    <th>DIRECCIÓN</th>
                    <td><input <%= est%> type="text" name="direccion" value= "<%=rs.getString("Direccion")%>"></td>

                </tr>
                <tr>
                    <th>ID</th>
                    <td><input <%= est%> type="text" name="iddd" value= "<%=rs.getString("Id")%>"></td>

                </tr>
                <tr>
                    <th>ESTADO</th>
                     <td><input <%= est%> type="text" name="estado" value= "<%=rs.getString("Estado")%>"></td>
                  
                    
                </tr>
                <tr>
                    <th>N_EMAIL</th>
                     <td><input <%= est%> type="text" name="notificar_e" value= "<%=rs.getString("Notificar_email")%>"></td>
                  
                </tr>
                <tr>
                    <th>N_SMS</th>
                    <td><input <%= est%> type="text" name="notificar_s" value= "<%=rs.getString("Notificar_sms")%>"></td>
                </tr>

               
                <br><br>
                <h3>REGISTRAR PRODUCTO CON EL CLIENTE</h3>


                <% }
                %> 


            </table>
            <br><br>
            <input type="submit" name="Accion" value="<%= request.getParameter("accion") %>">
        
        <a href="RegistroClientes.jsp">Atras</a>
        <br><br><hr>
        <h3>Registrar productos al cliente</h3>
        
        <%  rs=con.realizarConsulta("select id, nombre from producto"); %>
        
        <div >
        <select name="product" id="product">
            <%while (rs.next()) {%>
                <option name="produ" value="<%=rs.getString("id")%>"><%=rs.getString("nombre")%></option>
            <%}%>
        </select>
        <input type="submit" name="registro" value="Registrar Producto">
        
    </div>
        </form>
        <br>
        <br>
        <hr>
        
        
        
</center>
        <%  
            String accion = "";
            String registro="";
            int iddd=Integer.parseInt(request.getParameter("dd"));
            if(request.getParameter("registro")!=null){
                registro=request.getParameter("registro");
                if(registro.equals("Registrar Producto")){
                   
                    int codigo=con.consultaCodigoProducto(request.getParameter("product"));
                      iddd=Integer.parseInt(request.getParameter("dd"));
                    
                    con.ingresarProducto(iddd, codigo);
                %>   
        
  
    
    <%
            }
                
            }
            else{
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

            }}
        %>
        <center>
        <% rs=con.realizarConsulta("Select cliente_producto.id as id_cliente_producto,producto.nombre from producto,clientes,cliente_producto where clientes.id = cliente_producto.id_cliente and producto.id=cliente_producto.id_producto and cliente_producto.id_cliente="+ iddd ); %>
        <table width="60%" border="1" >
            <% while(rs.next()){ %>
            <tr>
            <th>
                #
            </th>
            <th>Producto</th>
            <th>Acción</th>
            </tr>
            <tr>
                <td><%= rs.getString("cliente_producto.id_cliente_producto") %></td>
                <td><%= rs.getString("producto.nombre") %></td>
                <td><a onclick="" href="eliminarProducto.jsp?id_producto=<%= rs.getInt("cliente_producto.id_cliente_producto") %>&acci=<%= request.getParameter("accion") %>&idd=<%= request.getParameter("dd") %>&cedula=<%= request.getParameter("id") %>">ELIMINAR</a></td>
            </tr>
            <% } %>
        </table>
        </center>
        <% con.cierraConexion(); %>
         <%@include file="/source/javascript/javalib.jsp" %>
    </body>
</html>
