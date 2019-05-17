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
        <%@include file="/source/styles/styleslib.jsp" %>
        <title>Agregar cliente</title>

    </head>
    <body>
        <%@include file="/componentes/navbar.jsp" %>
        <%
            ConsultaClientes con1 = new ConsultaClientes();

            ResultSet rs = con1.realizarConsulta("select nombre from producto");

            //listar los datos
        %>

        <hr>
    <center>
        <div class="container">
            <div class="container-contact100">
                <div class="wrap-contact100">
                    <form class="contact100-form validate-form" method="post" action="">
                        <span class="contact100-form-title">
                            Registrar Cliente
                        </span>
                        <div class="wrap-input100 validate-input bg1" data-validate="Campo obligatorio">
                            <span class="label-input100">No. del documento</span>
                            <input class="input100" type="text" name="txt_cc" placeholder="No. del documento" >
                        </div>

                        <div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Nombre(s)</span>
                            <input class="input100" type="text" name="txt_nombre" placeholder="Nombre">
                        </div>

                        <div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate = "Campo obligatorio)">
                            <span class="label-input100">Apellido(s)</span>
                            <input class="input100" type="text" name="txt_apellido" placeholder="Apellido">
                        </div>

                        <div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Correo electronico</span>
                            <input class="input100" type="text" name="txt_email" placeholder="E-mail">
                        </div>

                        <div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Celular</span>
                            <input class="input100" type="text" name="txt_cel" placeholder="Celular">
                        </div>
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">PAIS</span>
                            <div>
                                <select class="js-select2" name="txt_pais">
                                    <option value="Colombia" >Colombia</option>

                                </select>
                                <div class="dropDownSelect2"></div>
                            </div>
                        </div>
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">DEPARTAMENTO</span>
                            <div>
                                <select class="js-select2" name="txt_departamento">
                                    <option value="Valle del Cauca" >Valle del cauca</option>

                                </select>
                                <div class="dropDownSelect2"></div>
                            </div>
                        </div>
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">CIUDAD</span>
                            <div>
                                <select class="js-select2" name="txt_ciudad">
                                    <option value="Cali" >Cali</option>

                                </select>
                                <div class="dropDownSelect2"></div>
                            </div>
                        </div>
                        <div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Dirección</span>
                            <input class="input100" type="text" name="txt_direccion" placeholder="Dirección">
                        </div>
                        <div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Id</span>
                            <input class="input100" type="text" name="txt_id" placeholder="Id">
                        </div>
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Estado</span>
                            <div class="pretty p-switch">
                                <input name="txt_estado" type="checkbox" value="1"/>
                                <div class="state">
                                    <label>Activado?</label>
                                </div>
                            </div>
                        </div>

                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Notificar Email</span>
                            <div>
                                <select class="js-select2" name="txt_notificar_email">
                                    <option value="Cali" >t</option>

                                </select>
                                <div class="dropDownSelect2"></div>
                            </div>
                        </div>
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Notificar SMS</span>
                            <div>
                                <select class="js-select2" name="txt_notificar_sms">
                                    <option value="Cali" >t</option>

                                </select>
                                <div class="dropDownSelect2"></div>
                            </div>
                        </div>




                        <br>






                        <hr>
                        <div class="rs1-wrap-input100">
                            <a href="RegistroClientes.jsp">Regresar</a>
                        </div>

                        <div class="container-contact100-form-btn">                                
                            <input class="contact100-form-btn" type="submit"  name="accion" value="Registrar">
                        </div>

                </div>
            </div>
        </div>


    </form>
</center>


<%! int cont = 0;%>
<%        String accion = "";
    if (request.getParameter("accion") != null) {
        accion = request.getParameter("accion");


%>


<%            if (accion.equals("Registrar")) {
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
        }
    }

%>

<%@include file="/source/javascript/javalib.jsp" %>
</body>
</html>
