
  <%@ page import= "lib.ConexionUsuario" %>
  <%@ page import= "java.sql.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Usuarios</title>
    </head>
    <body>
        
        
        <%

            ResultSet resultado;
            
            String cedula = request.getParameter("cedula");           
            ConexionUsuario conexion = new ConexionUsuario();
           
            resultado = conexion.buscar(cedula);

            while (resultado.next())
        {%> 
        
        
                
        <h1> Editar Usuarios </h1>
           
        <form action ="" method="post">
             <table border ="1"  cellpadding="5" cellspacing="2">
            
            <tr>
                <td bgcolor ="FF8E8E"> <b> Codigo </b> </td>
                <td> <input type= "text" name= "codigo" value = "<%= resultado.getInt("codigo")%>" </td>
            </tr>
             <tr>
                <td bgcolor ="FF8E8E"> <b> Nombre </b> </td>
                <td> <input type= "text" name= "nombre" value = "<%= resultado.getString("nombre")%>" </td>
             <tr>
                <td bgcolor ="FF8E8E"> <b> Apellido </b> </td> 
                <td> <input type= "text" name= "apellido" value = "<%= resultado.getString("apellido")%>" </td> 
             </tr>   
             <tr>
                <td bgcolor ="FF8E8E"> <b> Cedula </b> </td> 
                <td> <%= resultado.getString("cedula")%> </td>  
             </tr>  
             <tr>
                <td bgcolor ="FF8E8E"> <b> Telefono </b> </td> 
          <td> <input type= "text" name= "telefono" value = "<%= resultado.getString("telefono")%>" </td>         
                 
             </tr>
             <tr>
                <td bgcolor ="FF8E8E"> <b> Cargo </b> </td>  
                <td> <input type= "text" name= "cargo" value= "<%= resultado.getString("cargo")%>" </td> 
             </tr>
             
             <tr>
                <td bgcolor ="FF8E8E"> <b> Email </b> </td>
                <td> <input type= "text" name= "email" value = "<%= resultado.getString("email")%>" </td>
             </tr>
                
             <tr>
                <td bgcolor ="FF8E8E"> <b> Password </b> </td> 
                <td> <input type= "text" name= "password" value = "<%= resultado.getString("password")%>" </td> 
             </tr>
            <tr>
                <td bgcolor ="FF8E8E"> <b> Estado </b> </td> 
                <td> <input type= "text" name= "estado" value = "<%= resultado.getString("estado")%>" </td>
            </tr>   
    
             </table> <br><br>
    <%}        
        
        %>
        
        
             <input type ="submit" value ="Guardar"> <br><br>
    
             </form>
        
        
             <a href="Consulta.jsp"> Volver </a>
    </body>
</html>

<% 
   int codigo=0;  
try {
   codigo = Integer.parseInt(request.getParameter("codigo"));
} catch(NumberFormatException e) {  
} 


String nombre = request.getParameter("nombre");
String apellido = request.getParameter("apellido");
String telefono = request.getParameter("telefono");
String cargo = request.getParameter("cargo");
String email = request.getParameter("email");
String password = request.getParameter("password");
String estado = request.getParameter("estado");



    
if (conexion.modificar(codigo, nombre, apellido, cedula, telefono, cargo, email, password, estado)){
response.sendRedirect("Consulta.jsp");    
}

conexion.desconectar();


%>