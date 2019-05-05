<%-- 
    Document   : ListadoProducto
    Created on : 26/03/2019, 10:23:28 PM
    Author     : Administrador
--%>
<%@ page import="java.io.*,java.util.*,java.net.*,java.sql.*" %>
<%--aqui se importa la clase conexion que se encuentra la carpeta conexion --%>
<%@page import="lib.ConsultasProducto"%>
<%@page import="java.sql.*"%>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Producto</title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>

    <body>
        <%@include file="/componentes/navbar.jsp" %>
        <div class="container">
        <div class="container-contact100">
		<div class="wrap-contact100">
                     <form class="contact100-form validate-form" action="/turnero6/EditarProducto" method="post">
                        <span class="contact100-form-title">
                            Editar Producto
                        </span>
         
        <%! ConsultasProducto con3 = new ConsultasProducto(); %>
        <%
        int id_producto=Integer.parseInt(request.getParameter("id_producto"));
        
                 ResultSet rs=null;
                 Statement st=null;
                  
               try{
                  
                 st=con3.getConexion().createStatement();
                rs=st.executeQuery("select * from producto where id_producto= "+ id_producto +"");
                rs.next();
                  
             
        %>

        <input type="hidden" name="id" value="<%= rs.getString("id_producto") %>">
        
        <div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">ID</span>
                            <input class="input100" type="text" name="id_producto" placeholder="id_producto" value="<%= rs.getInt(1) %>">
                        </div>
         
         <div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Nombre</span>
                            <input class="input100" type="text" name="nombre" placeholder="Nombre" value="<%= rs.getString(2) %>">
                        </div>
                        <div class="wrap-input100 bg1 rs1-wrap-input100">
                            <span class="label-input100">Estado</span>
                            <div class="pretty p-switch">
                                <input name="es" type="checkbox" value="<%= rs.getString(3) %>"/>
                                <div class="state">
                                    <label>Activo?</label>
                                </div>
                            </div>
                        </div>
                                
                                <div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate="Campo obligatorio">
                            <span class="label-input100">Descrpcion</span>
                            <input class="input100" type="text" name="descripcion" placeholder="Descripcion" value="<%= rs.getString(4) %>">
                        </div>
         
              
                                
                                <div class="container-contact100-form-btn">
                            <span class="fa fa-long-arrow-right m-l-7" aria-hidden="true"></span>
                            <input class="contact100-form-btn" type="submit" name="editar" placeholder="Descripcion" value="EDITAR">
                        </div>
                        
                        
                        
    
                     </form>
            </div>
                    </div>
                    </div>
         
                    
        </form>
               
    
        <%
                            
}catch(Exception e){}
    
%>
       
  
    <% if(request.getParameter("error") != null){ %>
        <script>
            $( document ).ready(function() {
                swal("Turnero", "Producto no actualizado", "error");
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

                $(".js-select2").each(function(){
                    $(this).on('select2:close', function (e){
                        if($(this).val() == "Please chooses") {
                            $('.js-show-service').slideUp();
                        }
                        else {
                            $('.js-show-service').slideUp();
                            $('.js-show-service').slideDown();
                        }
                    });
                });
            })
        });
    </script>
</html>