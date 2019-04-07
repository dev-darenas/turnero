

<%@page import="lib.ConexionUsuario"%>
<%@ page import= "java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


        <title> Registro </title>
        
        
    </head>

    <body>

            <h1>Registro de Usuarios</h1>
            
    <form action = "" method= "post">
            <table border ="1" cellspacing ="4" cellpadding="6" bgcolor="WHITE">
                <tr>
                    <td  bgcolor ="FF8E8E" colspan="2" align = "center" > <font face ="verdana"> <b> Ingrese los datos <b>             
                                </td>
                                </tr>
                                <tr>
                                    <td> <b> Codigo </b> </td>
                                    <td><input type = "text" name = "codigo"></td> 
                                </tr>
                                <tr>
                                    <td> <b> Nombre </b> </td>
                                    <td> <input type = "text" name = "nombre"></td> 
                                </tr>
                                <tr>
                                    <td> <b> Apellido </b> </td>
                                    <td> <input type = "text" name = "apellido"> <br> </td>
                                </tr>
                                <tr>
                                    <td> <b> Cedula </b> </td>
                                    <td> <input type = "text" name = "cedula"> </td>
                                </tr>
                                <tr>
                                    <td> <b> Telefono </b> </td>
                                    <td> <input type = "text" name = "telefono"> </td>
                                </tr>
                                <tr>
                                    <td><b> Cargo </b> </td>
                                    <td><select name = "cargo">
                                            <option> Cajero </option>
                                            <option> Asesor </option>
                                        </select> </td>
                                </tr>
                                <tr>

                                    <td> <b> Email </b> </td>
                                    <td> <input type = "text" name = "email"> </td>
                                </tr>
                                <tr>
                                    <td> <b> Contraseña </b> </td>
                                    <td><input type = "password" name = "password"> </td>
                                </tr>
                                </table><br>
                                
                                <input type ="submit" value="Registrar"> 

                                </form>

                               <form action = "Consulta.jsp" method ="post" >
                                    <input type ="submit" value ="Consultar">

                                </form>
            
            <a href="../../dashboard.jsp">Volver a la pagina principal</a>

     </body>

     </html>
     
<% 
    
int codigo = 0; 
try {
    codigo = Integer.parseInt(request.getParameter("codigo"));
} catch(NumberFormatException e) {  
} 

String nombre = request.getParameter("nombre");
String apellido = request.getParameter("apellido");
String cedula = request.getParameter("cedula");
String telefono = request.getParameter("telefono");
String cargo = request.getParameter("cargo");
String email = request.getParameter("email");
String password = request.getParameter("password");
String estado = "Activo";

ConexionUsuario conexion = new ConexionUsuario();


 if (conexion.registro(codigo, nombre, apellido, cedula, telefono, cargo, email, password, estado)) {
            
            response.sendRedirect("Consulta.jsp");
            conexion.desconectar();
            }

%>
                                

   