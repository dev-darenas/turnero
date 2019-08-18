<%-- 
    Document   : ListadoProducto
    Created on : 26/03/2019, 10:23:28 PM
    Author     : Administrador
--%>
<%@ page import="java.io.*,java.util.*,java.net.*,java.sql.*" %>
<%--aqui se importa la clase conexion que se encuentra la carpeta conexion --%>
<%@page import="lib.ConsultasModulo"%>
<%@page import="java.sql.*"%>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar</title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <%@include file="/componentes/navbar.jsp" %>
        <div class="container">
            <div class="container-contact100">
                <div class="wrap-contact100">
                    <form class="contact100-form validate-form" >
                        <span class="contact100-form-title">
                            Editar Modulo
                        </span>

                        <%! ConsultasModulo con3 = new ConsultasModulo(); %>
                        <%
                            int cod_modulo=Integer.parseInt(request.getParameter("cod_modulo"));

                            ResultSet rs=null;
                            Statement st=null;

                            try{ 
                                st = con3.getConexion().createStatement();
                                rs = st.executeQuery("SELECT * FROM modulo WHERE id= "+ cod_modulo +"");

                                rs.next();  
                        %>
    
                        <input type="hidden" name="cod_modulo" placeholder="cod_modulo" value="<%= rs.getInt(1) %>">
     

                        <div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Nombre</span>
                            <input class="input100" type="text" name="nombre" placeholder="Nombre" value="<%= rs.getString(2) %>">
                        </div>

                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Estado</span>
                            <div class="pretty p-switch">
                                <input name="es" type="checkbox" value="1" 
                                       <% if(rs.getInt("estado") == 1 ){ %>
                                        checked
                                       <% } %>
                                       />
                                <div class="state">
                                    <label>Activo?</label>
                                </div>
                            </div>
                        </div>

                        <div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Descrpcion</span>
                            <input class="input100" type="text" name="descripcion" placeholder="Descripcion" value="<%= rs.getString("descripcion") %>">
                        </div>

                        <div class="wrap-input100 input100-select bg1 rs1-wrap-input100">
                            <span class="label-input100">Tipo de Modulo</span>
                            <div>
                                <select class="js-select2" name="tipo_modulo_id">
                                    <option value="1"
                                            <% if(rs.getInt("tipo_modulo_id") == 1 ){ %>
                                                selected
                                            <% } %>
                                            >Caja</option>
                                    <option value="2"
                                            <% if(rs.getInt("tipo_modulo_id") == 2 ){ %>
                                                selected
                                            <% } %>
                                            >Asesor</option>
                                </select>
                                <div class="dropDownSelect2"></div>
                            </div>
                        </div>
                        
                        <div class="container-contact100-form-btn">
                            <span class="fa fa-long-arrow-right m-l-7" aria-hidden="true"></span>
                            <input class="contact100-form-btn" type="submit" name="editar" placeholder="Descripcion" value="EDITAR">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%
            }catch(Exception e){}
    
%>
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