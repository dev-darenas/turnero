<%-- 
    Document   : ModeloTurno
    Created on : 18/04/2019, 06:52:54 PM
    Author     : Lider Buitrago
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="lib.ConexionAbrirModulo"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Llamar turnos</title>
        <%@include file="/source/styles/styleslib.jsp" %>
    </head>
    <body>
        <%@include file="/componentes/navbar.jsp" %>
        <%  
            Cookie[] cookieList = request.getCookies();
            
            String user_id = "";
            String id_rol = "";
            for (int i = 0; i < cookieList.length; i++) { 
                if(cookieList[i].getName().equals("id_user")){
                    user_id = cookieList[i].getValue();
                }
            } 
        %>
    <%
        ResultSet resultado1;
        String nombre = "";

        ConexionAbrirModulo conexion = new ConexionAbrirModulo();
        int id_usuario = Integer.parseInt(user_id);
        String id_modulo = "";
        
        if(request.getParameter("id_modulo") != null ){
            id_modulo = request.getParameter("id_modulo");

            conexion.ActivarModulo(id_modulo, id_usuario);
            resultado1= conexion.ObtenerNombre(id_usuario);

            resultado1.next();

            nombre = resultado1.getString("nombre");
            conexion.actualizarEstado1(id_modulo);       
        } 
%>

        <h1> Modulo <%= id_modulo %></h1>
        <br> 
        
        <label> Bienvenido <b> <%= nombre %>  </b> </label>
        <br><br>
        
        <table border ="1" cellspacing ="4" cellpadding="6" bgcolor="FFFFFF">
            <tr>
            <td bgcolor ="FF8E8E">  <b> Turno Actual  </b> </td>
            </tr>
            <tr>
                 <td>   A12  </td>
            </tr>
            <tr>
                <td bgcolor ="FF8E8E"> <b>  Proximos Turnos </b>  </td>
            </tr>
            <tr>
                 <td>   A13  </td>
            </tr>
            <tr>
                 <td>   A14  </td>
           </tr>
        </table>
        <br> <br>
        
        <% 
        ResultSet resultado2;
        int codigo;
        
       resultado2 = conexion.codigo(id_modulo, id_usuario);
       resultado2.next();
       
       codigo = resultado2.getInt("id");
        
        conexion.desconectar();

%>
        
        
        <input type ="submit" value ="Llamar turno">
        
        <form action = "Cerrar.jsp" method = "post">
            
            <input type="hidden" name="modulo" value= "<%=id_modulo%>" >
            <input type="hidden" name="codigo" value= "<%=codigo%>" >
       
            <input type ="submit" value ="Cerrar Sesion">
        
        </form>
    
        
    </body>
    <%@include file="/source/javascript/javalib.jsp" %>
</html>
