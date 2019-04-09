<%-- 
    Document   : index
    Created on : 25/02/2019, 07:30:09 PM
    Author     : Dahian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TITULO</title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <form class="login100-form validate-form" action="Login" >
                        <span class="login100-form-title p-b-26">
                            Bienvenido
                        </span>
                        <p align="center"><img src="logo.png" width="80" height="95">
                        
                        <% if(request.getParameter("error_login") != null){ %>
                            <div class="alert alert-danger" role="alert">
                              email o contraseña erroneas, por favor vuelva a intentarlo.
                            </div>
                        <% } %>
                        <a href="vistas/modulo/list.jsp">Listar Modulo</a>
                        
                        <div class="wrap-input100 validate-input" data-validate = " email: example@b.c">
                            <input class="input100" type="text" name="email">
                            <span class="focus-input100" data-placeholder="Email"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="password">
                            <span class="btn-show-pass">
                                <i class="zmdi zmdi-eye"></i>
                            </span>
                            <input class="input100" type="password" name="pass">
                            <span class="focus-input100" data-placeholder="Password"></span>
                        </div>

                        <div class="container-login100-form-btn">
                            <div class="wrap-login100-form-btn">
                                <div class="login100-form-bgbtn"></div>
                                <button class="login100-form-btn">
                                    Iniciar sesión
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
	</div>
	<div id="dropDownSelect1"></div>
        <%@include file="/source/javascript/javalib.jsp" %>
        
        <% if(request.getParameter("error_login") != null){ %>
            <script>
                $( document ).ready(function() {
                    swal("Turnero", "Email o contraseña erradas!!", "error");
                });
            </script>
        <% } %>

    </body>
</html>
