<%-- 
    Document   : ListadoProducto
    Created on : 26/03/2019, 10:23:28 PM
    Author     : Administrador
--%>
 
 <%@page import=" Controller.RegistroMod" %>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrarse</title>
         <%@include file="/source/styles/styleslib.jsp" %>
    </head>

    <body>
         <%@include file="/componentes/navbar.jsp" %>
         <div class="container">
        <div class="container-contact100">
		<div class="wrap-contact100">
                    <form class="contact100-form validate-form" action="/turnero6/RegistroMod" method="post" >
                        <span class="contact100-form-title">
                            Registrar Modulo
                        </span>
                        
            <div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Nombre</span>
                            <input class="input100" type="text" name="nom" placeholder="Nombre">
                        </div>
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Estado</span>
                            <div class="pretty p-switch">
                                <input name="es" type="checkbox" value="1"/>
                                <div class="state">
                                    <label>Activo?</label>
                                </div>
                            </div>
                        </div>

                        <div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Descripcion</span>
                            <input class="input100" type="text" name="des" placeholder="Descripcion">
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
               
             
    
    </body>
    
</html>
