<%-- 
    Document   : generar
    Created on : 12/05/2019, 10:27:27 PM
    Author     : Dahian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Turno</title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <%@include file="/componentes/navbar.jsp" %>

        <div class="container">
            <div class="container-contact100">
		<div class="wrap-contact100">
                    <form class="contact100-form validate-form" action="/turnero/GenerarTurno" method="post" >
                        <span class="contact100-form-title">
                            Generar Turno
                        </span>
                        
                        <div class="wrap-input100 validate-input bg1" data-validate="Campo obligatorio">
                            <span class="label-input100">No. del documento</span>
                            <input class="input100" type="text" name="cedula" placeholder="No. del documento" >
                        </div>
                        
                        <div class="wrap-input100 input100-select bg1 rs1-wrap-input100">
                            <span class="label-input100">Tipo de Servicio</span>
                            <div>
                                <select class="js-select2" name="tiposervicio">
                                    <option value="2">Asesor</option>
                                    <option value="3">Caja</option>
                                </select>
                                <div class="dropDownSelect2"></div>
                            </div>
                        </div>
                        
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Prioridad</span>
                            <div class="pretty p-switch">
                                <input name="prioridad" type="checkbox" value="1"/>
                                <div class="state">
                                    <label>Activo?</label>
                                </div>
                            </div>
                        </div>
                        
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Notificar whatsapp</span>
                            <div class="pretty p-switch">
                                <input name="notificacion_whatsapp" type="checkbox" value="1"/>
                                <div class="state">
                                    <label>Activo?</label>
                                </div>
                            </div>
                        </div>
                        
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Notificar email</span>
                            <div class="pretty p-switch">
                                <input name="notificacion_email" type="checkbox" value="1"/>
                                <div class="state">
                                    <label>Activo?</label>
                                </div>
                            </div>
                        </div>
                        
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Notificar sms</span>
                            <div class="pretty p-switch">
                                <input name="notificacion_sms" type="checkbox" value="1"/>
                                <div class="state">
                                    <label>Activo?</label>
                                </div>
                            </div>
                        </div>
                        
                        <div style="display: none;" class="wrap-input100 bg1  cel_field" data-validate="Campo obligatorio">
                            <span class="label-input100">Celular</span>
                            <input class="input100" type="text" name="celular" placeholder="Celuar" >
                        </div>
                        
                        <div style="display: none;" class="wrap-input100 bg1  email_field" data-validate="Campo obligatorio">
                            <span class="label-input100">Email</span>
                            <input class="input100" type="text" name="correo" placeholder="Email" >
                        </div>
                        
                        
                        <div class="container-contact100-form-btn">
                            <button class="contact100-form-btn">
                                <span>
                                    Generar
                                    <i class="fa fa-long-arrow-right m-l-7" aria-hidden="true"></i>
                                </span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%@include file="/source/javascript/javalib.jsp" %>
        
        <% if(request.getParameter("turno") != null){ %>
            <script>
                $( document ).ready(function() {
                    swal("Turnero", "Cod Turno: <%= request.getParameter("turno") %>", "success");
                });
            </script>
        <% } %>
        
        <% if(request.getParameter("error") != null){ %>
            <script>
                $( document ).ready(function() {
                    swal("Turnero", "Turno no generado", "error");
                });
            </script>
        <% } %>
    </body>
    <script>
        $( document ).ready(function() {
            $(".js-select2").each(function(){
                $(this).select2({
                    minimumResultsForSearch: 20,
                    dropdownParent: $(this).next('.dropDownSelect2')
                });
            })
            
            $('input[type=checkbox]').change(function(){
                
                if($("[name='notificacion_sms']").is(':checked') || $("[name='notificacion_whatsapp']").is(':checked')){
                    $(".cel_field").show();
                }else{
                    $(".cel_field").hide();
                }

                if($("[name='notificacion_email']").is(':checked')){
                    $(".email_field").show();
                }else{
                    $(".email_field").hide();
                }
            });
            
        });  
    </script>
</html>
