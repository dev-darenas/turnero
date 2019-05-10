<%-- 
    Document   : agregarCliente
    Created on : 14/03/2019, 03:17:10 PM
    Author     : usuario
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="lib.ConsultaClientes" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar cliente</title>
    </head>
    <body>
        <%
            ConsultaClientes con1 = new ConsultaClientes();

            ResultSet rs = con1.realizarConsulta("select nombre from producto");

            //listar los datos
        %>
        <h1>Agregar Cliente</h1>
        <hr>
    <center>
        <form method="post" action="">
            Cc:
            <input type="number" name="txt_cc"><br><br>
            Nombre/s:
            <input type="text" name="txt_nombre"><br><br>
            Apellido/s: 
            <input type="text" name="txt_apellido"><br><br>
            Email:
            <input type="email" name="txt_email"><br><br>
            Celular:
            <input type="text" name="txt_cel"><br><br>
            Pais:
            <input type="text" name="txt_pais"><br><br>
            Departamento:
            <input type="text" name="txt_departamento"><br><br>
            Ciudad:
            <input type="text" name="txt_ciudad"><br><br>
            Dirección:
            <input type="text" name="txt_direccion"><br><br>
            Id:
            <input type="text" name="txt_id"><br><br>
            Estado:
            <select name="txt_estado">
                <option>Seleccione</option>
                <option>Activo</option>
                <option>Inactivo</option>
            </select>
            <br><br>
            Notificar Email:
            <input type="radio" name="txt_notificar_email"><br><br>

            Notificar Sms:
            <input type="radio" name="txt_notificar_sms"><br><br>


            <br>
            
           

            


     <hr>
            <a href="RegistroClientes.jsp">Regresar</a>

            <input type="submit"  name="accion" value="Registrar">
        </form>
    </center>

            
<%! int cont=0; %>
    <%

        String accion = "";
        if (request.getParameter("accion") != null) {
            accion = request.getParameter("accion");
        
       
    %>

    
    <%
        

        if (accion.equals("Registrar")) {
             int cc = 0;
        if (request.getParameter("txt_cc") != null) {
            cc = Integer.parseInt(request.getParameter("txt_cc"));
        

            String nombre = request.getParameter("txt_nombre");
            String apellido = request.getParameter("txt_apellido");
            String email = request.getParameter("txt_email");
            String cel = request.getParameter("txt_cel");
            String pais = request.getParameter("txt_pais");
            String departamento = request.getParameter("txt_departamento");
            String ciudad = request.getParameter("txt_ciudad");
            String direccion = request.getParameter("txt_direccion");
            String id = request.getParameter("txt_id");
            String estado = request.getParameter("txt_estado");
            String notificar_email = request.getParameter("txt_notificar_email");
            String notificar_sms = request.getParameter("txt_notificar_sms");

            ConsultaClientes con = new ConsultaClientes();

            con.ingresarCLiente(cc, nombre, apellido, email, cel, pais, departamento, ciudad, direccion, id, estado, notificar_email, notificar_sms);

            rs = con.realizarConsulta("select id from producto where nombre_producto='" + request.getParameter("product") + "'");

            if (rs.next()) {
                out.print("\n-ñ-" + rs.getInt("id"));
                con.ingresarProducto(cc, rs.getInt("id"));
            }

        response.sendRedirect("RegistroClientes.jsp");
            con.cierraConexion();
        }
        }}

    %>
    

</body>
</html>
