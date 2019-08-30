<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import= "lib.ConexionUsuario" %>
<%@ page import= "java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Registro </title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <%@include file="/componentes/navbar.jsp" %>
           
        <div class="container">
            <div class="container-contact100">
		<div class="wrap-contact100">
                    <form class="contact100-form validate-form" action="/turnero/RegistrarUsuario" method="post" >
                        <span class="contact100-form-title">
                            Registrar Asesor
                        </span>
                        <div class="wrap-input100 input100-select bg1">
                            <span class="label-input100">Tipo de documento</span>
                            <div>
                                <select class="js-select2" name="tipo_documento_id">
                                    <option>Cedula de ciudadania</option>
                                    <option>NIT</option>
                                    <option>Pasaporte</option>
                                </select>
                                <div class="dropDownSelect2"></div>
                            </div>
                        </div>
                        <div class="wrap-input100 validate-input bg1" data-validate="Campo obligatorio">
                            <span class="label-input100">No. del documento</span>
                            <input class="input100" type="text" name="cedula" placeholder="No. del documento" >
                        </div>
                        <div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Nombre(s)</span>
                            <input class="input100" type="text" name="nombre" placeholder="Nombre">
                        </div>

                        <div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate = "Campo obligatorio)">
                            <span class="label-input100">Apellido(s)</span>
                            <input class="input100" type="text" name="apellido" placeholder="Apellido">
                        </div>

                        <div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Telefono</span>
                            <input class="input100" type="text" name="telefono" placeholder="Celular">
                        </div>
                        <div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Correo electronico</span>
                            <input class="input100" type="text" name="email" placeholder="E-mail">
                        </div>
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">ROL</span>
                            <div>
                                <select class="js-select2" name="rol_id">
                                    <option value="1" >Administrativo</option>
                                    <option value="2" >Asesor</option>
                                    <option value="3" >Cajero</option>
                                </select>
                                <div class="dropDownSelect2"></div>
                            </div>
                        </div>
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Estado</span>
                            <div class="pretty p-switch">
                                <input name="estado" type="checkbox" value="1"/>
                                <div class="state">
                                    <label>Activado?</label>
                                </div>
                            </div>
                        </div>
                        <div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Password</span>
                            <input class="input100" type="password" name="password" placeholder="Password">
                        </div>
                        <div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Confirmar Password</span>
                            <input class="input100" type="password" name="password" placeholder="Password">
                        </div>	
                        <div class="container-contact100-form-btn">
                            <button class="contact100-form-btn">
                                <span>
                                    Agregar
                                    <i class="fa fa-long-arrow-right m-l-7" aria-hidden="true"></i>
                                </span>
                            </button>
                        </div>
                    </form>
		</div>
            </div>
        </div>
    <%@include file="/source/javascript/javalib.jsp" %>
    </body>
 
    <% if(request.getParameter("error") != null){ %>
        <script>
            $( document ).ready(function() {
                swal("Turnero", "Usuario no creado", "error");
            });
        </script>
    <% } %>
    
    <script>
        $( document ).ready(function() {
            $(".js-select2").each(function(){
                $(this).select2({
                    minimumResultsForSearch: 20,
                    dropdownParent: $(this).next('.dropDownSelect2')
                });
            })
        });
    </script>
</html>
   