<%-- 
    Document   : AbrirModulo
    Created on : 18/04/2019, 05:12:15 PM
    Author     : Lider Buitrago
--%>

<%@page import="lib.ConexionAbrirModulo"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Asignacion de Modulo</title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
         <%@include file="/componentes/navbar.jsp" %> 
        <% 
            ResultSet resultado;
            ConexionAbrirModulo conexion = new ConexionAbrirModulo();
            resultado = conexion.ModuloDisponibles();
        %>
        <div class="container">
            <div class="container-contact100">
                <div class="wrap-contact100">
                    <form action="ModeloTurno.jsp" method="post">
                        <span class="contact100-form-title">
                            Asignacion de Modulo
                        </span>
                        <label> <b> Ingresar Codigo </b> </label>
                        <br>
                        <input type ="text" name= "id_usuario" value="<%= request.getCookies() %>">
                        <br><br>

                        <div class="wrap-input100 input100-select bg1">
                            <span class="label-input100" Seleccione el modulo abrir</span>
                            <div>
                                <select class="js-select2" name="id_modulo">
                                   <% while (resultado.next())
                                    { 
                                   %>
                                    <option value="<%= resultado.getString("id")%>" > <%= resultado.getString("nombre")%>  </option>
                                    <%
                                      }
                                       conexion.desconectar();
                                    %>
                                </select>
                                <div class="dropDownSelect2"></div>
                            </div>
                        </div>

                        <input type ="submit" value="Abrir modulo" class="btn btn-primary">
                        <a href="/turnero/dashboard.jsp" class="btn "> Volver </a>
                    </form>
                </div>
            </div>

        </div>
        <%@include file="/source/javascript/javalib.jsp" %>
    </body>
    
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




